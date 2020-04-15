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
        \\forall t \\in self.transforms \\forall c \\in t.all_transforms not verify(stmt, c)
        :param stmt:
        :return:
        """
        logging.info("Parsing...")
        t0 = time()
        tree = self.parser.parse(stmt)
        t1 = time()
        logging.info(f"Parse time: {t1-t0}")

        # check if verifier returns 0 for unmodified statement
        stmt_list = list(map(self.pprinter.transform, tree.children))
        if not self.verifier.verify(stmt_list, stmt_list):
            logging.error("Verifier returns 1 for unmodified statement!\n"
                          "If you are sure that the verifier is correct, this "
                          "could be a bug in the pretty printer.")
            exit(1)

        # set up
        best = tree.__deepcopy__(None)
        itr_counter = 0
        best_length = len(self.pprinter.transform(best))
        cache = dict()
        stmts_original = list(map(self.pprinter.transform, tree.children))
        try:
            global_fixed_point = False
            # the global fixed point is reached when no transform yields a valid reduction
            while not global_fixed_point:
                global_fixed_point = True
                for t in self.transforms:
                    # a local fixed point is reached when the current transform doesn't yield any valid reductions
                    local_fixed_point = False
                    progress = 0
                    while not local_fixed_point:
                        local_fixed_point = True
                        itr = t.all_transforms(best, progress)

                        t0 = time()
                        for i, candidate in itr:
                            t1 = time()
                            logging.info(f"Iterations: {itr_counter}, Tr: {t}, Shortest result: {best_length}")
                            logging.info(f"Generation: {t1-t0}s")

                            t0 = time()
                            itr_counter += 1
                            stmts_cand = list(map(self.pprinter.transform, candidate.children))
                            stmt_cand = ''.join(stmts_cand)
                            h = hash(stmt_cand)
                            t1 = time()
                            logging.info(f"Preparation: {t1-t0}s")

                            # TODO: use set as cache
                            try:
                                if not cache[h]:
                                    logging.info(f"Cache hit")
                                    t0 = time()
                                    continue
                            except KeyError:
                                pass
                            if len(stmt_cand) < best_length:
                                t0 = time()
                                res = self.verifier.verify(stmts_original, stmts_cand)
                                t1 = time()
                                logging.info(f"Verification: {t1-t0}s")
                                if res:
                                    cache = {h: True}
                                    local_fixed_point = False
                                    global_fixed_point = False
                                    best_length = len(stmt_cand)
                                    best = candidate
                                    progress = i
                                    with open('best.sql', 'w') as f:
                                        f.write(stmt_cand)
                                    break
                            cache[h] = False
                            t0 = time()
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
