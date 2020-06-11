#! /usr/bin/env python3
import argparse
import logging
from pathlib import Path

from SQLReduce.reducer import Reducer
from SQLReduce.reductions import StatementRemover, StatementRemoverByType, ColumnRemover, ExprSimplifier, \
    ListItemRemover, TokenRemover, TokenRemoverNonConsec, OptionalRemover, CompoundSimplifier, OptionalFinder, \
    BalancedParenRemover, UnrecognizedExprRemover, CaseSimplifier, ConstraintRemover, ValueMinimizer
from SQLReduce.canonicalizations import SROC, Canonicalizer
from SQLReduce.verifier import Verifier
from SQLReduce.sql_parser import SQLParser
from time import time
from SQLReduce.utils import get_grammar
from SQLReduce import grammars


def main():
    t0 = time()
    # set up argument parser
    parser = argparse.ArgumentParser(description='Reduce an SQL statement')
    parser.add_argument('-v', '--verbose', action='store_true', help='Report progress information to stderr')
    parser.add_argument('-o', '--output', default='reduced.sql', help='Write reduction to this file')
    parser.add_argument('-n', default=2, type=int, help='Number of verification processes to run in parallel')
    parser.add_argument('verifier', type=str, help='Path to an executable verification tool')
    parser.add_argument('sql', type=str, help='Path to an SQL file')

    args = parser.parse_args()

    # set up logging
    fmt = '%(levelname)s: %(asctime)s: %(message)s'
    datefmt = '%Y-%m-%d %H:%M:%S'
    if args.verbose:
        logging.basicConfig(level=logging.INFO, format=fmt, datefmt=datefmt)
    else:
        logging.basicConfig(level=logging.WARNING, format=fmt, datefmt=datefmt)

    # verify n >= 1
    if args.n < 1:
        logging.fatal('n must be >= 1')
        exit(1)

    # test case path
    path = Path(args.sql)
    # set up reduction passes and reducer
    sql_grammar = get_grammar(grammars.sql, grammars.lark)
    optionals = OptionalFinder().transform(sql_grammar)
    reduction_passes = [StatementRemoverByType(), StatementRemover(), CompoundSimplifier(), ColumnRemover(),
                        OptionalRemover(optionals=optionals), ExprSimplifier(), CaseSimplifier(), ConstraintRemover(),
                        UnrecognizedExprRemover(), ListItemRemover(), BalancedParenRemover(), ValueMinimizer(),
                        TokenRemover(), TokenRemoverNonConsec()]

    reducer = Reducer(SQLParser('sql.lark', start="sql_stmt_list", debug=False, parser='lalr'),
                      Verifier(args.verifier, path.name),
                      reduction_passes, canonicalizations=[Canonicalizer(), SROC()], output=args.output, n_proc=args.n)

    # read input, run reduction and report result
    with open(args.sql) as f:
        stmt = f.read()

    reduction = reducer.reduce(stmt)
    print(reduction)
    with open(args.output, 'w') as f:
        f.write(reduction)
    t1 = time()
    logging.info(f"Overall time: {t1-t0}")


if __name__ == '__main__':
    main()
