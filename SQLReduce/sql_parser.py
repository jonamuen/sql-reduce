from lark import *
from transformation import EmptyTransformation, PrefixRemover, StatementRemover, PrettyPrinter
from utils import expand_grammar
import logging
logging.basicConfig(level=logging.DEBUG)


if __name__ == '__main__':
    expand_grammar('sql.lark')

    with open('sqlexpanded.lark') as f:
        parser = Lark(f, start="sql_stmt_list", debug=True, parser='lalr')

    e = EmptyTransformation()
    prm = PrefixRemover(visit_tokens=True)
    srm = StatementRemover(remove_indices=[1, 2])
    p = PrettyPrinter(visit_tokens=True)
    stmt = "CREATE TABLE t (id INT); SELECT ';' FROM t; jsdfe''';'; SELECT c0 FROM (SELECT c0 FROM t0 WHEN c0 > 0) WHERE id=(((0)));"
    tree = parser.parse(stmt)
    tree = prm.transform(tree)
    print(tree.pretty())
    print(p.transform(tree))
    print(p.transform(e.transform(tree)))
    print(srm.transform(tree).pretty())
