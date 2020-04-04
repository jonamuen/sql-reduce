from lark import Transformer, v_args, Discard
from lark import Tree
from lark.lexer import Token
from itertools import combinations
from typing import Union, Iterator
import logging


class AbstractTransformationsIterator:
    def all_transforms(self, tree):
        raise NotImplementedError


class EmptyTransformation(Transformer):
    """
    Transform into an empty tree.
    """
    @v_args(tree=True)
    def sql_stmt_list(self, tree):
        return Tree("sql_stmt_list", [])


class PrefixRemover(Transformer):
    """
    Removes the prefix which is added to grammar rules by lark when importing
    a grammar.
    """
    def __default__(self, data, children, meta):
        s = data.split('__')
        if len(s) == 2:
            return Tree(s[1], children, meta)
        elif len(s) == 1:
            return Tree(data, children, meta)
        else:
            raise ValueError(f"Too many '__' in {data}")

    def __default_token__(self, token: Token):
        s = token.type.split('__')
        if len(s) == 2:
            t = token.__deepcopy__(None)
            t.type = s[1]
            return t
        elif len(s) == 1:
            return token.__deepcopy__(None)
        else:
            raise ValueError(f"Too many '__' in {token.type}")


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
        return s + ';'

    def sql_stmt_list(self, children):
        return self._list(children, sep='\n')

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
    :param: max_simultaneous: all_transforms removes at most this many statements at once
    """
    def __init__(self, remove_indices=None, max_iterations=None, max_simultaneous=None):
        super().__init__()
        if remove_indices is None:
            remove_indices = []
        self.i = 0
        self.remove_indices = remove_indices
        self.max_iterations = max_iterations
        self.max_simultaneous = max_simultaneous

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
        Yield all possibilities of removing one or more statements at a time.
        Limited by max_iterations and max_simultaneous.
        :param tree:
        :return:
        """
        num_stmt = len(tree.children)
        num_iterations = 0
        if self.max_simultaneous is None:
            self.max_simultaneous = num_stmt
        for k in range(1, self.max_simultaneous + 1):
            for x in combinations(range(num_stmt), k):
                if num_iterations == self.max_iterations:
                    break
                self.remove_indices = list(x)
                r = self.transform(tree)
                num_iterations += 1
                yield r
            if num_iterations == self.max_iterations:
                break


class ColumnNameFinder(Transformer):
    def table_name(self, children):
        return children[0].value
    def create_table_stmt(self, children):
        table_name = children[2]
        return set(map(lambda x: (table_name, x), children[4]))

    def column_def(self, children):
        return {children[0].value}

    def __default__(self, data, children, meta):
        s = set()
        for c in children:
            if type(c) == set:
                s = s | c
        return s


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


# TODO: think about handling aliases (e.g. manually implement tree traversal and
# TODO: keep context of columns/tables and their aliases
# TODO: can probably be implemented similar to type-checking in compiler design
class ColumnRemover(Transformer, AbstractTransformationsIterator):
    """
    Remove columns from parse tree (ignores aliases with AS)
    """
    def __init__(self):
        super().__init__()
        self.col_name_finder = ColumnNameFinder()
        self.remove_set = set()

    @v_args(tree=True)
    def expr(self, tree):
        # expr: k_not? (expr_helper operator expr | expr_helper)

        # if there is a prefix NOT, set offset = 1
        if type(tree.children[0]) == Tree and tree.children[0].data == "k_not":
            offset = 1
        else:
            offset = 0

        # copy children
        children = [x for x in tree.children]

        if len(children) - offset == 1:
            # case expr_helper
            if None in children:
                return None
            else:
                return Tree("expr", children)
        elif len(children) - offset == 3:
            # case expr_helper operator expr
            if children[offset] is None:
                # delete operator
                del children[offset + 1]
                # delete expr_helper
                del children[offset]
            elif children[offset + 2] is None:
                # delete expr
                del children[offset+2]
                # delete operator
                del children[offset+1]
            if None in children:
                # both sides of operator are None
                return None
            else:
                return Tree("expr", children)
        else:
            raise ValueError(f"Malformed expr:\n{tree.pretty()}")

    @v_args(tree=True)
    def column_name(self, tree: Tree):
        """
        Return None if any NAME token is in remove_set. Return tree otherwise.
        See grammar reference below:

        column_name: table_name "." NAME
                   | NAME
                   | STAR
        :param tree:
        :return:
        """
        children = tree.children
        if type(children[0] == Tree):
            # case table_name "." NAME
            if (children[0].children[0].value, children[2]) in self.remove_set:
                return None
            else:
                return tree
        else:
            # case NAME | STAR
            if (children[0].value) in map(lambda x: x[1], self.remove_set):
                return None
            else:
                return tree

    @v_args(tree=True)
    def expr_helper(self, tree: Tree):
        if None in tree.children:
            return None
        else:
            return tree

    def column_def_list(self, children):
        return list(filter(lambda x: x is not None, children))

    def column_def(self, children):
        if children[0].value in self.remove_set:
            return None
        else:
            return Tree("column_def", children)

    def _find_column_names(self, tree: Tree):
        print(self.col_name_finder.transform(tree))
        for col_def in tree.find_data("column_def_list"):
            print(col_def)

    def all_transforms(self, tree):
        col_names = self.col_name_finder.transform(tree)
        for k in range(1, len(col_names) + 1):
            for x in combinations(col_names, k):
                self.remove_set = x
                yield self.transform(tree)


class AliasContext:
    def __init__(self):
        self.aliases = {}

    def add_alias(self, source, alias_name):
        self.aliases[alias_name] = source

    def resolve_alias(self, alias_name):
        if not alias_name in self.aliases.keys():
            return alias_name
        else:
            return self.resolve_alias(self.aliases[alias_name])


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


class CRM:
    """
    Alias aware implementation of column remover.
    """
    def __init__(self, remove_set):
        self.remove_set = remove_set

    def removeColumn(self, tree: Union[Tree, Token], ctxt: AliasContext):
        if type(tree) == Token:
            if ctxt.resolve_alias(Token.value) in self.remove_set:
                return None
            else:
                return tree
        elif type(tree) == Tree:
            if tree.data == "select_stmt":
                from_clauses = list(filter(lambda x: x.data == "from_clause", tree.children))
                if len(from_clauses) == 0:
                    return tree
                elif len(from_clauses) == 1:
                    from_clause = from_clauses[0]

                if tree.children[1].data == "k_distinct":
                    subqueries = tree.children[2]
                else:
                    subqueries = tree.children[1]
                assert subqueries.data == "subquery_or_expr_list"
                for subq in subqueries.children:
                    res = self.removeColumn(subq.children[0], ctxt)  # TODO
                    # subquery_or_expr_as: subquery_or_expr (k_as NAME)?
                    if len(subq.children) == 3:
                        if res is not None:
                            ctxt
                    else:
                        pass
