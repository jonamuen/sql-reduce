import unittest
from itertools import combinations
from lark import Tree, Token
from lark import ParseError
from utils import partial_equivalence
from transformation import StatementRemover, PrettyPrinter, ColumnRemover, SimpleColumnRemover, ValueMinimizer, ExprSimplifier
from pathlib import Path
from sql_parser import SQLParser
from reducer import Reducer
from verifier import AbstractVerifier, ExternalVerifier, SQLiteReturnSetVerifier, Verifier
import logging

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

# TODO: add tests for SELECT expr;
class ParserTest(unittest.TestCase):
    @classmethod
    def setUpClass(cls) -> None:
        cls.parser = SQLParser('sql.lark', start="sql_stmt_list", debug=True, parser='lalr')

    def test_simple_select(self):
        tree = self.parser.parse("SELECT 0;")
        self.assertEqual(0, len(list(tree.find_data("unexpected_stmt"))))

    def test_simple_select_from(self):
        tree = self.parser.parse("SELECT c0 FROM t0;")
        self.assertEqual(0, len(list(tree.find_data("unexpected_stmt"))))

    def test_simple_create(self):
        tree = self.parser.parse("CREATE TABLE t0 (id INT);")
        self.assertEqual(0, len(list(tree.find_data("unexpected_stmt"))))

    def test_select_distinct(self):
        tree = self.parser.parse("SELECT DISTINCT id FROM t0;")
        self.assertEqual(0, len(list(tree.find_data("unexpected_stmt"))))

    def test_select_star(self):
        tree = self.parser.parse("SELECT * FROM t0;")
        self.assertEqual(0, len(list(tree.find_data("unexpected_stmt"))))

    def test_select_with_table_ref(self):
        tree = self.parser.parse("SELECT t0.c0 FROM t0;")
        self.assertEqual(0, len(list(tree.find_data("unexpected_stmt"))))

    def test_semi_and_quote_in_str(self):
        tree = self.parser.parse("SELECT ''';' FROM t0;")
        self.assertEqual(1, len(tree.children))
        self.assertEqual("select_stmt_full", tree.children[0].children[0].data)

    def test_unexpected_stmt(self):
        tree = self.parser.parse("SLCT ''';' FROM t0;")
        self.assertEqual("unexpected_stmt", tree.children[0].children[0].data)

    def test_limit(self):
        tree = self.parser.parse("SELECT c0 FROM t0 LIMIT 10;")
        self.assertEqual(0, len(list(tree.find_data("unexpected_stmt"))))

    def test_join(self):
        tree = self.parser.parse("SELECT c0, c1 FROM t0 JOIN t1;")
        self.assertEqual(0, len(list(tree.find_data("unexpected_stmt"))))

    def test_join_with_condition(self):
        tree = self.parser.parse("SELECT c0, c1 FROM t0 JOIN t1 ON c0=c1;")
        self.assertEqual(0, len(list(tree.find_data("unexpected_stmt"))))

    def test_where(self):
        tree = self.parser.parse("SELECT c0 FROM t0 WHERE c0 = ';';")
        self.assertEqual(0, len(list(tree.find_data("unexpected_stmt"))))

    def test_order_by(self):
        tree = self.parser.parse("SELECT c0 FROM t0 ORDER BY c0")
        self.assertEqual(0, len(list(tree.find_data("unexpected_stmt"))))
        tree = self.parser.parse("SELECT c0 FROM t0 ORDER BY c0 ASC")
        self.assertEqual(0, len(list(tree.find_data("unexpected_stmt"))))
        tree = self.parser.parse("SELECT c0 FROM t0 ORDER BY c0 DESC")
        self.assertEqual(0, len(list(tree.find_data("unexpected_stmt"))))

    def test_insert(self):
        tree = self.parser.parse("INSERT INTO t0 VALUES (0, 1), (1, 2);")
        self.assertEqual(0, len(list(tree.find_data("unexpected_stmt"))))
        tree = self.parser.parse("INSERT INTO t0(c0) VALUES (0);")
        self.assertEqual(0, len(list(tree.find_data("unexpected_stmt"))))

    def test_update(self):
        tree = self.parser.parse("UPDATE t0 SET id = 0;")
        self.assertEqual(1, len(list(tree.find_data("update_stmt"))))
        tree = self.parser.parse("UPDATE t0 SET id = 0, name = '' where name = NULL;")
        self.assertEqual(1, len(list(tree.find_data("update_stmt"))))

    def test_delete(self):
        tree = self.parser.parse("DELETE FROM t0;")
        self.assertEqual(1, len(list(tree.find_data("delete_stmt"))))
        tree = self.parser.parse("DELETE FROM t0 WHERE id = NULL;")
        self.assertEqual(1, len(list(tree.find_data("delete_stmt"))))

    def test_not(self):
        tree = self.parser.parse("SELECT c0 FROM t0 WHERE NOT c0 = NULL;")
        self.assertEqual(0, len(list(tree.find_data("unexpected_stmt"))))

    def test_and(self):
        tree = self.parser.parse("SELECT c0 FROM t0 WHERE NOT c0 = NULL and c1 = 0;")
        self.assertEqual(0, len(list(tree.find_data("unexpected_stmt"))))

    def test_or(self):
        tree = self.parser.parse("SELECT c0 FROM t0 WHERE NOT c0 = NULL or c1 = 0;")
        self.assertEqual(0, len(list(tree.find_data("unexpected_stmt"))))

    def test_subquery(self):
        stmt = "SELECT * FROM (SELECT id FROM t0 JOIN t1);"
        tree = self.parser.parse(stmt)
        self.assertEqual(0, len(list(tree.find_data("unexpected_stmt"))))
        self.assertEqual(2, len(list(tree.find_data("select_stmt"))))

    def test_advanced_subq(self):
        # same as 7774.sql
        stmt = """select
                      subq_0.c0 as c0
                    from
                      (select
                            ref_0.id as c0
                          from
                            main.t0 as ref_0
                          where ref_0.name is not NULL
                          limit 13) as subq_0
                    where subq_0.c0 is NULL
                    limit 131;"""
        tree = self.parser.parse(stmt)
        self.assertEqual(0, len(list(tree.find_data("unexpected_stmt"))))

    def test_multiple_stmts(self):
        tree = self.parser.parse("CREATE TABLE t0 (id INT); SELECT id FROM t0;")
        expected_partial =\
            Tree('sql_stmt_list', [
                Tree('sql_stmt', [Tree("create_table_stmt", None)]),
                Tree('sql_stmt', [Tree("select_stmt_full", None)])])
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
                    logging.log(logging.DEBUG, f.name)
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
        expected = self.parser.parse("SELECT c0 FROM t0;"
                                     "DELETE FROM t0 WHERE id=0;")
        self.assertEqual(expected, srm.transform(self.tree))

    def test_remove_last(self):
        srm = StatementRemover([2])
        expected = self.parser.parse("CREATE TABLE t0 (id INT);"
                                     "SELECT c0 FROM t0;")
        self.assertEqual(expected, srm.transform(self.tree))

    def test_complexity(self):
        srm = StatementRemover(max_iterations=4)
        self.assertGreaterEqual(4, len(list(srm.all_transforms(self.tree))))
        srm = StatementRemover(max_simultaneous=1)
        self.assertGreaterEqual(3, len(list(srm.all_transforms(self.tree))))

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


