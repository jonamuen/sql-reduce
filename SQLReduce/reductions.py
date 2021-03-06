from lark import Transformer, v_args, Discard, Tree
from lark import Tree
from lark.lexer import Token
from typing import Iterator, Tuple, Optional
from .named_tree import NamedTree, NamedTreeConstructor, DataToken
from itertools import combinations
from math import comb
import logging


class AbstractTransformationsIterator:
    """
    The all_transforms method should yield all transformations that can be
    performed by a given reducer. The parameter progress is used to resume
    the iterator from where it left off. This avoids the problem that the first
    reduction opportunities are attempted for each invocation of all_transforms,
    while later reduction opportunities are never reached.

    Note: progress is ignored if multi_remove is True.

    Generally, it is preferable to use the all_transforms iterator, since it
    handles generation of reduction parameters and calls to set_up. If it is
    necessary to generate only a specific reduction, snippet works for all
    classes that don't override the default all_transforms method:
        tr = MyTransformer()
        params = [x for x in gen_reduction_params(tree)]
        tr.set_up(sublist_of_params)
        tr.transform(tree)
    """

    def __init__(self, remove_list=None, multi_remove=True):
        """
        Set up a reduction pass. remove_list is a list of parameters that tell
        the transform() method where it should perform a reduction.

        multi_remove is used by all_transforms. Check its documentation.
        :param remove_list:
        :param multi_remove:
        """
        self.num_actions = 0
        self.index = 0
        if remove_list is None:
            remove_list = []
        self.remove_list = remove_list
        self.multi_remove = multi_remove

    def gen_reduction_params(self, tree):
        """
        Provide an iterator of valid reduction parameters for a given tree. For
        instance, the default implementation yields all indices of reducible items.
        :param tree:
        :return:
        """
        self.set_up([])
        _ = self.transform(tree)
        self.num_actions = self.index
        return range(self.index)

    def set_up(self, remove_list):
        self.remove_list = remove_list
        self.index = 0

    def transform(self, tree):
        raise NotImplementedError

    def all_transforms(self, tree: Tree, progress: int = 0) -> Iterator[Tuple[int, Tree]]:
        """
        Yield progress information and reduction candidates for a tree.

        If self.multi_remove is set to true, all_transforms
        will first set_up with all parameters provided by gen_reduction_params,
        then split the list of parameters in half and proceed recursively on both
        halves (just conceptually, the actual implementation is not recursive).

        Example:
            multi_remove is True
            [0,1,2,3] == list(gen_reduction_params(...))
            The following parameters will be passed to set_up before the call to transform:
                [0,1,2,3]
                [0,1]
                [2,3]
                [0]
                [1]
                ...

        :param tree: Parse tree to reduce
        :param progress: Resume reduction from here. Ignored if multi_remove == True.
        :return: iterator of tuples of progress information and reduction candidates.
        """
        if not self.multi_remove:
            skipped = []
            for i, item in enumerate(self.gen_reduction_params(tree)):
                if i < progress:
                    skipped.append(item)
                    continue
                self.set_up([item])
                yield i, self.transform(tree)
            self.num_actions = len(skipped)
            for i, item in enumerate(skipped):
                self.set_up([item])
                yield i, self.transform(tree)
        else:
            reduction_params = list(self.gen_reduction_params(tree))
            block_size = len(reduction_params)

            # compute number of reduction attempts
            self.num_actions = 0
            while block_size >= 1:
                self.num_actions += len(reduction_params) // block_size
                if len(reduction_params) % block_size != 0:
                    self.num_actions += 1
                block_size = block_size // 2

            # actually perform reductions
            counter = 0
            block_size = len(reduction_params)
            while block_size >= 1:
                num_blocks = len(reduction_params) // block_size
                # check if there is an extra block at the end
                if len(reduction_params) % block_size != 0:
                    num_blocks += 1
                for i in range(num_blocks):
                    logging.debug(reduction_params)
                    self.set_up(reduction_params[i * block_size: (i + 1) * block_size])
                    logging.debug(f"Set up with: {self.remove_list}")
                    yield counter, self.transform(tree)
                    counter += 1
                block_size = block_size // 2

    def __str__(self):
        return type(self).__name__


