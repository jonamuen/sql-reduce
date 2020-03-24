from lark import Transformer, v_args, Discard
from lark import Tree
from lark.lexer import Token


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


class StatementRemover(Transformer):
    """
    Remove specified SQL statements.
    """
    def __init__(self, removeIndices=[]):
        super().__init__()
        self.i = 0
        self.removeIndices = removeIndices

    @v_args(tree=True)
    def sql_stmt(self, tree):
        self.i += 1
        if self.i - 1 in self.removeIndices:
            raise Discard()
        return tree
