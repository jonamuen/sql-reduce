from typing import Optional, Iterator, Tuple

from lark import Tree
from lark.lexer import Token
from lark.visitors import Transformer, v_args

from named_tree import DataToken, NamedTree, NamedTreeConstructor
from reductions import AbstractTransformationsIterator


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