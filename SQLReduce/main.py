#! /usr/bin/env python3.8
import argparse
import logging

from reducer import Reducer
from reductions import StatementRemover, StatementRemoverByType, ColumnRemover, ExprSimplifier, ListItemRemover, TokenRemover,\
    TokenRemoverNonConsec, OptionalRemover, CompoundSimplifier, OptionalFinder, BalancedParenRemover
from canonicalizations import ValueMinimizer, SROC, Canonicalizer
from verifier import Verifier
from sql_parser import SQLParser
from time import time
from utils import get_grammar


def main():
    t0 = time()
    parser = argparse.ArgumentParser(description='Reduce an SQL statement')
    parser.add_argument('-v', '--verbose', action='store_true', help='Report progress information to stderr')
    parser.add_argument('verifier', type=str, help='Path to an executable verification tool')
    parser.add_argument('sql', type=str, help='Path to an SQL file')

    args = parser.parse_args()
    fmt = '%(levelname)s: %(asctime)s: %(message)s'
    datefmt = '%Y-%m-%d %H:%M:%S'
    if args.verbose:
        logging.basicConfig(level=logging.INFO, format=fmt, datefmt=datefmt)
    else:
        logging.basicConfig(level=logging.WARNING, format=fmt, datefmt=datefmt)

    sql_grammar = get_grammar('sql.lark', 'lark.lark')
    optionals = OptionalFinder().transform(sql_grammar)
    reduction_passes = [StatementRemoverByType(), StatementRemover(), OptionalRemover(optionals=optionals), CompoundSimplifier(), ColumnRemover(),
                        ExprSimplifier(), ListItemRemover(), BalancedParenRemover(), TokenRemover(), TokenRemoverNonConsec()]

    reducer = Reducer(SQLParser('sql.lark', start="sql_stmt_list", debug=False, parser='lalr'),
                      Verifier(args.verifier, 'test.sql'),
                      reduction_passes, canonicalizations=[ValueMinimizer(), Canonicalizer(), SROC()])
    with open(args.sql) as f:
        stmt = f.read()

    reduction = reducer.reduce(stmt)
    print(reduction)
    with open('reduced.sql', 'w') as f:
        f.write(reduction)
    t1 = time()
    logging.info(f"Overall time: {t1-t0}")


if __name__ == '__main__':
    main()
