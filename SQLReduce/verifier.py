import sqlite3
import duckdb
from typing import List, Union
from os import remove, system
from pathlib import Path
from multiprocessing import Process, Queue
from sql_parser import split_into_stmts
import logging


class AbstractVerifier:
    """
    Abstract base class for a verifier.
    AbstractVerifier should be subclassed and verify overridden.
    """
    def verify(self, a: List[str], b: List[str]):
        """
        Override this method to implement a comparison function
        :param a: A list of SQL statements
        :param b: A list of SQL statements
        :return: bool: True if a is equivalent to b
        """
        raise NotImplementedError


class SQLiteReturnSetVerifier(AbstractVerifier):
    """
    Exposes a verify method that determines equivalence of two lists of
    SQL statements by running them against an empty SQLite3 database and
    comparing the results returned by the respective last statements.
    """
    def __init__(self, db_path: str):
        self.db_path = db_path

    def verify(self, a: List[str], b: List[str]):
        """
        Implement verify from AbstractVerifier
        """
        results_a = self._get_results(a)
        results_b = self._get_results(b)
        return results_a == results_b

    def _get_results(self, stmts: List[str]):
        try:
            remove(self.db_path)
            conn = sqlite3.connect(self.db_path)
            c = conn.cursor()
            results = set()
            if len(stmts) > 0:
                for stmt in stmts[:-1]:
                    c.execute(stmt)
                for row in c.execute(stmts[-1]):
                    results.add(row)
            conn.rollback()
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
        print(self.errors)

    def verify(self, a: List[str], b: List[str]):
        """
        Check if the statements b trigger the same error as the statements with
        which this instance was initialized.
        :param a: Ignored. (legacy unmodified statement)
        :param b: The statement(s) to check
        :return: True if the same error is triggered, false otherwise
        """
        q = Queue()
        if self.no_subprocess:
            self._process_target(b, q)
        else:
            p = Process(target=self._process_target, args=(b, q))
            p.start()
            p.join()
            if self.exitcode != 0:
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
                print(str(e).split(':')[0])
                if str(e).split(':')[0] in ['INTERNAL', 'Assertion failed', 'Not implemented']:
                    exceptions.add(str(e))
        conn.close()
        q.put(exceptions)


class ExternalVerifier(AbstractVerifier):
    """
    Use an external verifier to check if two sql statements (provided as lists
    of strings) are equivalent. If the external verifier returns 0, the
    statements are considered equivalent. The external verifier must accept two
    files containing sql statements as arguments.
    """
    def __init__(self, exec_path: str):
        """
        :param exec_path: Path to the external verifier
        """
        self.exec_path = exec_path

    def verify(self, a: List[str], b: List[str]):
        """
        Implement verify from AbstractVerifier
        """
        # TODO: place these files in a better location / ensure no existing file is overwritten
        arg1 = "tmp1.sql"
        arg2 = "tmp2.sql"
        with open(arg1, 'w') as f:
            f.writelines(a)
        with open(arg2, 'w') as f:
            f.writelines(b)
        return_code = system(f"{self.exec_path} {arg1} {arg2}")
        remove(arg1)
        remove(arg2)
        return return_code == 0


class Verifier(AbstractVerifier):
    """
    Implementation for an external verifier that works like c-reduce.
    """
    def __init__(self, exec_path: Union[str, Path], output_name: str):
        self.exec_path = Path(exec_path)
        self.working_dir = self.exec_path.parent
        self.output_name = output_name

    # TODO: unify interfaces (a = original currently not needed here)
    def verify(self, a: List[str], b: List[str]):
        """
        Writes the reduced statement to the same directory as the executable, then
        executes the executable in that directory. If return code is 0, return True.
        Otherwise return False.
        :param a: sql statement(s) provided as list of strings
        :param b: sql statement(s) provided as list of strings
        :return: Bool
        """
        with open(self.working_dir / self.output_name, 'w') as f:
            f.writelines(b)
        return 0 == system(f"cd {self.working_dir}; {self.exec_path.absolute()}")
