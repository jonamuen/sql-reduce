from typing import Iterator, Tuple

from lark import Tree
from lark.lexer import Token
from lark.visitors import v_args

from .named_tree import DataToken, NamedTree, NamedTreeConstructor
from .reductions import AbstractTransformationsIterator, ReductionPassBottomUp


class SROC(AbstractTransformationsIterator):
    """
    Scalar Replacement Of Column names in expressions.

    Since expressions can also occur in from_clauses, where they shouldn't be
    reduced, the in_from_clause field keeps track of this.
    However, if there is a subquery in a from_clause,
    reduction is re-enabled.
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


class Canonicalizer(ReductionPassBottomUp):
    """
    The canonicalizer can simplify upsert to insert and can replace the types of
    column definitions (in create table statements) to INT.
    Canonicalization is only possible on statements that were parsed with sql.lark.
    """

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