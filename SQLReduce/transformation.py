from lark import Transformer, v_args, Discard
from lark import Tree
from lark.lexer import Token
from typing import Iterator, Tuple, Optional
from named_tree import NamedTree, NamedTreeConstructor, DataToken
from itertools import combinations
from math import comb
import logging
from time import time


class Transformable:
    def transform(self, tree):
        raise NotImplementedError


class AbstractTransformationsIterator(Transformable):
    """
    The all_transforms method should yield all transformations that can be
    performed by a given reducer. The parameter progress is used to resume
    the iterator from where it left off. This avoids the problem that the first
    reduction opportunities are attempted for each invocation of all_transforms,
    while later reduction opportunities are never reached.
    """

    def __init__(self, remove_list=None, multi_remove=True):
        self.num_actions = 0
        self.index = 0
        if remove_list is None:
            remove_list = []
        self.remove_list = remove_list
        self.multi_remove = multi_remove

    def gen_reduction_params(self, tree):
        self.set_up([])
        _ = self.transform(tree)
        return range(self.index)

    def set_up(self, remove_list):
        self.remove_list = remove_list
        self.index = 0

    def all_transforms(self, tree: Tree, progress: int = 0) -> Iterator[Tuple[int, Tree]]:
        # TODO: turn multi_remove flag into more general strategy-hint, e.g. {single, aggressive, consecutive(k)}
        if not self.multi_remove:
            logging.info("Running without multiremove")
            skipped = []
            for i, item in enumerate(self.gen_reduction_params(tree)):
                if i < progress:
                    skipped.append(item)
                    continue
                self.set_up([item])
                yield i, self.transform(tree)
            for i, item in enumerate(skipped):
                self.set_up([item])
                yield i, self.transform(tree)
        else:
            logging.info("Running with multiremove")
            reduction_params = list(self.gen_reduction_params(tree))
            block_size = len(reduction_params)
            self.num_actions = len(reduction_params)
            while block_size >= 1:
                num_blocks = len(reduction_params) // block_size
                # check if there is an extra block at the end
                if len(reduction_params) % block_size != 0:
                    num_blocks += 1
                for i in range(num_blocks):
                    logging.info(reduction_params)
                    self.set_up(reduction_params[i * block_size: (i + 1) * block_size])
                    logging.info(f"Set up with: {self.remove_list}")
                    yield 0, self.transform(tree)
                block_size = block_size // 2


class PrettyPrinter(Transformer):
    """
    Computes the string representation of an SQL parse-tree
    """
    def __default_token__(self, token):
        return token.value

    @v_args(tree=True)
    def sql_stmt(self, tree):
        s = ""
        for c in tree.children:
            s += (c + ' ')
        s = s.rstrip()
        return s.lstrip() + ';\n'

    def sql_stmt_list(self, children):
        return self._list(children, '').rstrip('\n')

    def column_list(self, children):
        return self._list(children)

    def values_list(self, children):
        return self._list(children)

    def value_tuple(self, children):
        return '(' + self._list(children) + ')'

    def subquery_or_expr_list(self, children):
        return self._list(children)

    def column_def_list(self, children):
        return self._list(children)

    def list_expr(self, children):
        return '(' + self._list(children) + ')'

    def _list(self, children, sep=', '):
        """
        Return string representation of common list like patterns (e.g. list of
        columns in an INSERT statement).
        :param children:
        :return:
        """
        s = ""
        for c in children:
            s += (c + sep)
        return s.rstrip(sep)

    def __default__(self, data, children, meta):
        s = ""
        for c in children:
            # no space before ";", ")", ","
            if c == ";" or c == ")" or c == "," or c == ".":
                s = s.rstrip()
            s += (c + " ")
            if c == "(" or c == "::" or c == ".":
                s = s.rstrip()
        return s.rstrip()