class ColumnRemoverTest(unittest.TestCase):
    @classmethod
    def setUpClass(cls) -> None:
        cls.columnRemover = ColumnRemover()
        cls.parser = SQLParser('sql.lark', start="sql_stmt_list", debug=True, parser='lalr')

    def test_simple(self):
        stmt = "CREATE TABLE t0 (id INT, name VARCHAR(28)); SELECT id FROM t0;"
        tree = self.parser.parse(stmt)
        self.columnRemover._find_column_names(tree)


class PrettyPrinterTest(unittest.TestCase):
    @classmethod
    def setUpClass(cls) -> None:
        cls.parser = SQLParser('sql.lark', start="sql_stmt_list", debug=True, parser='lalr')
        cls.printer = PrettyPrinter()

    def test_select(self):
        tree = self.parser.parse("SELECT * FROM t0;")
        self.assertEqual("SELECT * FROM t0;", self.printer.transform(tree))

    def test_create_table(self):
        stmt = "CREATE TABLE t0 (c0 INT, c1 INT);"
        tree = self.parser.parse(stmt)
        self.assertEqual(stmt, self.printer.transform(tree))

    def test_unexpected(self):
        tree = self.parser.parse("SLCT * FROM t0;")
        self.assertEqual("SLCT * FROM t0;", self.printer.transform(tree))

    def test_whitespace(self):
        tree = self.parser.parse("SELECT     *     FROM    t0    ;")
        self.assertEqual("SELECT * FROM t0;", self.printer.transform(tree))

    def test_nested(self):
        tree = self.parser.parse("SELECT * FROM (SELECT * FROM t0);")
        self.assertEqual("SELECT * FROM (SELECT * FROM t0);", self.printer.transform(tree))


