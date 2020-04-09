from verifier import AbstractVerifier, SQLiteReturnSetVerifier
from transformation import AbstractTransformationsIterator, PrettyPrinter, StatementRemover
from typing import List
from sql_parser import SQLParser
import logging
from time import time


class Reducer:
    def __init__(self, parser: SQLParser, verifier: AbstractVerifier,
                 transforms: List[AbstractTransformationsIterator]):
        self.transforms = transforms
        self.pprinter = PrettyPrinter()
        self.parser = parser
        self.verifier = verifier

    def reduce(self, stmt: str):
        """
        reduce takes as input a SQL statement and executes the provided
        transformations until a fixed point is reached. Fixed point:
        \forall t \in self.transforms \forall c \in t.all_transforms not verify(stmt, c)
        :param stmt:
        :return:
        """
        global_fixed_point = False
        logging.info("Parsing...")
        t0 = time()
        tree = self.parser.parse(stmt)
        t1 = time()
        logging.info(f"Parse time: {t1-t0}")
        best = tree.__deepcopy__(None)
        itr_counter = 0
        best_length = ''
        cache = dict()
        try:
            while not global_fixed_point:
                global_fixed_point = True
                for t in self.transforms:
                    # iterate with a single transform until no more improvements are possible
                    local_fixed_point = False
                    while not local_fixed_point:
                        local_fixed_point = True
                        for candidate in t.all_transforms(best):
                            logging.info(f"Iterations: {itr_counter}, Tr: {t}, Shortest result: {best_length}")
                            itr_counter += 1
                            stmts_old = list(map(self.pprinter.transform, tree.children))
                            stmts_cand = list(map(self.pprinter.transform, candidate.children))
                            stmt_old = self.pprinter.transform(best)
                            stmt_cand = self.pprinter.transform(candidate)
                            h = hash(stmt_cand)
                            try:
                                if not cache[h]:
                                    logging.info(f"Cache hit")
                                    continue
                            except KeyError:
                                pass
                            if len(stmt_cand) < len(stmt_old) and self.verifier.verify(stmts_old, stmts_cand):
                                cache = {h: True}
                                local_fixed_point = False
                                global_fixed_point = False
                                best_length = len(stmt_cand)
                                best = candidate
                                with open('best.sql', 'w') as f:
                                    f.write(stmt_cand)
                                break
                            cache[h] = False
        except KeyboardInterrupt:
            pass
        logging.info(f"Iterations: {itr_counter}, Shortest result: {best_length}")
        return best


if __name__ == '__main__':
    transforms = [StatementRemover()]

    parser = SQLParser("sql.lark", start="sql_stmt_list", debug=True, parser='lalr')
    vrf = SQLiteReturnSetVerifier('test/test_reduce.sqlite')
    r = Reducer(parser, vrf, transforms)
    reduced = r.reduce("CREATE TABLE t0 (id INT); INSERT INTO t0 VALUES (0);"
                       "INSERT INTO t0 VALUES (1); SELECT * FROM t0 WHERE id = 0;")
    print(r.pprinter.transform(reduced))
