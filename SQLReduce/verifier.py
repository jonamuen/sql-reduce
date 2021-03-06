import duckdb
import logging
import sqlite3
import tempfile

from typing import List, Union
from os import remove, system
from pathlib import Path
from multiprocessing import Process, Queue
from shutil import copy

from .utils import split_into_stmts


class AbstractVerifier:
    """
    Abstract base class for a verifier.
    AbstractVerifier should be subclassed and verify overridden.
    """
    def verify(self, reduced: List[str]):
        """
        Override this method to implement a comparison function
        :param reduced: A list of SQL statements
        :return: bool: True if a is equivalent to b
        """
        raise NotImplementedError


class SQLiteReturnSetVerifier(AbstractVerifier):
    """
    Exposes a verify method that determines if the list of SQL statements
    passed to it returns the same values as the list of SQL statements with which
    is was set up.
    """
    def __init__(self, original_stmt: List[str]):
        self.expected_results = self._get_results(original_stmt)

    def verify(self, reduced: List[str]):
        """
        Implement verify from AbstractVerifier
        """
        results = self._get_results(reduced)
        return self.expected_results == results

    def _get_results(self, stmts: List[str]):
        try:
            conn = sqlite3.connect(':memory:')
            c = conn.cursor()
            results = set()
            if len(stmts) > 0:
                for stmt in stmts[:-1]:
                    c.execute(stmt)
                for row in c.execute(stmts[-1]):
                    results.add(row)
            conn.close()
        except sqlite3.Error as e:
            results = e
        return results


class DuckDBVerifier(AbstractVerifier):
    """
    Use this verifier to check if certain errors occur when running a query against DuckDB.
    Currently, these errors are detected automatically:
        'INTERNAL', 'Assertion failed', 'Not implemented'
    """
    def __init__(self, original_stmt: Union[str, List[str]], no_subprocess=False):
        """
        Provide the verifier with the original statement against which verification
        will be performed. If the error you are reducing does not crash DuckDB,
        you can set the no_subprocess flag to True to execute queries in the same
        process as the verifier, which significantly improves performance.

        Note that the reducer may generate queries that crash DuckDB
        (e.g. CREATE TABLE t0 (); for DuckDB version 0.1.6). If this happens, also
        set no_subprocess to False.

        :param original_stmt: the statement(s) that trigger the error
        :param no_subprocess: can be set to true if the error does not crash DuckDB
        """
        q = Queue()
        if type(original_stmt) == str:
            original_stmt = list(split_into_stmts(original_stmt))
        p = Process(target=self._process_target, args=(original_stmt, q))
        p.start()
        p.join()
        self.no_subprocess = no_subprocess
        self.exitcode = p.exitcode
        if self.exitcode != 0 and no_subprocess:
            logging.error("DuckDBVerifier: no_subprocess flag is set, but unmodified testcase crashes!")
            exit(1)
        self.errors = None
        if self.exitcode == 0:
            self.errors = q.get()
        logging.info(f'DuckDB Verifier: errors: {self.errors}')

    def verify(self, reduced: List[str]):
        """
        Check if the statements b trigger the same error as the statements with
        which this instance was initialized.
        :param reduced: The statement(s) to check
        :return: True if the same error is triggered, false otherwise
        """
        q = Queue()
        if self.no_subprocess:
            self._process_target(reduced, q)
        else:
            p = Process(target=self._process_target, args=(reduced, q))
            p.start()
            p.join()
            if p.exitcode != 0:
                if self.exitcode == 0:
                    logging.warning(f"Unexpected exit code {p.exitcode}! Is this a different bug?: {''.join(reduced)}")
                return p.exitcode == self.exitcode
        return q.get() == self.errors

    def _process_target(self, stmt_list: List[str], q: Queue):
        """
        Internal helper function that runs the query and can be used as process
        target.
        :param stmt_list:
        :param q:
        :return:
        """
        conn = duckdb.connect(':memory:')
        c = conn.cursor()
        exceptions = set()
        for stmt in stmt_list:
            try:
                c.execute(stmt)
            except RuntimeError as e:
                if str(e).split(':')[0] in ['INTERNAL', 'Assertion failed', 'Not implemented', 'Unknown']:
                    exceptions.add(str(e)[:30])
        conn.close()
        q.put(exceptions)


class Verifier(AbstractVerifier):
    """
    Implementation for an external verifier that works like c-reduce.
    """
    def __init__(self, exec_path: Union[str, Path], output_name: str):
        """
        Set up a verifier.
        :param exec_path: path to verifier
        :param output_name: filename that is expected by the verifier
        """
        self.exec_path = Path(exec_path)
        self.working_dir = self.exec_path.parent
        self.output_name = output_name

    def verify(self, reduced: List[str]):
        """
        Writes the reduced statement to a temporary directory and copies the
        test script into that directory. Then it changes working directory to the
        temporary directory and runs the test script.
        If return code is 0, return True.
        Otherwise return False.
        :param reduced: sql statement(s) provided as list of strings
        :return: Bool
        """
        with tempfile.TemporaryDirectory() as d:
            logging.debug(f'Using tempdir {d}')
            d = Path(d)
            with open(d / self.output_name, 'w') as f:
                f.writelines(reduced)
            copy(self.exec_path.absolute(), d / self.exec_path.name)
            return_code = system(f"cd {d}; {d / self.exec_path.name}")
        return return_code == 0