class SimpleColumnRemoverTest(unittest.TestCase):
    @classmethod
    def setUpClass(cls) -> None:
        cls.scrm = SimpleColumnRemover(1)
        cls.parser = SQLParser('sql.lark', start="sql_stmt_list", debug=True, parser='lalr')
        cls.pprinter = PrettyPrinter()

    def test_simple(self):
        stmt = "INSERT INTO t0(c0, c1, c2) VALUES (0, 1, 2), (2, 1, 0);"
        tree = self.parser.parse(stmt)
        self.scrm.remove_index = 1
        result = self.scrm.transform(tree)
        expected = "INSERT INTO t0 (c0, c2) VALUES (0, 2), (2, 0);"
        print(self.pprinter.transform(result))
        self.assertEqual(self.parser.parse(expected), result)

    def test_tree_unmodified(self):
        stmt = "CREATE TABLE t0 (c0 INT);" \
               "INSERT INTO t0 VALUES (0);" \
               "UPDATE t0 SET c0=0;"
        self.scrm.remove_index = -1  # dont remove anything
        tree = self.parser.parse(stmt)
        result = self.scrm.transform(tree)
        self.assertEqual(self.parser.parse(stmt), tree)
        self.assertEqual(self.parser.parse(stmt), result)

    def test_columns_correctly_counted(self):
        stmt = "CREATE TABLE t0 (c0 INT);" \
               "INSERT INTO t0 VALUES (0);" \
               "UPDATE t0 SET c0=0;"
        self.scrm.remove_index = -1 # dont remove anything, just count
        tree = self.parser.parse(stmt)
        self.scrm.transform(tree)
        self.assertEqual(3, self.scrm._num_column_refs)

    def test_create_table(self):
        stmt = "CREATE TABLE t0 (c0 INT, c1 INT);"
        self.scrm.remove_index = 1
        tree = self.parser.parse(stmt)
        result = self.scrm.transform(tree)
        expected = self.parser.parse("CREATE TABLE t0 (c0 INT);")
        self.assertEqual(expected, result)

    def test_no_inserts(self):
        stmt = "SELECT c0, c1 FROM t0;"
        self.scrm.remove_index = 0
        result = self.scrm.transform(self.parser.parse(stmt))
        self.assertEqual(self.parser.parse(stmt), result)

    def test_no_explicit_column_refs(self):
        stmt = "INSERT INTO t0 VALUES (0, 1, 2);"
        self.scrm.remove_index = 0
        result = self.scrm.transform(self.parser.parse(stmt))
        expected = "INSERT INTO t0 VALUES (1, 2);"
        self.assertEqual(self.parser.parse(expected), result)

    def test_multiple_inserts(self):
        stmt = "INSERT INTO t0(c0, c1, c2) VALUES (0, 1, 2), (2, 1, 0);" \
               "INSERT INTO t1(c0, c1) VALUES (3, 4);"
        tree = self.parser.parse(stmt)
        self.scrm.remove_index = 3
        result = self.scrm.transform(tree)
        expected = "INSERT INTO t0 (c0, c1, c2) VALUES (0, 1, 2), (2, 1, 0); " \
                   "INSERT INTO t1 (c1) VALUES (4);"
        print(self.pprinter.transform(result))
        self.assertEqual(self.parser.parse(expected), result)

    def test_update(self):
        stmt = "UPDATE t0 SET c0=0, c1=1;"
        tree = self.parser.parse(stmt)
        self.scrm.remove_index = 1
        result = self.scrm.transform(tree)
        expected = self.parser.parse("UPDATE t0 SET c0=0;")
        self.assertEqual(expected, result)

    def test_all_transforms(self):
        stmt = "INSERT INTO t0(c0, c1, c2) VALUES (0, 1, 2), (2, 1, 0);"
        expected = [
            "INSERT INTO t0 (c1, c2) VALUES (1, 2), (1, 0);",
            "INSERT INTO t0 (c0, c2) VALUES (0, 2), (2, 0);",
            "INSERT INTO t0 (c0, c1) VALUES (0, 1), (2, 1);"
        ]
        results = self.scrm.all_transforms(self.parser.parse(stmt))
        for exp, res in zip(expected, results):
            self.assertEqual(self.parser.parse(exp), res)


