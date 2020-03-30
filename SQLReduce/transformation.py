from lark import Transformer, v_args, Discard
from lark import Tree
from lark.lexer import Token
from itertools import combinations
from typing import Union


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
    Remove specified SQL statements.
    """
    def __init__(self, remove_indices=[]):
        super().__init__()
        self.i = 0
        self.remove_indices = remove_indices

    @v_args(tree=True)
    def sql_stmt(self, tree):
        self.i += 1
        if self.i - 1 in self.remove_indices:
            raise Discard()
        return tree

    def transform(self, tree: Tree) -> Tree:
        self.i = 0
        return super().transform(tree)

    def all_transforms(self, tree):
        num_stmt = len(tree.children)
        for k in range(1, num_stmt + 1):
            for x in combinations(range(num_stmt), k):
                self.__init__(list(x))
                r = self.transform(tree)
                yield r


class ColumnNameFinder(Transformer):
    def table_name(self, children):
        return children[0].value
    def create_table_stmt(self, children):
        table_name = children[2]
        return set(map(lambda x: (table_name, x), children[4]))

    def column_def_list(self, children):
        # state 0: interpret next NAME token as column name
        # state 1: scan until COMMA token
        state = 0
        names = set()
        for c in children:
            if state == 0 and type(c) == Token and c.type == "NAME":
                names.add(c.value)
                state = 1
            elif type(c) == Token and c.type == "COMMA":
                state = 0
        return names

    def __default__(self, data, children, meta):
        s = set()
        for c in children:
            if type(c) == set:
                s = s | c
        return s


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
        # state 0: check next name token for removal
        # state 1: add all following tokens up to and including COMMA
        # state 2: skip all following tokens up to and including COMMA
        state = 0
        new_children = []
        for c in children:
            if state == 0 and type(c) == Token and c.type == "NAME":
                if c.value in map(lambda x: x[1], self.remove_set):
                    state = 2
                else:
                    new_children.append(c)
                    state = 1
            if state == 1:
                new_children.append(c)
                if type(c) == Token and c.type == "COMMA":
                    state = 0
            if state == 2:
                if type(c) == Token and c.type == "COMMA":
                    state = 0
        return new_children

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
                pass