class StatementRemover(AbstractTransformationsIterator):
    """
    Remove the statements at the indices indicated by remove_indices.

    :param: remove_indices: list or set of integers. Overwritten by all_transforms
    :param: max_iterations: all_transforms yields at most this many reductions
    """
    def __init__(self, remove_list=None, multi_remove=True):
        AbstractTransformationsIterator.__init__(self, remove_list=remove_list, multi_remove=True)

    def transform(self, tree: Tree) -> Tree:
        """
        Remove the statements at the indices in remove_indices.
        :param tree:
        :return:
        """
        assert tree.data == 'sql_stmt_list'
        self.remove_list.sort()
        new_children = []
        i = 0  # index into self.remove_indices
        # iterate over children, only copying those that remain
        for j, c in enumerate(tree.children):
            if i < len(self.remove_list) and j == self.remove_list[i]:
                i += 1
            else:
                new_children.append(c)
        return Tree('sql_stmt_list', new_children, tree.meta)

    def gen_reduction_params(self, tree):
        for i in range(len(tree.children)):
            yield i


class StatementRemoverByType(AbstractTransformationsIterator):
    """
    Remove sql statements by type of the statement. E.g. run:
        self.set_up(['insert_stmt'])
        reduced = self.transform(tree)
    to remove all insert statements from the tree.
    Consult sql.lark or run self.gen_reduction_params(tree) to find
    other types of statements that can be removed.
    """
    def __init__(self, remove_list=None, multi_remove=False):
        super().__init__(remove_list=remove_list, multi_remove=multi_remove)

    def transform(self, tree):
        print(self.remove_list)
        if tree.data != 'sql_stmt_list':
            raise ValueError('StatementRemoverByType: root of tree must be sql_stmt_list')
        new_children = []
        for c in tree.children:
            if len(c.children) == 0:
                logging.debug(f'StatementRemoverByType: Unexpectedly encountered empty node: {c}')
                continue
            if c.children[0].data not in self.remove_list:
                new_children.append(c)
        return NamedTree('sql_stmt_list', new_children, tree.meta)

    def gen_reduction_params(self, tree):
        if tree.data != 'sql_stmt_list':
            raise ValueError('StatementRemoverByType: root of tree must be sql_stmt_list')
        types = set()
        for c in tree.children:
            if len(c.children) == 0:
                logging.debug(f'StatementRemoverByType: Unexpectedly encountered empty node: {c}')
                continue
            t = c.children[0].data
            if t not in types:
                yield t
                types.add(t)


class ValueMinimizer(Transformer, AbstractTransformationsIterator):
    """
    Reduce string and number (int or float) literals.
    """
    def __init__(self, remove_list=None, multi_remove=True, replace_str: Optional[str] = None,
                 replace_int: Optional[str] = None, replace_float: Optional[str] = None):
        """
        Parameters remove_list and multi_remove have the same function as in the
        base class AbstractTransformationsIterator.
        Parameters replace_str, ...int, ...float set the replacement value for string
        or number literals. For number literals, NUM(token) automatically decides
        if token is a float or int. If any of the replace_... parameters is set to
        None, that class of tokens will not be counted and thus won't be reduced.

        Note: all_transforms overwrites all parameters except multi_remove.
        :param remove_list: passed to AbstractTransformationsIterator, only affects transform(), overwritten by all_transforms()
        :param multi_remove: passed to AbstractTransformationsIterator, only affects all_transforms()
        :param replace_str: replacement value for string literals. If None, don't reduce string literals
        :param replace_int: replacement value for int literals. If None, don't reduce int literals
        :param replace_float: replacement value for float(-like) literals. If None, don't reduce float literals
        """
        Transformer.__init__(self)
        AbstractTransformationsIterator.__init__(self, remove_list=remove_list, multi_remove=multi_remove)
        self.replace_str = replace_str
        self.replace_int = replace_int
        self.replace_float = replace_float

    def VALUE(self, token):
        if token.value.startswith("'") or token.value.startswith('"'):
            return self.STRING(token)
        else:
            return self.NUM(token)

    def NUM(self, token):
        # NUM not defined in sql.lark, but in unrecognized.lark

        # check if value is int
        try:
            int(token.value)
            is_int = True
        except ValueError:
            is_int = False

        # replace if necessary, count if applicable
        if is_int and self.replace_int is not None:
            if self.index in self.remove_list:
                token = DataToken(token.type, self.replace_int)
            self.index += 1
        elif not is_int and self.replace_float is not None:
            if self.index in self.remove_list:
                token = DataToken(token.type, self.replace_float)
            self.index += 1
        return token

    def STRING(self, token):
        # from unrecognized.lark
        if self.replace_str is None:
            return token
        if self.index in self.remove_list:
            token = DataToken(token.type, self.replace_str)
        self.index += 1
        return token

    def all_transforms(self, tree: Tree, progress: int = 0) -> Iterator[Tuple[int, Tree]]:
        """
        Important: since some replacement values (e.g. NULL) can be longer than the
        original value, the result might be longer than the input!

        Invoke all_transforms of superclass for the following replacement values:
        str: "''", "NULL"
        int/float: "0", "-1", "1", "NULL"
        :param tree: parse tree that should be reduced
        :param progress: ignored
        :return:
        """
        # first attempt to reduce string literals
        for replace_str in ["''", "NULL"]:
            self.replace_str = replace_str
            self.replace_int = None
            self.replace_float = None
            for res in AbstractTransformationsIterator.all_transforms(self, tree):
                yield res
        # reduce number literals
        for replace_int, replace_float in [('0', '0.0'), ('-1', '-1.0'), ('1', '1.0'), ('NULL', 'NULL')]:
            self.replace_str = None
            self.replace_int = replace_int
            self.replace_float = replace_float
            for res in AbstractTransformationsIterator.all_transforms(self, tree):
                yield res


