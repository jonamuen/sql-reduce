from lark import Transformer, v_args
from lark import Tree


class EmptyTransformation(Transformer):
    """
    Transform into an empty tree.
    """
    @v_args(tree=True)
    def sql_stmt_list(self, tree):
        return Tree("sql_stmt_list", [])
