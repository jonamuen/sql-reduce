import unittest
from itertools import combinations
from lark import Tree, Token
from lark import ParseError
from utils import partial_equivalence
from transformation import StatementRemover, PrettyPrinter
from pathlib import Path
from sql_parser import SQLParser
from reducer import Reducer
from verifier import AbstractVerifier, ExternalVerifier, SQLiteReturnSetVerifier, Verifier

# TODO: add tests for reducer
# TODO: add tests for verifier
# TODO: add tests for split_into_stmts

class PartialEquivalenceTest(unittest.TestCase):
    def test_simple_equiv(self):
        full = Tree('n0', [])
        partial = None
        self.assertTrue(partial_equivalence(full, partial))

    def test_identical(self):
        full = Tree('n0', [])
        self.assertTrue(partial_equivalence(full, full))

    def test_label_mismatch(self):
        full = Tree('a', [])
        partial = Tree('b', [])
        self.assertFalse(partial_equivalence(full, partial))

    def test_none_children(self):
        full = Tree('a', [])
        partial = Tree('a', None)
        self.assertTrue(partial_equivalence(full, partial))

    def test_num_children_mismatch(self):
        full = Tree('a', [Tree('b', [])])
        partial = Tree('a', [])
        self.assertFalse(partial_equivalence(full, partial))

    def test_child_mismatch_tree(self):
        full = Tree('a', [Tree('b', [])])
        partial = Tree('a', [Tree('c', [])])
        self.assertFalse(partial_equivalence(full, partial))

    def test_child_mismatch_token_value(self):
        full = Tree('a', [Token('t0', 'test')])
        partial = Tree('a', [Token('t0', 'toast')])
        self.assertFalse(partial_equivalence(full, partial))

    def test_child_mismatch_token_type(self):
        full = Tree('a', [Token('t0', 'test')])
        partial = Tree('a', [Token('t1', 'test')])
        self.assertFalse(partial_equivalence(full, partial))


class ParserTest(unittest.TestCase):
    @classmethod
    def setUpClass(cls) -> None:
        cls.parser = SQLParser('sql.lark', start="sql_stmt_list", debug=True, parser='lalr')

    def test_simple_select(self):
        self.parser.parse("SELECT 0;")

    def test_simple_select_from(self):
        self.parser.parse("SELECT c0 FROM t0;")

    def test_simple_create(self):
        self.parser.parse("CREATE TABLE t0 (id INT);")

    def test_select_star(self):
        self.parser.parse("SELECT * FROM t0;")

    def test_select_with_table_ref(self):
        self.parser.parse("SELECT t0.c0 FROM t0;")

    def test_semi_and_quote_in_str(self):
        tree = self.parser.parse("SELECT ''';' FROM t0;")
        self.assertEqual(1, len(tree.children))
        self.assertEqual("select_stmt", tree.children[0].children[0].data)

    def test_unexpected_stmt(self):
        tree = self.parser.parse("SLCT ''';' FROM t0;")
        self.assertEqual(1, len(tree.children))
        self.assertEqual("unexpected_stmt", tree.children[0].children[0].data)

    def test_limit(self):
        tree = self.parser.parse("SELECT c0 FROM t0 LIMIT 10;")

    def test_join(self):
        tree = self.parser.parse("SELECT c0, c1 FROM t0 JOIN t1;")

    def test_join_with_condition(self):
        tree = self.parser.parse("SELECT c0, c1 FROM t0 JOIN t1 ON c0=c1;")

    def test_where(self):
        tree = self.parser.parse("SELECT c0 FROM t0 WHERE c0 = ';';")

    def test_multiple_stmts(self):
        tree = self.parser.parse("CREATE TABLE t0 (id INT); SELECT id FROM t0;")
        expected_partial =\
            Tree('sql_stmt_list', [
                Tree('sql_stmt', [Tree("create_table_stmt", None)]),
                Tree('sql_stmt', [Tree("select_stmt", None)])])
        self.assertTrue(partial_equivalence(tree, expected_partial))


class SQLSmithFuzzTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls) -> None:
        cls.sqlitedir = Path("test/sqlsmith/sqlite")
        cls.parser = SQLParser('sql.lark', start="sql_stmt_list", debug=True, parser='lalr')

    def test_sqlite(self):
        passed = 0
        recognized = 0
        total = 0
        for f in self.sqlitedir.iterdir():
            if f.suffix == '.sql':
                total += 1
                with f.open():
                    cmd = f.read_text()
                try:
                    tree = self.parser.parse(cmd)
                    self.assertEqual(tree.data, "sql_stmt_list")
                    #self.assertNotEqual(tree.children[0].children[0].data, "unexpected_stmt")
                    if "unexpected_stmt" not in map(lambda x: x.data, tree.children[0].children):
                        recognized += 1
                    passed += 1
                except ParseError as e:
                    print(f)
                    print(cmd)
                    raise e
        print(f"recognized/passed/total: {recognized}/{passed}/{total}")
        self.assertEqual(total, passed)