class SROC(AbstractTransformationsIterator):
    """
    Scalar Replacement Of Column names in expressions
    """
    def __init__(self, remove_list=None, multi_remove=True, replacement_value='0'):
        AbstractTransformationsIterator.__init__(self, remove_list=remove_list, multi_remove=multi_remove)
        self.replacement_value = replacement_value
        self.in_from_clause = 0

    def _default(self, tree):
        return NamedTree(tree.data, list(map(self.transform, tree.children)), tree.meta)

    def transform(self, tree):
        if issubclass(type(tree), Token):
            return tree
        if type(tree) != NamedTree:
            tree = NamedTreeConstructor().transform(tree)
        if tree.data == 'expr_helper':
            return self.expr_helper(tree)
        elif tree.data == 'from_clause':
            self.in_from_clause += 1
            res = self._default(tree)
            self.in_from_clause -= 1
            return res
        elif tree.data == 'select_stmt':
            # reset in_from_clause. This is necessary to allow reductions
            # in subqueries in statements that are of the form ... FROM (subquery)
            tmp = self.in_from_clause
            self.in_from_clause = 0
            res = self._default(tree)
            self.in_from_clause = tmp
            return res
        else:
            return self._default(tree)

    def expr_helper(self, tree):
        column_name = tree['column_name', 0]
        if column_name is not None and self.in_from_clause == 0:
            if self.index in self.remove_list:
                tree = NamedTree(tree.data, [DataToken('VALUE', self.replacement_value)], tree.meta)
            self.index += 1
            return tree
        return self._default(tree)

    def set_up(self, remove_list):
        super().set_up(remove_list)
        self.in_from_clause = 0

    def all_transforms(self, tree: Tree, progress: int = 0) -> Iterator[Tuple[int, Tree]]:
        for val in ["''", '0', '1', '-1', 'NULL']:
            self.replacement_value = val
            for res in AbstractTransformationsIterator.all_transforms(self, tree):
                yield res


