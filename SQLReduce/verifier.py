import sqlite3
from typing import List
from os import remove, system


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