class DiscardTest(unittest.TestCase):
    @classmethod
    def setUpClass(cls) -> None:
        cls.parser = SQLParser('sql.lark', start="sql_stmt_list", debug=True, parser='lalr')
        cls.tree = cls.parser.parse("CREATE TABLE t0 (id INT);"
                                    "SELECT c0 FROM t0;"
                                    "DELETE FROM t0 WHERE id=0;")

    def test_remove_nothing(self):
        srm = StatementRemover([])
        self.assertEqual(self.tree, srm.transform(self.tree))

    def test_remove_all(self):
        srm = StatementRemover([0,1,2])
        self.assertEqual(Tree("sql_stmt_list", []), srm.transform(self.tree))

    def test_remove_first(self):
        srm = StatementRemover([0])
        expected_partial = \
            Tree("sql_stmt_list", [
                Tree("sql_stmt", [Tree("select_stmt", None)]),
                Tree("sql_stmt", [Tree("unexpected_stmt", None)])
            ])
        self.assertTrue(partial_equivalence(srm.transform(self.tree), expected_partial))

    def test_remove_last(self):
        srm = StatementRemover([2])
        expected_partial =\
            Tree("sql_stmt_list", [
                Tree("sql_stmt", [Tree("create_table_stmt", None)]),
                Tree("sql_stmt", [Tree("select_stmt", None)])
            ])
        self.assertTrue(partial_equivalence(srm.transform(self.tree), expected_partial))

    def test_remove_exhaustive(self):
        """
        Try all combinations except removing nothing and removing everything.
        Check if number of remaining statements is as expected and check that
        the remaining statements were not changed.
        :return:
        """
        num_stmts = len(self.tree.children)
        for k in range(1, num_stmts):
            for x in combinations(range(num_stmts), k):
                srm = StatementRemover(list(x))
                remaining_stmts = srm.transform(self.tree).children
                self.assertEqual(len(remaining_stmts), num_stmts - len(x))
                i = 0
                j = 0
                while i < num_stmts and j < len(remaining_stmts):
                    if i not in x:
                        self.assertEqual(self.tree.children[i], remaining_stmts[j])
                        j += 1
                    i += 1


class PrettyPrinterTest(unittest.TestCase):
    @classmethod
    def setUpClass(cls) -> None:
        cls.parser = SQLParser('sql.lark', start="sql_stmt_list", debug=True, parser='lalr')
        cls.printer = PrettyPrinter()

    def test_select(self):
        tree = self.parser.parse("SELECT * FROM t0;")
        self.assertEqual("SELECT * FROM t0;", self.printer.transform(tree))

    def test_unexpected(self):
        tree = self.parser.parse("SLCT * FROM t0;")
        self.assertEqual("SLCT * FROM t0;", self.printer.transform(tree))

    def test_whitespace(self):
        tree = self.parser.parse("SELECT     *     FROM    t0    ;")
        self.assertEqual("SELECT * FROM t0;", self.printer.transform(tree))

    def test_nested(self):
        tree = self.parser.parse("SELECT * FROM (SELECT * FROM t0);")
        self.assertEqual("SELECT * FROM (SELECT * FROM t0);", self.printer.transform(tree))


class VerifierTest(unittest.TestCase):
    def test_base_class_raises_error(self):
        verifier = AbstractVerifier()
        self.assertRaises(NotImplementedError, lambda: verifier.verify([], []))

    def test_external_verifier_success(self):
        verifier = ExternalVerifier("test/external_verifier_success.sh")
        self.assertTrue(verifier.verify([], []))

    def test_external_verifier_fail(self):
        verifier = ExternalVerifier("test/external_verifier_failure.sh")
        self.assertFalse(verifier.verify([], []))

    def test_external_like_c_reduce_success(self):
        verifier = Verifier("test/external_verifier_success.sh")
        self.assertTrue(verifier.verify([], []))

    def test_external_like_c_reduce_failure(self):
        verifier = Verifier("test/external_verifier_failure.sh")
        self.assertFalse(verifier.verify([], []))

class ReducerTest(unittest.TestCase):
    @classmethod
    def setUpClass(cls) -> None:
        parser = SQLParser('sql.lark', start="sql_stmt_list", debug=True, parser='lalr')
        verifier = SQLiteReturnSetVerifier("test/test_reduce.sqlite")
        cls.reducer = Reducer(parser, verifier, [StatementRemover()])
        cls.pprinter = PrettyPrinter()

    def test_unneeded_inserts_and_tables(self):
        stmt = "CREATE TABLE t0 (id INT);" \
               "CREATE TABLE t1 (id INT);" \
               "CREATE TABLE t2 (id INT);" \
               "INSERT INTO t0 VALUES (0);" \
               "INSERT INTO t0 VALUES (1);" \
               "INSERT INTO t0 VALUES (2);" \
               "SELECT * FROM t0 WHERE id = 0;"

        # note: whitespace at the end of lines required due to the way the
        # pretty printer formats statements
        expected = "CREATE TABLE t0 (id INT); " \
                   "INSERT INTO t0 VALUES (0); " \
                   "SELECT * FROM t0 WHERE id = 0;"

        expected_tree_partial = \
            Tree('sql_stmt_list', [
                Tree('sql_stmt', [Tree("create_table_stmt", None)]),
                Tree('sql_stmt', [None]),
                Tree('sql_stmt', [Tree("select_stmt", None)])])
        result = self.reducer.reduce(stmt)
        result_str = self.pprinter.transform(result)
        self.assertEqual(expected, result_str)
        self.assertTrue(partial_equivalence(result, expected_tree_partial))

    def test_remove_unneeded_columns(self):
        stmt = "CREATE TABLE t0 (c0 INT, c1 INT);" \
               "INSERT INTO t0 VALUES (0, 1);" \
               "SELECT c0 FROM t0;"

        expected = "CREATE TABLE t0 (c0 INT); " \
                   "INSERT INTO t0 VALUES (0); " \
                   "SELECT c0 FROM t0;"

        result = self.reducer.reduce(stmt)
        result_str = self.pprinter.transform(result)
        self.assertEqual(expected, result_str)


if __name__ == '__main__':
    unittest.main()
