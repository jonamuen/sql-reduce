#! /usr/bin/env python3.8
import argparse

from reducer import Reducer
from transformation import StatementRemover, SimpleColumnRemover, ExprSimplifier, PrettyPrinter, ListItemRemover, TokenRemover, TokenRemoverNonConsec, OptionalRemover, CompoundSimplifier
from verifier import Verifier
from sql_parser import SQLParser
from time import time
import logging


def main():
    t0 = time()
    parser = argparse.ArgumentParser(description='Reduce an SQL statement')
    parser.add_argument('-v', '--verbose', action='store_true', help='Report progress information to stderr')
    parser.add_argument('verifier', type=str, help='Path to an executable verification tool')
    parser.add_argument('sql', type=str, help='Path to an SQL file')

    args = parser.parse_args()

    if args.verbose:
        logging.basicConfig(level=logging.INFO)
    else:
        logging.basicConfig(level=logging.WARNING)

    reduction_passes = [StatementRemover(), OptionalRemover(), CompoundSimplifier(), SimpleColumnRemover(), ExprSimplifier(), ListItemRemover(), TokenRemover(), TokenRemoverNonConsec()]

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