class ReductionPassBottomUp(Transformer, AbstractTransformationsIterator):
    """Base class for reduction passes that don't need a custom transform() function"""
    def __init__(self, remove_list=None, multi_remove=True):
        Transformer.__init__(self)
        AbstractTransformationsIterator.__init__(self, remove_list=remove_list, multi_remove=multi_remove)


class BalancedParenRemover(ReductionPassBottomUp):
    """
    Remove balanced parentheses.
    """

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


class CaseSimplifier(ReductionPassBottomUp):
    """
    Simplify case expressions by removing cases.
    Example:
        given remove_list = [1]
            SELECT (CASE WHEN c0 > 0 THEN c0 ELSE NULL END) FROM t0;
        would be reduced to
            SELECT (CASE WHEN c0 > 0 THEN c0 END) FROM t0;
    """

    def case_list(self, children):
        if len(children) % 2 != 0:
            logging.warning('case_list has invalid number of children, skipping')
            return NamedTree('case_list', children)
        local_remove_list = []
        for i in range(len(children) // 4):
            if self.index + i in self.remove_list:
                local_remove_list += [4 * i + j for j in range(4)]
        self.index += len(children) // 4
        if len(children) % 4 == 2:
            if self.index in self.remove_list:
                local_remove_list += [len(children) - 2, len(children) - 1]
            self.index += 1
        if len(local_remove_list) > 0:
            children = [x for x in children]
        for i in local_remove_list[::-1]:
            del children[i]
        return NamedTree('case_list', children)


class ColumnRemover(AbstractTransformationsIterator):
    """
    A simple reduction pass that tries to remove single columns from insert,
    update and create table statements. It doesn't handle aliases and doesn't
    guarantee syntactically valid results (for instance, it might remove all
    column definitions from a CREATE TABLE statement). The index is counted
    across all column references.

    Also removes table constraints.

    Example:
        INSERT INTO t0 VALUES (2, 1);
        INSERT INTO t1 (c0) VALUES (3);
        UPDATE t0 SET c2=1;

        2 is at index 0.
        c0 is at index 2.
        c2 is at index 3.
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
        assign_list = tree['assign_list', 0]
        if assign_list is None:
            logging.debug('ColumnRemover: found UPDATE without assign_list')
            return tree
        num_columns = len(assign_list.children)
        # compute list of indices that map to children of this node(filter) and align to 0 (map)
        local_remove_list = sorted(filter(lambda x: 0 <= x < num_columns, map(lambda x: x - self.index, self.remove_list)),
                                   reverse=True)
        if len(local_remove_list) > 0:
            tree = tree.__deepcopy__(None)
        for i in local_remove_list:
            assignment_list = tree['assign_list', 0]
            del assignment_list.children[i]
        self.index += num_columns
        return tree


class CompoundSimplifier(ReductionPassBottomUp):
    """
    Simplify compound expressions (UNION, INTERSECT, EXCEPT).
    Example:
        SELECT 3 UNION SELECT 2;
        --> SELECT 2;
    """

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


class ConstraintRemover(ReductionPassBottomUp):
    """
    Remove column constraints in CREATE TABLE statements.
    (Table constraints are removed by ColumnRemover).
    """

    def column_constraint(self, children):
        self.index += 1
        if self.index - 1 in self.remove_list:
            raise Discard
        return NamedTree('column_constraint', children)


class ExprSimplifier(ReductionPassBottomUp):
    """
    Simplify expressions by deleting operators and operands,
    and by removing certain functions.
    """

    def expr(self, children):
        new_children = [c for c in children]
        if len(children) == 0:
            logging.debug('Unexpected empty children in expr')
            return NamedTree('expr', new_children)
        local_remove_list = []
        offset = 0
        # check if not in expression and if it should be removed
        if children[0].data == "k_not":
            offset = 1
            if self.index in self.remove_list:
                local_remove_list.append(0)
            self.index += 1
        # check if operator in expression and if it should be removed (together with an operand)
        if len(children) > 2:
            if self.index in self.remove_list:
                local_remove_list += [offset+1, offset+2]
            elif self.index + 1 in self.remove_list:
                new_children[-1:] = new_children[-1].children
                local_remove_list += [offset, offset+1]
            self.index += 2
        for i in local_remove_list[::-1]:
            try:
                del new_children[i]
            except IndexError:
                logging.debug(f'malformed expr with children: {new_children} '
                              f'and local_remove_list: {local_remove_list}')
        return NamedTree("expr", new_children)

    def expr_helper(self, children):
        local_remove_list = []
        new_children = [c for c in children]
        if len(children) == 0:
            logging.debug('Unexpected empty children in expr')
            return NamedTree('expr', new_children)

        # check if expr_helper is a function and if it should be removed
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
            elif children[0].data in ('agg_fun', 'k_exists'):
                if self.index in self.remove_list:
                    local_remove_list += [0]
                self.index += 1
        else:
            # remove parentheses around single items
            if len(children) == 3 and children[0].type == 'LPAREN' and children[2].type == 'RPAREN':
                if self.index in self.remove_list:
                    local_remove_list += [0, 2]
                self.index += 1
        for i in local_remove_list[::-1]:
            try:
                del new_children[i]
            except IndexError:
                logging.debug(f'malformed expr with children: {new_children} '
                              f'and local_remove_list: {local_remove_list}')
        return NamedTree("expr_helper", new_children)

    def join_clause(self, children):
        self.index += 1
        if self.index - 1 in self.remove_list:
            raise Discard
        return NamedTree('join_clause', children)

    def transform(self, tree):
        return Transformer.transform(self, tree)


class ListItemRemover(AbstractTransformationsIterator):
    """
    Remove items at a given index from all list_expr in a statement.
    (Note: list_expr (from unrecognized.lark) shouldn't be confused with
           expr_list (from sql.lark).)

    Example:
    Consider the following statement:
        INSERT INTO t0 (c0, c1) VALUES (0, 1), (2, 3);
                      list_expr     list_expr list_expr
    Suppose this couldn't be parsed with sql.lark.
    Thus, the parser would fall back onto unrecognized.lark and parse this into
    the three list_expr indicated above (and some other irrelevant stuff). Removing items for each of
    them individually won't work. Thus, ListItemRemover removes the items at the
    same index for all list_expr simultaneously:
        INSERT INTO t0 (c1) VALUES (1), (3);
    Of course, this is just a heuristic. There could be cases where removing items
    at the same index simultaneously doesn't make any sense.
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
        assert num_stmts == len(max_lengths)
        for i in range(0, num_stmts):
            for j in range(0, max_lengths[i]):
                yield i, j


class UnrecognizedExprRemover(ReductionPassBottomUp):
    """
    Remove trees preceded or followed by a token in parse trees that are generated
    by the backup parser. This enables reductions similar to ExprSimplifier even
    if the sql parser fails to parse a statement.

    For instance:
        SLECT c0 + (c1 * 2) FROM t0;
    can't be parsed by the sql parser, since SLECT is not a valid keyword.
    However, it can be parsed by the backup parser, yielding:
        Token, Token, Token, Tree, Token, Token.
    Thus, the example can be reduced to
        SLECT c0 FROM t0;
    or
        SLECT c0 + t0;
    Of course, the second option is nonsense, but in the absence of a proper
    parse tree, the reducer can't know that.
    """

    @v_args(tree=True)
    def unexpected_stmt(self, tree):
        return self._default(tree)

    @v_args(tree=True)
    def paren_expr(self, tree):
        return self._default(tree)

    def _default(self, tree):
        local_remove_set = set()
        children = tree.children
        for i in range(len(children) - 1):
            if issubclass(type(children[i]), Token) and issubclass(type(children[i+1]), Tree):
                if self.index in self.remove_list:
                    local_remove_set |= {i, i + 1}
                self.index += 1
            elif issubclass(type(children[i]), Tree) and issubclass(type(children[i+1]), Token):
                if self.index in self.remove_list:
                    local_remove_set |= {i, i + 1}
                self.index += 1
        if len(local_remove_set) > 0:
            # copy children
            children = [c for c in children]
        for i in sorted(list(local_remove_set), reverse=True):
            del children[i]
        return NamedTree(tree.data, children)


class OptionalFinder(Transformer):
    """
    Find optional rules/tokens in a grammar. Only single rules/tokens
    are supported.

    Examples:
        INPUT: parse tree for 'expr: k_not? expr_helper operator expr'
        OUTPUT: {'expr': 'k_not'}

        INPUT: parse tree for 'table_name: (NAME DOT)? NAME'
        OUTPUT: {}
    """
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


class OptionalRemover(ReductionPassBottomUp):
    """
    Remove optional tokens/rules from a parse tree. Best used with OptionalFinder
    to automatically generate a dictionary of optionals.
    """
    def __init__(self, remove_list=None, multi_remove=True, optionals=None):
        """
        Set up with list of optionals.
        :param remove_list: as usual (see super class)
        :param multi_remove: as usual (see super class)
        :param optionals: dict mapping from rule names to set of optionals for that rule
        """
        ReductionPassBottomUp.__init__(self, remove_list=remove_list, multi_remove=multi_remove)
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


class StatementRemover(AbstractTransformationsIterator):
    """
    Remove the statements at the indices indicated by remove_indices.

    :param: remove_indices: list or set of integers. Overwritten by all_transforms
    :param: multi_remove: ignored, always set to True
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
        self.num_actions = len(tree.children)
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
            types.add(c.children[0].data)
        self.num_actions = len(types)
        for t in types:
            yield t


class TokenRemover(Transformer, AbstractTransformationsIterator):
    """
    Remove one up to max_tokens (inclusive) consecutive tokens from the tree.
    Tokens are not removed across statements.
    """
    def __init__(self, remove_indices=None, multi_remove=False, max_tokens=3):
        Transformer.__init__(self)
        AbstractTransformationsIterator.__init__(self, multi_remove=False)
        if remove_indices is None:
            remove_indices = []
        self.remove_indices = remove_indices
        self.token_index = 0
        self.stmt_index = 0
        self.num_options_per_stmt = []
        self.max_tokens = max_tokens

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
        self.set_up([])
        _ = self.transform(tree)
        # compute number of reduction opportunities
        self.num_actions = sum(
            map(lambda x: sum([x - i + 1 for i in range(1, self.max_tokens + 1)]),
                self.num_options_per_stmt))
        # generate reduction parameters
        for num_consec in range(1, self.max_tokens + 1):
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
        self.num_actions = len(skipped)
        for i, param in enumerate(skipped):
            self.set_up(param)
            yield i, self.transform(tree)


class TokenRemoverNonConsec(TokenRemover):
    """
    Remove any k tokens (consecutive or non-consecutive) from a sql statement,
    for k in [2, ..., max_tokens]
    Tokens are not removed across statements.
    """
    def __init__(self, remove_indices=None, multi_remove=False, max_tokens=2):
        """
        Same as TokenRemover, but default to max_tokens=2
        :param remove_indices:
        :param multi_remove:
        :param max_tokens:
        """
        super().__init__(remove_indices, multi_remove, max_tokens)

    def gen_reduction_params(self, tree):
        self.set_up([])
        _ = self.transform(tree)
        # compute number of reduction opportunities
        self.num_actions = sum(
            map(lambda x: sum([comb(x, i) for i in range(2, self.max_tokens + 1)]), self.num_options_per_stmt))
        # generate reduction parameters
        for i, j in enumerate(self.num_options_per_stmt):
            # start with removing 2 tokens at once since the cases with just one
            # are generated by TokenRemover
            for k in range(2, self.max_tokens + 1):
                for c in combinations(range(0, j), k):
                    yield [(i, x) for x in c]


class ValueMinimizer(ReductionPassBottomUp):
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
        ReductionPassBottomUp.__init__(self, remove_list=remove_list, multi_remove=multi_remove)
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
        str: "NULL", "''"
        int/float: "NULL", "0", "-1", "1"
        :param tree: parse tree that should be reduced
        :param progress: ignored
        :return:
        """
        # first attempt to reduce string literals
        for replace_str in ["NULL", "''"]:
            self.replace_str = replace_str
            self.replace_int = None
            self.replace_float = None
            for res in AbstractTransformationsIterator.all_transforms(self, tree):
                yield res
        # reduce number literals
        for replace_int, replace_float in [('NULL', 'NULL'), ('0', '0.0'), ('-1', '-1.0'), ('1', '1.0')]:
            self.replace_str = None
            self.replace_int = replace_int
            self.replace_float = replace_float
            for res in AbstractTransformationsIterator.all_transforms(self, tree):
                yield res