class BalancedParenRemover(Transformer, AbstractTransformationsIterator):
    def __init__(self, remove_list=None, multi_remove=True):
        Transformer.__init__(self)
        AbstractTransformationsIterator.__init__(self, remove_list=remove_list, multi_remove=multi_remove)

    def __default__(self, data, children, meta):
        par_indices = []  # list of tuples of indices of corresponding LPAREN and RPAREN
        local_remove_list = []
        stack = []

        # find all indices of corresponding parentheses
        # e.g. for "(( expr ))", par_indices will be [(0, 4), (1, 3)]
        for i, c in enumerate(children):
            if issubclass(type(c), Token):
                if c.value == '(':
                    stack.append(i)
                elif c.value == ')':
                    par_indices.append((stack.pop(-1), i))

        # find indices of pairs of parentheses that are marked for removal
        for i, par_index in enumerate(par_indices):
            if self.index + i in self.remove_list:
                local_remove_list += list(par_index)

        # increment global index by number of balance parenthesis pairs
        self.index += len(par_indices)

        # sort indices descending and delete
        local_remove_list.sort(reverse=True)
        if len(local_remove_list) > 0:
            children = [c for c in children]
        for i in local_remove_list:
            del children[i]
        return NamedTree(data, children, meta)


class ExprSimplifier(Transformer, AbstractTransformationsIterator):
    def __init__(self, remove_list=None, multi_remove=True):
        Transformer.__init__(self)
        AbstractTransformationsIterator.__init__(self, remove_list=remove_list, multi_remove=multi_remove)

    def expr(self, children):
        new_children = [c for c in children]
        local_remove_list = []
        offset = 0
        if children[0].data == "k_not":
            offset = 1
            if self.index in self.remove_list:
                local_remove_list.append(0)
            self.index += 1
        if len(children) > 2:
            if self.index in self.remove_list:
                local_remove_list += [offset+1, offset+2]
            elif self.index + 1 in self.remove_list:
                new_children[-1:] = new_children[-1].children
                local_remove_list += [offset, offset+1]
            self.index += 2
        for i in local_remove_list[::-1]:
            del new_children[i]
        return Tree("expr", new_children)

    def expr_helper(self, children):
        local_remove_list = []
        new_children = [c for c in children]
        if issubclass(type(children[0]), Tree):
            if children[0].data == "k_cast":
                if self.index in self.remove_list:
                    local_remove_list += [0, 3, 4]
                self.index += 1
            elif children[0].data == "k_nullif":
                if self.index in self.remove_list:
                    local_remove_list += [0, 3, 4]
                elif self.index + 1 in self.remove_list:
                    local_remove_list += [0, 2, 3]
                self.index += 2
        else:
            if len(children) == 3 and children[0].type == 'LPAREN' and children[2].type == 'RPAREN':
                if self.index in self.remove_list:
                    local_remove_list += [0, 2]
                self.index += 1
        for i in local_remove_list[::-1]:
            del new_children[i]
        return Tree("expr_helper", new_children)

    def transform(self, tree):
        return Transformer.transform(self, tree)


