from .verifier import AbstractVerifier
from .reductions import AbstractTransformationsIterator
from .utils import PrettyPrinter
from typing import List
from .sql_parser import SQLParser
import logging
from time import time


from multiprocessing import Process, Queue
from queue import Empty


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
                 output: str = 'reduced.sql', n_proc: int = 2):
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
        self.n_proc = n_proc
        self.q_send = Queue()
        self.q_recv = Queue()
        self.processes = []

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
        logging.info(f"Running {self.n_proc} verification processes in parallel.")

        # check if verifier returns 0 for unmodified statement
        self.stmts_original = list(map(self.pprinter.transform, tree.children))
        if not self.verifier.verify(self.stmts_original):
            logging.error("Verifier returns 1 for unmodified statement!\n"
                          "If you are sure that the verifier is correct, this "
                          "could be a bug in the pretty printer.")
            exit(1)

        # set up
        best = tree.__deepcopy__(None)
        self.itr_counter = 0
        self.best_length = len(self.pprinter.transform(best))
        # Only cache hashes of reduction candidates, but not the associated verification result.
        # This is sufficient because:
        #   If the reduction was invalid or longer than the best reduction, discarding it again doesn't change anything.
        #   If it was valid and shorter than the best reduction, it was kept, so we can discard it now.
        self.cache = set()

        # start a set of subprocess
        for _ in range(self.n_proc):
            p = Process(target=_verifier_subprocess, args=(self.q_send, self.q_recv, self.verifier))
            p.start()
            self.processes.append(p)

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
                # run canonicalizations after all reductions, disable length check for canonicalizations
                for t in self.canonicalizations:
                    best, best_lenght = self._itr_until_fixedpoint(t, best, check_length=False)
                    self.best_length = best_lenght
        except KeyboardInterrupt:
            pass
        logging.info(f"Iterations: {self.itr_counter}, Shortest result (bytes): {self.best_length}")
        logging.info(f"Overall stats: Generating reductions: {self.stats['generation']:.2f}s, "
                     f"Conversion to str: {self.stats['to_str']:.2f}s")
        for _ in range(self.n_proc):
            self.q_send.put('STOP')
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
        # together, self.fixpoint_itr_id and iteration_id form a unique identifier for the parse tree that is being reduced
        while not local_fixed_point:
            local_fixed_point = True
            itr = t.all_transforms(tree, progress)
            n_outstanding = 0  # the number of reduction candidates for whose verification results we are currently waiting
            hash_to_items = {}  # lookup table from hashes of statements for various other representations (e.g. parse tree). Allows to only pass hashes to other processes
            reorder_buffer = {}
            next_result_id = self.itr_counter # used to keep track of the order in which reduction candidates were submitted
            while True:
                # fill queue with reduction candidates
                while n_outstanding < self.n_proc:
                    try:
                        # try to get next candidate from reduction pass iterator
                        t0 = time()
                        reduction_progress, candidate = itr.__next__()
                        t1 = time()
                        logging.debug(f"Generation: {t1 - t0:.4f}s")
                        self.stats['generation'] += t1 - t0
                    except StopIteration:
                        break
                    logging.info(f"Iterations: {self.itr_counter}, {t} ({reduction_progress}/{t.num_actions}), "
                                 f"Shortest result: {best_length}")

                    t0 = time()
                    stmts_cand = list(map(self.pprinter.transform, candidate.children))
                    stmt_cand = ''.join(stmts_cand)
                    stmt_hash = hash(stmt_cand)
                    t1 = time()
                    logging.debug(f"Tree to str: {t1 - t0:.4f}s")
                    self.stats['to_str'] += t1 - t0

                    if stmt_hash in self.cache:
                        logging.debug(f"Cache hit")
                        continue

                    if not check_length or len(stmt_cand) < best_length:
                        # submit candidate for verification
                        self.q_send.put((self.itr_counter, stmts_cand, stmt_hash))
                        n_outstanding += 1
                        hash_to_items[stmt_hash] = (stmt_cand, candidate, reduction_progress)  # update lookup table
                        self.itr_counter += 1
                if next_result_id == self.itr_counter:
                    # all reduction candidates have been submitted and evaluated, we are done here
                    break
                if n_outstanding > 0:
                    # expecting at least one more result -> wait
                    try:
                        counter, res, stmt_hash = self.q_recv.get(block=True, timeout=20)
                        n_outstanding -= 1
                        # check if result is for current tree
                        if counter < next_result_id:
                            n_outstanding += 1
                            logging.debug(f'Discarding stale result: {counter}, {next_result_id}, {stmt_hash}')
                        else:
                            reorder_buffer[counter] = (res, stmt_hash)
                    except Empty:
                        # didn't receive a result within the expected time -> we are done here
                        logging.warning('Timeout occured while waiting for verification result')
                        break
                if next_result_id < self.itr_counter:
                    try:
                        res, stmt_hash = reorder_buffer[next_result_id]
                    except KeyError:
                        # result not available yet
                        continue
                    next_result_id += 1
                    if res:
                        # found valid reduction -> accept
                        try:
                            stmt_cand, candidate, reduction_progress = hash_to_items[stmt_hash]
                        except KeyError:
                            logging.warning('Lookup unexpectedly failed. Might be able to continue.')
                            continue
                        self.cache.add(stmt_hash)
                        logging.debug(f'accepting: {next_result_id-1}, {stmt_cand}')
                        local_fixed_point = False
                        best_length = len(stmt_cand)
                        tree = candidate
                        progress = reduction_progress
                        with open(self.output, 'w') as f:
                            f.write(stmt_cand)

                        while True:
                            try:
                                self.q_send.get_nowait()
                            except Empty:
                                break
                        break
                    else:
                        self.cache.add(stmt_hash)

        return tree, best_length


def _verifier_subprocess(q_recv, q_send, verifier):
    # read input from q_recv and run verification
    # return results to q_send
    verification_time = 0.
    while True:
        try:
            args = q_recv.get()
            if args == 'STOP':
                exit(0)
            itr_counter, stmts, stmt_hash = args
            t0 = time()
            res = verifier.verify(stmts)
            t1 = time()
            verification_time += (t1 - t0)
            q_send.put((itr_counter, res, stmt_hash))
        except KeyboardInterrupt:
            continue
