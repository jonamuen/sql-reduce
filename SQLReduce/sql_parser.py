from lark import *
from transformation import EmptyTransformation, PrefixRemover, StatementRemover, PrettyPrinter
from utils import expand_grammar
import re
import logging

logging.basicConfig(level=logging.DEBUG)


def split_into_stmts(text: str):
    """
    Split a string of multiple sql statements into a list of single statements.
    :param text:
    """
    # use the following RE to find string literals since they may contain
    # a semicolon that doesn't indicate the end of a SQL statement
    string_re = re.compile(r"'([^']|(''))*'")

    # store start and end position of all matches
    match_ranges = []
    m = string_re.search(text)
    while m:
        match_ranges.append(m.span())
        s = m.end()
        m = string_re.search(text, s)

    # split text into single sql statements
    stmts = []
    begin_next = 0  # holds the index where the next sql statement begins
    for i, c in enumerate(text):
        if c == ';':
            # in_str is set to True if the semicolon is inside a str
            in_str = False

            for begin, end in match_ranges:
                if end <= i:
                    continue
                if begin > i:
                    continue
                in_str = True
                break
            if not in_str:
                stmt = text[begin_next: i + 1].lstrip().rstrip()
                if len(stmt) > 1:
                    stmts.append(stmt)
                begin_next = i + 1
    return stmts


class SQLParser(Lark):
    """
    Defines a custom parse method that splits the input into single statements
    and automatically expands the grammar (replaces newline preceded by
    backslash with whitespace).
    """
    def __init__(self, grammar, **options):
        with open(expand_grammar(grammar)) as f:
            super().__init__(f, **options)

    def parse(self, text: str, start=None):
        """
        Overrides parse method from Lark. Splits text into single sql statements
        which are then parsed one at a time. If an error occurs, only the
        affected statement is returned as an unexpected_stmt and the parse
        doesn't abort.
        :param text: SQL statement(s)
        :param start: (ignored)
        :return: A parse tree
        """

        # skip comments
        without_comments = ""
        for line in text.split('\n'):
            if line.startswith('--'):
                pass
            else:
                without_comments += line
        stmts = split_into_stmts(without_comments)

        # parse one statment at a time and collect results in trees
        trees = []
        for s in stmts:
            try:
                trees.append(super().parse(s))
            except LarkError as e:
                logging.log(logging.DEBUG, e)
                # construct error tree
                t = Tree("sql_stmt_list",
                         [Tree("sql_stmt",
                               [Tree("unexpected_stmt",
                                     [Token("ERR", s.rstrip(';'))])])])
                trees.append(t)

        # merge sql statements from single statement parse trees into one tree
        for t in trees:
            assert len(t.children) == 1
        return Tree("sql_stmt_list", [x.children[0] for x in trees])


if __name__ == '__main__':
    parser = SQLParser("sql.lark", start="sql_stmt_list", debug=True, parser='lalr')

    e = EmptyTransformation()
    prm = PrefixRemover(visit_tokens=True)
    srm = StatementRemover(remove_indices=[1, 2])
    p = PrettyPrinter(visit_tokens=True)
    stmt = "CREATE TABLE t (id INT); SELECT ';' FROM t; jsdfe''';'; SELECT c0, ''';''' FROM (SELECT c0 FROM t0  WHEN c0 > 0) WHERE id=(((0)));"
    tree = parser.parse(stmt)
    tree = prm.transform(tree)
    print(tree.pretty())
    print(p.transform(tree))
    print(p.transform(e.transform(tree)))
    print(srm.transform(tree).pretty())