class SimpleColumnRemover(AbstractTransformationsIterator):
    """
    A simple reduction pass that tries to remove single columns from insert,
    update and create table statements. It doesn't handle aliases and doesn't
    guarantee syntactically valid results (although most results probably are
    syntactically valid). The index is counted across all column references.
    Example:
        INSERT INTO t0 VALUES (2, 1); INSERT INTO t1 (c0) VALUES (3);
        UPDATE t0 SET c2=1;
        2 is at index 0.
        c0 is at index 2.
        c2 is at index 3.

    :param remove_list: list of indices of columns that should be removed.
    """
    def _default(self, tree):
        return NamedTree(tree.data, list(map(self.transform, tree.children)))

    def transform(self, tree):
        if type(tree) == DataToken:
            return tree.__deepcopy__(None)
        if type(tree) != NamedTree:
            tree = NamedTreeConstructor().transform(tree)
        if tree.data == 'create_table_stmt':
            return self.create_table_stmt(tree)
        elif tree.data == 'insert_stmt' or tree.data == 'upsert_stmt':
            return self.insert_stmt(tree)
        elif tree.data == 'update_stmt':
            return self.update_stmt(tree)
        elif tree.data == 'sql_stmt_list':
            # reset at root of parse tree
            self.index = 0
            return self._default(tree)
        else:
            return self._default(tree)

    def create_table_stmt(self, tree: NamedTree):
        """
        Create table statement grammar:
        k_create k_table table_name LPAREN column_def_list RPAREN
        :param tree:
        :return:
        """
        column_defs = tree['column_def_list'][0]
        num_columns = len(column_defs.children)
        # compute list of indices that map to children of this node(filter) and align to 0 (map)
        local_remove_list = sorted(filter(lambda x: 0 <= x < num_columns, map(lambda x: x - self.index, self.remove_list)),
                                   reverse=True)
        if len(local_remove_list) > 0:
            tree = tree.__deepcopy__(None)
        for i in local_remove_list:
            del tree['column_def_list'][0].children[i]
        self.index += num_columns
        return tree

    def insert_stmt(self, tree: NamedTree):
        """
        Insert statement grammar:
        k_insert k_into table_name (LPAREN column_list RPAREN)? k_values values_list
        :param tree:
        :return:
        """
        values_list = tree['values_list'][0]
        num_columns = len(values_list['value_tuple'][0].children)
        # compute list of indices that map to children of this node(filter) and align to 0 (map)
        local_remove_list = sorted(filter(lambda x: 0 <= x < num_columns, map(lambda x: x - self.index, self.remove_list)),
                                   reverse=True)
        if len(local_remove_list) > 0:
            tree = tree.__deepcopy__(None)
        for i in local_remove_list:
            column_list = tree['column_list', 0]
            if column_list:
                del column_list.children[i]

            # update values_list to new tree
            values_list = tree['values_list'][0]
            for value_tuple in values_list['value_tuple']:
                del value_tuple.children[i]
        self.index += num_columns
        return tree

    def update_stmt(self, tree: NamedTree):
        """
        Update statement grammar:
        k_update table_name k_set assign_list where_clause?
        :param tree:
        :return:
        """
        # an assignment consists of [column_name, EQUAL, VALUE], thus divide by 3
        assert len(tree['assign_list', 0].children) % 3 == 0
        num_columns = len(tree.children[3].children) // 3
        # compute list of indices that map to children of this node(filter) and align to 0 (map)
        local_remove_list = sorted(filter(lambda x: 0 <= x < num_columns, map(lambda x: x - self.index, self.remove_list)),
                                   reverse=True)
        if len(local_remove_list) > 0:
            tree = tree.__deepcopy__(None)
        for i in local_remove_list:
            assignment_list = tree['assign_list', 0]
            # delete [column_name, EQUAL, VALUE]
            del assignment_list.children[3*i:3*(i+1)]
        self.index += num_columns
        return tree


class Canonicalizer(Transformer, AbstractTransformationsIterator):
    """
    The canonicalizer can simplify upsert to insert and can replace the types of
    column definitions (in create table statements) to INT.
    Canonicalization is only possible on statements that were parsed with sql.lark.
    """
    def __init__(self, remove_list=None, multi_remove=True):
        Transformer.__init__(self)
        AbstractTransformationsIterator.__init__(self, remove_list=remove_list, multi_remove=multi_remove)

    @v_args(tree=True)
    def upsert_stmt(self, tree):
        # reduce upsert to insert
        if self.index in self.remove_list:
            tree = NamedTree('insert_stmt', tree.children)
            tree.children[0] = NamedTree('k_insert', [DataToken('INSERT', 'INSERT')])
        self.index += 1
        return tree

    @v_args(meta=True)
    def column_def(self, children, meta):
        tree = NamedTree('column_def', children, meta)
        # reduce type to INT
        t = tree['sql_type', 0]
        if t is not None:
            if self.index in self.remove_list:
                tree.children[1] = NamedTree('sql_type', [DataToken('NAME', 'INT')])
            self.index += 1
        return tree


