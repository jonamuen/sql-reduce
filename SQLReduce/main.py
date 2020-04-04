import argparse

from reducer import Reducer
from transformation import StatementRemover, ColumnRemover, ExprSimplifier, PrettyPrinter
from verifier import Verifier
from sql_parser import SQLParser
from time import time
import logging

logging.basicConfig(level=logging.INFO)


def main():
    t0 = time()
    parser = argparse.ArgumentParser(description='Reduce an SQL statement')
    parser.add_argument('sql', type=str, help='Path to an SQL file')
    parser.add_argument('verifier', type=str, help='Path to an executable verification tool')

    args = parser.parse_args()
    reducer = Reducer(SQLParser('sql.lark', start="sql_stmt_list", debug=False, parser='lalr'),
                      Verifier(args.verifier, 'test.sql'),
                      [StatementRemover(), ColumnRemover(), ExprSimplifier()])
    with open(args.sql) as f:
        stmt = f.read()

    reduction = reducer.reduce(stmt)
    print(PrettyPrinter().transform(reduction))
    t1 = time()
    logging.info(f"Overall time: {t1-t0}")


if __name__ == '__main__':
    main()
