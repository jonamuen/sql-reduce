from .verifier import AbstractVerifier
from .reductions import AbstractTransformationsIterator
from .utils import PrettyPrinter
from typing import List
from .sql_parser import SQLParser
import logging
from time import time


class Reducer:
    """
        The reduce method reduces slq statements (passed as a string) while maintaining
        some property (usually triggering a bug) until a fixed point is reached.

        It uses the reductions specified during initialization of the Reducer object.
        The canonicalizations are applied after reduction.

        The difference between reductions and canonicalizations is that canonicalizations
        may increase the length of the result (e.g. by replacing a string literal 'a' with NULL).
        Reductions can only shorten the result.
    """
    def __init__(self, parser: SQLParser, verifier: AbstractVerifier,
                 reductions: List[AbstractTransformationsIterator],
                 canonicalizations: List[AbstractTransformationsIterator],
                 output: str = 'reduced.sql'):
        """
        :param parser: a parser for sql
        :param verifier: used to check if a reduction candidate is equivalent to the original statement
        :param reductions: list of reduction passes, may not increase length of statement
        :param canonicalizations: list of canonicalizations, may increase length of statement
        :return: None
        """
        self.transforms = reductions
        self.canonicalizations = canonicalizations
        self.pprinter = PrettyPrinter()
        self.parser = parser
        self.verifier = verifier
        self.best_length = None
        self.itr_counter = 0
        self.cache = set()
        self.stmts_original = None
        self.stats = {'verification': 0., 'generation': 0., 'to_str': 0.}
        self.output = output

    def reduce(self, stmt: str):
        """
        reduce takes as input a SQL statement and executes the provided
        transformations until a fixed point is reached. Fixed point:
        \\forall t \\in self.transforms \\forall c \\in t.all_transforms not verify(stmt, c).

        After reaching a fixed point, the canonicalizations are applied.
        :param stmt: a string containing the statements to reduce
        :return: a string representation of the best reduction achieved
        """
        logging.info("Parsing...")
        t0 = time()
        tree = self.parser.parse(stmt)
        t1 = time()
        logging.info(f"Parse time: {t1-t0}")

        # check if verifier returns 0 for unmodified statement
        self.stmts_original = list(map(self.pprinter.transform, tree.children))
        if not self.verifier.verify(self.stmts_original, self.stmts_original):
            logging.error("Verifier returns 1 for unmodified statement!\n"
                          "If you are sure that the verifier is correct, this "
                          "could be a bug in the pretty printer.")
            exit(1)

        # set up
        best = tree.__deepcopy__(None)
        self.itr_counter = 0
        self.best_length = len(self.pprinter.transform(best))
        # Only cache hashes of reduction candidates, but not the associated verification result.
        # This is sufficient:
        #   If the reduction was invalid or longer than the best reduction, discarding it again doesn't change anything.
        #   If it was valid and shorter than the best reduction, it was kept, so we can discard it now.
        self.cache = set()
        try:
            global_fixed_point = False
            # the global fixed point is reached when no transform yields a valid reduction
            while not global_fixed_point:
                global_fixed_point = True
                for t in self.transforms:
                    best, best_lenght = self._itr_until_fixedpoint(t, best)
                    if best_lenght < self.best_length:
                        self.best_length = best_lenght
                        global_fixed_point = False
                # run canonicalizations after all reductions
                for t in self.canonicalizations:
                    best, best_lenght = self._itr_until_fixedpoint(t, best, check_length=False)
                    self.best_length = best_lenght
        except KeyboardInterrupt:
            pass
        logging.info(f"Iterations: {self.itr_counter}, Shortest result (bytes): {self.best_length}")
        logging.info(f"Overall stats: Generating reductions: {self.stats['generation']:.2f}s, "
                     f"Conversion to str: {self.stats['to_str']:.2f}s, "
                     f"Verifying reduction candidates: {self.stats['verification']:.2f}s")
        return self.pprinter.transform(best)

    def _itr_until_fixedpoint(self, t, tree, check_length=True):
        """
        Iterate a given transform until a fixed point is reached.
        :param t: object that implements all_transforms
        :param tree: parse tree to reduce
        :param check_length: True if only shorter candidates than the current best should be accepted.
        :return: a reduced tree
        """
        best_length = self.best_length
        local_fixed_point = False
        progress = 0
        while not local_fixed_point:
            local_fixed_point = True
            itr = t.all_transforms(tree, progress)

            t0 = time()
            for i, candidate in itr:
                t1 = time()
                logging.info(f"Iterations: {self.itr_counter}, Tr: {t} ({i}/{t.num_actions}), Shortest result: {best_length}")
                logging.debug(f"Generation: {t1 - t0:.4f}s")
                self.stats['generation'] += t1 - t0

                t0 = time()
                self.itr_counter += 1
                stmts_cand = list(map(self.pprinter.transform, candidate.children))
                stmt_cand = ''.join(stmts_cand)
                stmt_hash = hash(stmt_cand)
                t1 = time()
                logging.debug(f"Tree to str: {t1 - t0:.4f}s")
                self.stats['to_str'] += t1 - t0

                if stmt_hash in self.cache:
                    logging.debug(f"Cache hit")
                    t0 = time()
                    continue

                if not check_length or len(stmt_cand) < best_length:
                    t0 = time()
                    res = self.verifier.verify(self.stmts_original, stmts_cand)
                    t1 = time()
                    logging.debug(f"Verification: {t1 - t0:.4f}s")
                    self.stats['verification'] += t1 - t0
                    if res:
                        self.cache.add(stmt_hash)
                        local_fixed_point = False
                        best_length = len(stmt_cand)
                        tree = candidate
                        progress = i
                        with open(self.output, 'w') as f:
                            f.write(stmt_cand)
                        break
                self.cache.add(stmt_hash)
                t0 = time()
        return tree, best_length
