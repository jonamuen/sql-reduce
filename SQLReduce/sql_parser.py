from lark import *
from transformation import StatementRemover, PrettyPrinter
from named_tree import NamedTreeConstructor, NamedTree
from utils import expand_grammar, split_into_stmts
import logging


class SQLParser(Lark):
    """
    Defines a custom parse method that splits the input into single statements
    and automatically expands the grammar (replaces newline preceded by
    backslash with whitespace).
    """
    def __init__(self, grammar, **options):
        with open(expand_grammar(grammar)) as f:
            super().__init__(f, **options)
        with open(expand_grammar('unrecognized.lark')) as f:
            self.unrecognized_stmt_parser = Lark(f, start='unexpected_stmt',
                                                 debug=True, parser='lalr')

    def parse(self, text: str, start=None) -> NamedTree:
        """
        Overrides parse method from Lark. Splits text into single sql statements
        which are then parsed one at a time. If an error occurs, only the
        affected statement is returned as an unexpected_stmt and the parse
        doesn't abort.
        :param text: SQL statement(s)
        :param start: (inherited, ignored)
        :return: A parse tree
        """

        # skip comments
        without_comments = ""
        for line in text.split('\n'):
            if line.startswith('--'):
                pass
            else:
                without_comments += (line + '\n')
        stmts = split_into_stmts(without_comments)

        # parse one statment at a time and collect results in trees
        trees = []
        num_parse_errors = 0
        for s in stmts:
            try:
                trees.append(super().parse(s))
            except LarkError as e:
                num_parse_errors += 1
                logging.info(e)
                try:
                    t = self.unrecognized_stmt_parser.parse(s.rstrip(';'))
                    trees.append(Tree('sql_stmt_list',
                                      [Tree('sql_stmt', [t])]))
                except LarkError as e2:
                    # warn if statement couldn't be parsed by unexpected stmt parser
                    logging.warning(e2)
                    # construct error tree
                    t = Tree("sql_stmt_list",
                             [Tree("sql_stmt",
                                   [Tree("unexpected_stmt",
                                         [Token("ERR", s.rstrip(';'))])])])
                    trees.append(t)

        # merge sql statements from single statement parse trees into one tree
        if num_parse_errors > 0:
            logging.warning(f"{num_parse_errors}/{len(trees)} stmts not fully parsed. This isn't necessarily an issue, as the reducer can operate on partial parses.")
        for t in trees:
            assert len(t.children) == 1
        # convert to NamedTree and return
        return NamedTreeConstructor().transform(Tree("sql_stmt_list", [x.children[0] for x in trees]))


if __name__ == '__main__':
    parser = SQLParser("sql.lark", start="sql_stmt_list", debug=True, parser='lalr')

    srm = StatementRemover(remove_indices=[1, 2])
    p = PrettyPrinter(visit_tokens=True)
    stmt = "CREATE TABLE t (id INT); SELECT ';' FROM t; jsdfe''';'; SELECT c0, ''';''' FROM (SELECT c0 FROM t0  WHEN c0 > 0) WHERE id=(((0)));"
    tree = parser.parse(stmt)
    print(tree.pretty())
    print(p.transform(tree))
    print(srm.transform(tree).pretty())
