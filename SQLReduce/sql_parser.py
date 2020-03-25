from lark import *
from transformation import EmptyTransformation, PrefixRemover, StatementRemover, PrettyPrinter
import logging
logging.basicConfig(level=logging.DEBUG)


def expand_grammar(filename: str):
    """
    Replace newlines preceded by a backslash with whitespace.
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


if __name__ == '__main__':
    expand_grammar('sql.lark')

    with open('sqlexpanded.lark') as f:
        l = Lark(f, start="sql_stmt_list", debug=True, parser='lalr')

    e = EmptyTransformation()
    prm = PrefixRemover(visit_tokens=True)
    srm = StatementRemover(remove_indices=[1, 2])
    p = PrettyPrinter(visit_tokens=True)
    stmt = "CREATE TABLE t (id INT); SELECT ';' FROM t; jsdfe''';'; DELETE FROM t0 WHERE id=0;"
    tree = l.parse(stmt)
    tree = prm.transform(tree)
    print(tree.pretty())
    print(p.transform(tree))
    print(p.transform(e.transform(tree)))
    print(srm.transform(tree).pretty())
