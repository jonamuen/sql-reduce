#! /usr/bin/env python3.8
import argparse

from reducer import Reducer
from transformation import StatementRemover, SimpleColumnRemover, ExprSimplifier, PrettyPrinter, ListItemRemover, TokenRemover
from verifier import Verifier
from sql_parser import SQLParser
from time import time
import logging

logging.basicConfig(level=logging.WARNING)


def main():
    t0 = time()
    parser = argparse.ArgumentParser(description='Reduce an SQL statement')
    parser.add_argument('verifier', type=str, help='Path to an executable verification tool')
    parser.add_argument('sql', type=str, help='Path to an SQL file')

    args = parser.parse_args()

    reduction_passes = [StatementRemover(), SimpleColumnRemover(), ExprSimplifier(), ListItemRemover(), TokenRemover()]

    reducer = Reducer(SQLParser('sql.lark', start="sql_stmt_list", debug=False, parser='lalr'),
                      Verifier(args.verifier, 'test.sql'),
                      reduction_passes)
    with open(args.sql) as f:
        stmt = f.read()

    reduction = reducer.reduce(stmt)
    res = PrettyPrinter().transform(reduction)
    print(res)
    with open('reduced.sql', 'w') as f:
        f.write(res)
    t1 = time()
    logging.info(f"Overall time: {t1-t0}")


if __name__ == '__main__':
    main()