class CompoundSimplifier(Transformer, AbstractTransformationsIterator):
    """
    Simplify compound expressions (UNION, INTERSECT, EXCEPT).
    """
    def __init__(self, remove_list=None, multi_remove=True):
        Transformer.__init__(self)
        AbstractTransformationsIterator.__init__(self, remove_list=remove_list, multi_remove=multi_remove)

    @v_args(meta=True)
    def select_stmt_helper(self, children, meta):
        tree = NamedTree('select_stmt_helper', children, meta)
        rhs = tree['select_stmt', 0]
        lhs = tree['select_stmt_helper', 0]
        if lhs is not None:
            if rhs is not None:
                return tree
            else:
                return lhs
        else:
            if rhs is not None:
                return NamedTree('select_stmt_helper', [rhs])
            else:
                raise Discard

    def select_stmt(self, children):
        self.index += 1
        if self.index - 1 in self.remove_list:
            raise Discard
        return NamedTree('select_stmt', children)

    def __default__(self, data, children, meta):
        return NamedTree(data, children, meta)

    def transform(self, tree: Tree) -> NamedTree:
        if type(tree) != NamedTree:
            tree = NamedTreeConstructor().transform(tree)
        return super().transform(tree)


class OptionalFinder(Transformer):
    def __init__(self, t='?'):
        super().__init__()
        self.type = t

    def expr(self, children):
        optionals = set()
        for i in range(len(children) - 1):
            if type(children[i + 1]) == Token and children[i + 1].value == self.type:
                if type(children[i]) == Tree and children[i].data == 'name':
                    optionals.add(children[i].children[0].value)
                elif type(children[i]) == Token:
                    optionals.add(children[i].value)
        return optionals

    def expansion(self, children):
        optionals = set()
        for c in children:
            if type(c) == set:
                optionals = optionals | c
        return optionals

    def expansions(self, children):
        optionals = set()
        for c in children:
            if type(c) == set:
                optionals = optionals | c
        return optionals

    def rule(self, children):
        rule_name = children[0].value
        for c in children:
            if type(c) == set:
                return rule_name, c
        return rule_name, set()

    def start(self, children):
        optionals = dict()
        for c in children:
            if type(c) == tuple:
                optionals[c[0]] = c[1]
        return optionals


class OptionalRemover(Transformer, AbstractTransformationsIterator):
    def __init__(self, remove_list=None, multi_remove=False, optionals=None):
        Transformer.__init__(self)
        AbstractTransformationsIterator.__init__(self, remove_list=remove_list, multi_remove=True)
        if optionals is None:
            optionals = dict()
        self.optionals = optionals

    def __default__(self, data, children, meta):
        try:
            removable = self.optionals[data]
        except KeyError:
            removable = set()

        remove_list = []
        for i, c in enumerate(children):
            if type(c) == Tree and c.data in removable:
                if self.index in self.remove_list:
                    remove_list.append(i)
                self.index += 1
            elif type(c) == Token and c.value in removable:
                if self.index in self.remove_list:
                    remove_list.append(i)
                self.index += 1

        for i in remove_list[::-1]:
            del children[i]

        return Tree(data, children, meta)


class ListItemRemover(AbstractTransformationsIterator):
    """
    Simultaneously remove multiple items from list expressions in an unexpected
    statement.
    """
    def __init__(self, remove_index=(0, 0), multi_remove=True):
        super().__init__(multi_remove=multi_remove)
        self.remove_index = remove_index
        self.stmt_index = -1
        self.list_expr_max_length = []

    def _default(self, tree):
        return NamedTree(tree.data, list(map(self.transform, tree.children)))

    def transform(self, tree):
        if type(tree) == DataToken:
            return tree.__deepcopy__(None)

        if type(tree) != NamedTree:
            tree = NamedTreeConstructor().transform(tree)

        if tree.data == 'unexpected_stmt':
            return self.unexpected_stmt(tree)
        elif tree.data == 'list_expr':
            return self.list_expr(tree)
        else:
            return self._default(tree)

    def unexpected_stmt(self, tree):
        self.list_expr_max_length.append(0)
        self.stmt_index += 1
        return self._default(tree)

    def list_expr(self, tree):
        self.list_expr_max_length[-1] = max(self.list_expr_max_length[-1], len(tree.children))
        if self.stmt_index == self.remove_index[0]:
            if self.remove_index[1] < len(tree.children):
                tree = tree.__deepcopy__(None)
                del tree.children[self.remove_index[1]]
        return tree

    def set_up(self, item):
        self.remove_index = item
        self.stmt_index = -1
        self.list_expr_max_length = []

    def gen_reduction_params(self, tree):
        self.set_up((0, 0))
        _ = self.transform(tree)
        num_stmts = self.stmt_index + 1
        max_lengths = [x for x in self.list_expr_max_length]
        for i in range(0, num_stmts):
            for j in range(0, max_lengths[i]):
                yield i, j


