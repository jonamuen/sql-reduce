from lark import Transformer, v_args, Discard
from lark import Tree
from lark.lexer import Token
from typing import Iterator
from itertools import combinations
from math import comb
import logging


class AbstractTransformationsIterator:
    def all_transforms(self, tree: Tree) -> Iterator[Tree]:
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
            if c == ";" or c == ")" or c == ",":
                s = s.rstrip()
            s += (c + " ")
            if c == "(":
                s = s.rstrip()
        return s.rstrip()


class StatementRemover(Transformer, AbstractTransformationsIterator):
    """
    Remove the statements at the indices indicated by remove_indices.

    :param: remove_indices: list or set of integers. Overwritten by all_transforms
    :param: max_iterations: all_transforms yields at most this many reductions
    """
    def __init__(self, remove_indices=None, max_iterations=None):
        super().__init__()
        if remove_indices is None:
            remove_indices = []
        self.i = 0
        self.remove_indices = remove_indices
        self.max_iterations = max_iterations

    @v_args(tree=True)
    def sql_stmt(self, tree):
        self.i += 1
        if self.i - 1 in self.remove_indices:
            raise Discard()
        return tree

    def transform(self, tree: Tree) -> Tree:
        """
        Remove the statements at the indices in remove_indices.
        :param tree:
        :return:
        """
        self.i = 0
        return super().transform(tree)

    def all_transforms(self, tree):
        """
        Yield decreasingly aggressive reductions. Start by splitting the
        list of statements in half, then proceed recursively on both halves.
        Yields at most max_iterations reductions.
        Complexity is at most 2*n calls to self.transform.
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
                yield r
            block_size = block_size // 2


class ValueMinimizer(Transformer):
    def VALUE(self, token: Token):
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
        if type(children[0]) == Tree:
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
        for i in remove_list[::-1]:
            del new_children[i]
        return Tree("expr_helper", new_children)

    def transform(self, tree):
        self._num_reduction_opportunities = 0
        return Transformer.transform(self, tree)

    def all_transforms(self, tree):
        self.remove_index = 0
        reduced = self.transform(tree)
        num_opportunities = self._num_reduction_opportunities
        yield reduced
        for i in range(1, num_opportunities):
            self.remove_index = i
            yield self.transform(tree)


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
        return Tree(tree.data, list(map(self.transform, tree.children)))

    def transform(self, tree):
        if type(tree) == Token:
            return tree.__deepcopy__(None)
        elif tree.data == "create_table_stmt":
            return self.create_table_stmt(tree)
        elif tree.data == "insert_stmt":
            return self.insert_stmt(tree)
        elif tree.data == "update_stmt":
            return self.update_stmt(tree)
        elif tree.data == "sql_stmt_list":
            # reset at root of parse tree
            self._num_column_refs = 0
            return self._default(tree)
        else:
            return self._default(tree)

    def create_table_stmt(self, tree: Tree):
        """
        Create table statement grammar:
        k_create k_table table_name LPAREN column_def_list RPAREN
        :param tree:
        :return:
        """
        num_columns = len(tree.children[4].children)
        i = self.remove_index - self._num_column_refs
        if 0 <= i < num_columns:
            tree = tree.__deepcopy__(None)
            del tree.children[4].children[i]
        self._num_column_refs += num_columns
        return tree

    def insert_stmt(self, tree: Tree):
        """
        Insert statement grammar:
        k_insert k_into table_name (LPAREN column_list RPAREN)? k_values values_list
        :param tree:
        :return:
        """
        values_list = tree.children[-1]
        num_columns = len(values_list.children[0].children)
        i = self.remove_index - self._num_column_refs
        if 0 <= i < num_columns:
            tree = tree.__deepcopy__(None)
            if len(tree.children) == 8:
                # has column references
                column_list = tree.children[4]
                del column_list.children[i]

            # update values_list to new tree
            values_list = tree.children[-1]
            for value_tuple in values_list.children:
                del value_tuple.children[i]
        self._num_column_refs += num_columns
        return tree

    def update_stmt(self, tree):
        """
        Update statement grammar:
        k_update table_name k_set assign_list where_clause?
        :param tree:
        :return:
        """
        # an assignment consists of [column_name, EQUAL, VALUE], thus divide by 3
        assert len(tree.children[3].children) % 3 == 0
        num_columns = len(tree.children[3].children) // 3
        i = self.remove_index - self._num_column_refs
        if 0 <= i < num_columns:
            tree = tree.__deepcopy__(None)
            assignment_list = tree.children[3]
            # delete [column_name, EQUAL, VALUE]
            del assignment_list.children[3*i:3*(i+1)]
        self._num_column_refs += num_columns
        return tree

    def all_transforms(self, tree: Tree) -> Iterator[Tree]:
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
        self.remove_index = 0
        reduced = self.transform(tree)
        num_column_refs = self._num_column_refs
        yield reduced
        for i in range(1, num_column_refs):
            self.remove_index = i
            yield self.transform(tree)


class ListItemRemover(AbstractTransformationsIterator):
    def __init__(self, remove_index=(0, 0)):
        self.remove_index = remove_index
        self.stmt_index = -1
        self.list_expr_max_length = []

    def _default(self, tree):
        return Tree(tree.data, list(map(self.transform, tree.children)))

    def transform(self, tree):
        if type(tree) == Token:
            return tree.__deepcopy__(None)
        elif tree.data == 'unexpected_stmt':
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
                print(f"deleting: {tree.children[self.remove_index[1]]}")
                del tree.children[self.remove_index[1]]
        return tree

    def all_transforms(self, tree: Tree) -> Iterator[Tree]:
        self.__init__()
        reduced = self.transform(tree)
        yield reduced
        num_stmts = self.stmt_index + 1
        max_lengths = [x for x in self.list_expr_max_length]
        for i in range(0, num_stmts):
            for j in range(0, max_lengths[i]):
                self.__init__((i, j))
                yield self.transform(tree)


class TokenRemover(Transformer, AbstractTransformationsIterator):
    def __init__(self, remove_indices=tuple()):
        super().__init__()
        self.remove_indices = remove_indices
        self.index = -1

    def __default_token__(self, token):
        if token.value in '(),;':
            return token
        self.index += 1
        if self.index in self.remove_indices:
            raise Discard
        return token

    def __default__(self, data, children, meta):
        children = list(filter(lambda x: x is not None, children))
        if len(children) == 0:
            raise Discard
        return Tree(data, children, meta)

    def sql_stmt_list(self, children):
        return Tree('sql_stmt_list', children)

    def all_transforms(self, tree: Tree) -> Iterator[Tree]:
        max_simult = 2
        self.__init__()
        # do one empty pass to determine number of combinations
        _ = self.transform(tree)
        num_options = self.index + 1
        num_combinations = sum([comb(num_options, i) for i in range(1, max_simult+1)])
        i = 1
        for k in range(1, max_simult+1):
            for c in combinations(range(0, num_options), k):
                logging.info(f"TokenRemover: {i}/{num_combinations}")
                self.__init__(c)
                yield self.transform(tree)
                i += 1
