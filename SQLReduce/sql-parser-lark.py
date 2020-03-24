from lark import *
from transformation import EmptyTransformation
import logging
logging.basicConfig(level=logging.DEBUG)

def expand_grammar(filename: str):
    """
    Replace newlines preceded by \ with whitespace.
    This allows linebreaks inside grammar definitions.
    :param filename: path to file
    :return: None
    """
    name, extension = filename.split('.')
    exp_filename = name + 'expanded.' + extension
    with open(filename) as in_file:
        with open(exp_filename, 'w') as out_file:
            for line in in_file:
                if len(line) >= 2 and line[-2] == '\\':
                    out_file.write(line[:-2] + ' ')
                else:
                    out_file.write(line)


expand_grammar('sql.lark')

l = Lark("""
%import .sqlexpanded (sql_stmt_list)
%import common.WS
%ignore WS

""", start="sql_stmt_list", debug=True, parser='lalr')


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
stmt = "CREATE TABLE t (id INT); SELECT ';' FROM t; jsdfe''';';"
tree = l.parse(stmt)
print(tree.pretty())
print(p.transform(tree))
print(p.transform(e.transform(tree)))
