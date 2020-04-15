from lark import Transformer, v_args, Discard
from lark import Tree
from lark.lexer import Token
from typing import Iterator, Tuple
from named_tree import NamedTree, NamedTreeConstructor, DataToken
from itertools import combinations
from math import comb
import logging
from time import time


class AbstractTransformationsIterator:
    """
    The all_transforms method should yield all transformations that can be
    performed by a given reducer. The parameter progress is used to resume
    the iterator from where it left off. This avoids the problem that the first
    reduction opportunities are attempted for each invocation of all_transforms,
    while later reduction opportunities are never reached.
    """
    def all_transforms(self, tree: Tree, progress: int = 0) -> Iterator[Tuple[int, Tree]]:
        raise NotImplementedError


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

    def paren_expr(self, children):
        return '(' + self._list(children, sep=' ') + ')'

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
    def __init__(self, remove_indices=None, max_iterations=None):
        if remove_indices is None:
            remove_indices = []
        self.remove_indices = remove_indices
        self.max_iterations = max_iterations

    def transform(self, tree: Tree) -> Tree:
        """
        Remove the statements at the indices in remove_indices.
        :param tree:
        :return:
        """
        assert tree.data == 'sql_stmt_list'
        self.remove_indices.sort()
        new_children = []
        i = 0  # index into self.remove_indices
        # iterate over children, only copying those that remain
        for j, c in enumerate(tree.children):
            if i < len(self.remove_indices) and j == self.remove_indices[i]:
                i += 1
            else:
                new_children.append(c)
        return Tree('sql_stmt_list', new_children, tree.meta)

    def all_transforms(self, tree, progress=0):
        """
        Yield decreasingly aggressive reductions. Start by splitting the
        list of statements in half, then proceed recursively on both halves.
        Yields at most max_iterations reductions.
        Complexity is at most 2*n calls to self.transform.
        :param progress:
        :param tree:
        :return:
        """
        num_stmt = len(tree.children)
        num_iterations = 0
        block_size = num_stmt
        while block_size >= 1:
            if num_iterations == self.max_iterations:
                break
            for i in range(num_stmt // block_size):
                if num_iterations == self.max_iterations:
                    break
                self.remove_indices = [x for x in range(i * block_size, (i+1) * block_size)]
                r = self.transform(tree)
                num_iterations += 1
                yield num_iterations, r
            block_size = block_size // 2


class ValueMinimizer(Transformer):
    def VALUE(self, token: Token):
        if token.value.startswith("'") or token.value.startswith('"'):
            reduced_value = token.value[:(len(token.value)//2)]
            return Token("VALUE", reduced_value)
        try:
            num_value = int(token.value)
            return Token("VALUE", str(num_value // 2))
        except ValueError:
            try:
                num_value = float(token.value)
                # setting ndigits=0 keeps type float
                return Token("VALUE", str(round(num_value / 2, ndigits=0)))
            except ValueError:
                return token

    def NUMBER(self, token: Token):
        return self.VALUE(token)


class ExprSimplifier(Transformer, AbstractTransformationsIterator):
    def __init__(self, remove_index=-1):
        super().__init__()
        self.remove_index = remove_index
        self._num_reduction_opportunities = 0

    def expr(self, children):
        new_children = [c for c in children]
        remove_list = []
        offset = 0
        if children[0].data == "k_not":
            offset = 1
            if self.remove_index - self._num_reduction_opportunities == 0:
                remove_list.append(0)
            self._num_reduction_opportunities += 1
        if len(children) > 2:
            if self.remove_index - self._num_reduction_opportunities == 0:
                remove_list += [offset+1, offset+2]
            elif self.remove_index - self._num_reduction_opportunities == 1:
                new_children[-1:] = new_children[-1].children
                remove_list += [offset, offset+1]
            self._num_reduction_opportunities += 2
        for i in remove_list[::-1]:
            del new_children[i]
        return Tree("expr", new_children)

    def expr_helper(self, children):
        remove_list = []
        new_children = [c for c in children]
        if issubclass(type(children[0]), Tree):
            if children[0].data == "k_cast":
                if self.remove_index - self._num_reduction_opportunities == 0:
                    remove_list += [0, 3, 4]
                self._num_reduction_opportunities += 1
            elif children[0].data == "k_nullif":
                if self.remove_index - self._num_reduction_opportunities == 0:
                    remove_list += [0, 3, 4]
                elif self.remove_index - self._num_reduction_opportunities == 1:
                    remove_list += [0, 2, 3]
                self._num_reduction_opportunities += 2
        else:
            if children[0].type == 'LPAREN' and children[2].type == 'RPAREN':
                if self.remove_index - self._num_reduction_opportunities == 0:
                    remove_list += [0, 2]
                self._num_reduction_opportunities += 1
        for i in remove_list[::-1]:
            del new_children[i]
        return Tree("expr_helper", new_children)

    def transform(self, tree):
        self._num_reduction_opportunities = 0
        return Transformer.transform(self, tree)

    def all_transforms(self, tree, progress=0):
        self.remove_index = 0
        reduced = self.transform(tree)
        num_opportunities = self._num_reduction_opportunities
        yield 0, reduced
        for i in range(1, num_opportunities):
            self.remove_index = i
            yield i, self.transform(tree)


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

    :param remove_index: index of the column that should be removed.
    """
    def __init__(self, remove_index=-1):
        self.remove_index = remove_index
        self._num_column_refs = 0

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
            self._num_column_refs = 0
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
        i = self.remove_index - self._num_column_refs
        if 0 <= i < num_columns:
            tree = tree.__deepcopy__(None)
            del tree['column_def_list'][0].children[i]
        self._num_column_refs += num_columns
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
        i = self.remove_index - self._num_column_refs
        if 0 <= i < num_columns:
            tree = tree.__deepcopy__(None)
            column_list = tree['column_list', 0]
            if column_list:
                del column_list.children[i]

            # update values_list to new tree
            values_list = tree['values_list'][0]
            for value_tuple in values_list['value_tuple']:
                del value_tuple.children[i]
        self._num_column_refs += num_columns
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
        i = self.remove_index - self._num_column_refs
        if 0 <= i < num_columns:
            tree = tree.__deepcopy__(None)
            assignment_list = tree['assign_list', 0]
            # delete [column_name, EQUAL, VALUE]
            del assignment_list.children[3*i:3*(i+1)]
        self._num_column_refs += num_columns
        return tree

    def all_transforms(self, tree: Tree, progress: int = 0) -> Iterator[Tree]:
        """
        Compute all reduced trees in which one column reference has been removed.
        Returns an iterator that yields all possible reductions that remove one
        column from an insert statement.

        Note: There are two yield statements in this function. The first one
        returns after attempting to remove column 0. After the first pass, the
        number of columns in the tree is known, so a loop yields the remaining
        reduction candidates.
        :param tree: a parse tree
        :return: an iterator of parse trees
        """
        # try removing index 0 and find number of columns at the same time
        if type(tree) != NamedTree:
            tree = NamedTreeConstructor().transform(tree)
        self.remove_index = 0
        reduced = self.transform(tree)
        num_column_refs = self._num_column_refs
        yield 0, reduced
        for i in range(1, num_column_refs):
            self.remove_index = i
            yield i, self.transform(tree)


class CompoundSimplifier(Transformer, AbstractTransformationsIterator):
    """
    Simplify compound expressions (UNION, INTERSECT, EXCEPT).
    """
    def __init__(self, remove_index: int = 0):
        super().__init__()
        self.remove_index = remove_index
        self.index = 0
        self._num_reduction_opportunities = 0

    @v_args(meta=True)
    def select_stmt_helper(self, children, meta):
        tree = NamedTree('select_stmt_helper', children, meta)
        lhs = tree['select_stmt_helper', 0]
        if lhs:
            rhs = tree['select_stmt', 0]
            if rhs:
                if self.remove_index == self.index:
                    del tree.children[1]
                    del tree.children[0]
                elif self.remove_index == self.index + 1:
                    del tree.children[2]
                    del tree.children[1]
                    tree.children = tree.children[0].children
                self.index += 2
            else:
                tree.children = tree.children[0].children
        return tree

    def __default__(self, data, children, meta):
        return NamedTree(data, children, meta)

    def transform(self, tree: Tree) -> NamedTree:
        if type(tree) != NamedTree:
            tree = NamedTreeConstructor().transform(tree)
        return super().transform(tree)

    def all_transforms(self, tree: NamedTree, progress: int = 0) -> Iterator[Tuple[int, Tree]]:
        if type(tree) != NamedTree:
            tree = NamedTreeConstructor().transform(tree)
        self.__init__(0)
        yield self.transform(tree)
        self._num_reduction_opportunities = self.index
        skipped = []
        for i in range(1, self._num_reduction_opportunities):
            if i < progress:
                skipped.append(i)
                continue
            self.__init__(i)
            yield self.transform(tree)
        for i in skipped:
            self.__init__(i)
            yield self.transform(tree)


class ListItemRemover(AbstractTransformationsIterator):
    """
    Simultaneously remove multiple items from list expressions in an unexpected
    statement.
    """
    def __init__(self, remove_index=(0, 0)):
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

    def all_transforms(self, tree: Tree, start: int = 0) -> Iterator[Tuple[int, NamedTree]]:
        self.__init__()
        progress = 0
        if type(tree) != NamedTree:
            tree = NamedTreeConstructor().transform(tree)
        if start <= progress:
            reduced = self.transform(tree)
            yield 0, reduced
        progress += 1
        num_stmts = self.stmt_index + 1
        max_lengths = [x for x in self.list_expr_max_length]
        skipped = []
        for i in range(0, num_stmts):
            for j in range(0, max_lengths[i]):
                if progress < start:
                    skipped.append((i,j))
                    progress += 1
                    continue
                self.__init__((i, j))
                yield progress, self.transform(tree)
                progress += 1
        for i, s in enumerate(skipped):
            self.__init__(s)
            yield i, s


class TokenRemover(Transformer, AbstractTransformationsIterator):
    def __init__(self, remove_indices=None):
        super().__init__()
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

    def all_transforms(self, tree: Tree, start=0) -> Iterator[NamedTree]:
        max_consec = 3
        self.__init__()
        if type(tree) != NamedTree:
            tree = NamedTreeConstructor().transform(tree)
        # do one empty pass to determine number of combinations
        _ = self.transform(tree)
        # yield transforms with consecutive tokens removed first
        # this will cause some duplicates to be yielded if the lower loop is reached
        # however, these duplicates are caught by the caching functionality of
        # the reducer and thus aren't an issue
        num_combinations = sum(
            map(lambda x: sum([x - i + 1 for i in range(1, max_consec + 1)]),
                self.num_options_per_stmt))
        progress = 1
        skipped = []
        for num_consec in range(1, max_consec + 1):
            for i, num_options in enumerate(self.num_options_per_stmt):
                for j in range(num_options - num_consec + 1):
                    if progress < start:
                        skipped.append([(i, x) for x in range(j, j + num_consec)])
                        progress += 1
                        continue
                    logging.info(f"TokenRemover (consecutive): {progress}/{num_combinations}")
                    self.__init__([(i, x) for x in range(j, j + num_consec)])
                    yield progress, self.transform(tree)
                    progress += 1
        for i, s in enumerate(skipped):
            self.__init__(s)
            logging.info(f'TokenRemover (skipped): {i}/{len(skipped)}')
            yield i, self.transform(tree)


class TokenRemoverNonConsec(TokenRemover):
    def all_transforms(self, tree: Tree, start=0) -> Iterator[NamedTree]:
        max_simult = 2
        self.__init__()
        if type(tree) != NamedTree:
            tree = NamedTreeConstructor().transform(tree)
        # do one empty pass to determine number of combinations
        _ = self.transform(tree)

        skipped = []
        num_combinations = sum(
            map(lambda x: sum([comb(x, i) for i in range(2, max_simult + 1)]), self.num_options_per_stmt))
        progress = 1
        for i, j in enumerate(self.num_options_per_stmt):
            # start with removing 2 tokens at once since the cases with just one
            # have been yielded already
            for k in range(2, max_simult + 1):
                for c in combinations(range(0, j), k):
                    if progress < start:
                        skipped.append([(i, x) for x in c])
                        progress += 1
                        continue
                    logging.info(f"TokenRemover (non-consecutive): {progress}/{num_combinations}")
                    self.__init__([(i, x) for x in c])
                    yield progress, self.transform(tree)
                    progress += 1
        for i, s in enumerate(skipped):
            self.__init__(s)
            logging.info(f'TokenRemover (non-consecutive) (skipped): {i}/{len(skipped)}')
            yield i, self.transform(tree)
