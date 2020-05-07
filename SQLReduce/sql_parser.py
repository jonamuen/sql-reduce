from lark import *

from .named_tree import NamedTreeConstructor, NamedTree
from .utils import split_into_stmts
from . import grammars
import logging


class SQLParser(Lark):
    """
    Defines a custom parse method that splits the input into single statements
    and automatically expands the grammar (replaces newline preceded by
    backslash with whitespace).
    """
    def __init__(self, grammar, **options):
        super().__init__(grammars.sql, **options)
        self.unrecognized_stmt_parser = Lark(grammars.unrecognized, start='unexpected_stmt', debug=True, parser='lalr')

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
                logging.debug(e)
                try:
                    t = self.unrecognized_stmt_parser.parse(s.rstrip(';'))
                    trees.append(Tree('sql_stmt_list',
                                      [Tree('sql_stmt', [t])]))
                except LarkError as e2:
                    # warn if statement couldn't be parsed by unexpected stmt parser
                    logging.warning((s, e2))
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
