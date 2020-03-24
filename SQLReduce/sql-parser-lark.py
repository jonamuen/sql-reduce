from lark import *
from transformation import EmptyTransformation
import logging
logging.basicConfig(level=logging.DEBUG)

l = Lark("""
%import .mysql (sql_stmt_list)
%import common.WS
%ignore WS

""", start="sql_stmt_list", debug=True)


class PrettyPrinter(Transformer):
    """
    Computes the string representation of an SQL parse-tree
    """
    def __default_token__(self, token):
        return token.value

    def __default__(self, data, children, meta):
        s = ""
        for c in children:
            # no space before ";"
            if c == ";":
                s = s.rstrip()
            s += (c + " ")
        return s.rstrip()


class AbstractVerifier():
    """
    Abstract base class for a verifier.
    AbstractVerifier should be subclassed and verify overridden.
    """
    def verify(self, a: str, b: str):
        """
        Override this method to implement a comparison function
        :param a: An SQL statement
        :param b: An SQL statement
        :return: bool: True if a is equivalent to b
        """
        raise NotImplementedError


class MyVerifier(AbstractVerifier):
    def verify(self, stmt):
        pass


e = EmptyTransformation()
p = PrettyPrinter(visit_tokens=True)
stmt = "CREATE TABLE t (id INTQ); SELECT * FROM t;"
tree = l.parse(stmt)
print(p.transform(tree))
print(p.transform(e.transform(tree)))