class TokenRemover(Transformer, AbstractTransformationsIterator):
    def __init__(self, remove_indices=None, multi_remove=False):
        Transformer.__init__(self)
        AbstractTransformationsIterator.__init__(self, multi_remove=False)
        if remove_indices is None:
            remove_indices = []
        self.remove_indices = remove_indices
        self.token_index = 0
        self.stmt_index = 0
        self.num_options_per_stmt = []

    def __default_token__(self, token):
        if token.value in '(),;':
            return token
        self.token_index += 1
        if (self.stmt_index, self.token_index - 1) in self.remove_indices:
            raise Discard
        return token

    def __default__(self, data, children, meta):
        # delete '(' directly followed by ')'
        empty_paren_indices = []  # store indices of empty parentheses for removal
        for i in range(len(children) - 1):
            if issubclass(type(children[i]), Token)\
                    and issubclass(type(children[i+1]), Token):
                if children[i].value == '(' and children[i+1].value == ')':
                    empty_paren_indices.append(i)
                    empty_paren_indices.append(i+1)
        # traverse in reverse order to avoid index errors after deletion
        for i in empty_paren_indices[::-1]:
            del children[i]
        if len(children) == 0:
            raise Discard
        return NamedTree(data, children, meta)

    @v_args(tree=True)
    def sql_stmt(self, tree):
        self.num_options_per_stmt.append(self.token_index)
        self.token_index = 0
        self.stmt_index += 1
        return self.__default__(tree.data, tree.children, tree.meta)

    @v_args(meta=True)
    def sql_stmt_list(self, children, meta):
        return NamedTree('sql_stmt_list', children, meta)

    def set_up(self, item):
        self.remove_indices = item
        self.token_index = 0
        self.stmt_index = 0
        self.num_options_per_stmt = []

    def gen_reduction_params(self, tree):
        max_consec = 3
        self.set_up([])
        _ = self.transform(tree)
        self.num_actions = sum(
            map(lambda x: sum([x - i + 1 for i in range(1, max_consec + 1)]),
                self.num_options_per_stmt))
        for num_consec in range(1, max_consec + 1):
            for i, num_options in enumerate(self.num_options_per_stmt):
                for j in range(num_options - num_consec + 1):
                    yield [(i, x) for x in range(j, j + num_consec)]

    def all_transforms(self, tree: Tree, progress: int = 0) -> Iterator[Tuple[int, Tree]]:
        skipped = []
        for i, param in enumerate(self.gen_reduction_params(tree)):
            if i < progress:
                skipped.append(param)
                continue
            self.set_up(param)
            yield i, self.transform(tree)
        for i, param in enumerate(skipped):
            self.set_up(param)
            yield i, self.transform(tree)


class TokenRemoverNonConsec(TokenRemover):
    def gen_reduction_params(self, tree):
        max_simult = 2
        self.set_up([])
        _ = self.transform(tree)
        self.num_actions = sum(
            map(lambda x: sum([comb(x, i) for i in range(2, max_simult + 1)]), self.num_options_per_stmt))
        for i, j in enumerate(self.num_options_per_stmt):
            # start with removing 2 tokens at once since the cases with just one
            # have been yielded already
            for k in range(2, max_simult + 1):
                for c in combinations(range(0, j), k):
                    yield [(i, x) for x in c]