class ExprSimplifierTest(unittest.TestCase):
    @classmethod
    def setUpClass(cls) -> None:
        cls.parser = SQLParser('sql.lark', start="sql_stmt_list", debug=True, parser='lalr')
        cls.simplifier = ExprSimplifier()

    def test_1(self):
        tree = self.parser.parse("SELECT NOT c0 + c1 * c2 FROM t0;")
        for x in self.simplifier.all_transforms(tree):
            print(PrettyPrinter().transform(x))
        print(self.simplifier._num_reduction_opportunities)

    def test_2(self):
        tree = self.parser.parse("SELECT NULLIF(c0 + c1, c0 - c1) FROM t0;")
        for x in self.simplifier.all_transforms(tree):
            print(PrettyPrinter().transform(x))
        print(self.simplifier._num_reduction_opportunities)

    def test_3(self):
        tree = self.parser.parse("SELECT CAST(c0 * c1 AS INT) FROM t0;")
        for x in self.simplifier.all_transforms(tree):
            print(PrettyPrinter().transform(x))
        print(self.simplifier._num_reduction_opportunities)


class ValueMinimizerTest(unittest.TestCase):
    @classmethod
    def setUpClass(cls) -> None:
        cls.parser = SQLParser('sql.lark', start="sql_stmt_list", debug=True, parser='lalr')
        cls.minimizer = ValueMinimizer()

    def test_pos_int(self):
        tree = self.parser.parse("SELECT +9;")
        result = self.minimizer.transform(tree)
        expected = self.parser.parse("SELECT 4;")
        self.assertEqual(expected, result)

    def test_neg_float(self):
        tree = self.parser.parse("SELECT -1.0;")
        result = self.minimizer.transform(tree)
        expected = self.parser.parse("SELECT -0.0;")
        self.assertEqual(expected, result)

    def test_null(self):
        tree = self.parser.parse("SELECT NULL;")
        result = self.minimizer.transform(tree)
        expected = self.parser.parse("SELECT NULL;")
        self.assertEqual(expected, result)


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
        verifier = Verifier("test/external_verifier_success.sh", "small.sql")
        self.assertTrue(verifier.verify([], []))

    def test_external_like_c_reduce_failure(self):
        verifier = Verifier("test/external_verifier_failure.sh", "small.sql")
        self.assertFalse(verifier.verify([], []))


class ReducerTest(unittest.TestCase):
    @classmethod
    def setUpClass(cls) -> None:
        parser = SQLParser('sql.lark', start="sql_stmt_list", debug=True, parser='lalr')
        verifier = SQLiteReturnSetVerifier("test/test_reduce.sqlite")
        cls.reducer = Reducer(parser, verifier, [StatementRemover(), SimpleColumnRemover()])
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
        expected = "CREATE TABLE t0 (id INT);\n" \
                   "INSERT INTO t0 VALUES (0);\n" \
                   "SELECT * FROM t0 WHERE id = 0;"

        result = self.reducer.reduce(stmt)
        result_str = self.pprinter.transform(result)
        self.assertEqual(expected, result_str)

    def test_remove_unneeded_columns(self):
        stmt = "CREATE TABLE t0 (c0 INT, c1 INT);" \
               "INSERT INTO t0 (c0, c1) VALUES (0, 1);" \
               "UPDATE t0 SET c1 = 0;" \
               "SELECT c0 FROM t0;"

        expected = "CREATE TABLE t0 (c0 INT);\n" \
                   "INSERT INTO t0 (c0) VALUES (0);\n" \
                   "SELECT c0 FROM t0;"

        result = self.reducer.reduce(stmt)
        result_str = self.pprinter.transform(result)
        self.assertEqual(expected, result_str)


if __name__ == '__main__':
    unittest.main()
