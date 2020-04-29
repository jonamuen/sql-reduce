import unittest
from itertools import combinations
from lark import Tree, Token, Lark
from lark import ParseError
from utils import partial_equivalence, get_grammar
from transformation import StatementRemover, PrettyPrinter, ColumnRemover, ValueMinimizer, ExprSimplifier, \
    TokenRemover, TokenRemoverNonConsec, CompoundSimplifier, OptionalRemover, OptionalFinder, BalancedParenRemover, \
    Canonicalizer, SROC, StatementRemoverByType, CaseSimplifier
from pathlib import Path
from sql_parser import SQLParser
from reducer import Reducer
from verifier import AbstractVerifier, ExternalVerifier, SQLiteReturnSetVerifier, Verifier, DuckDBVerifier
import logging

logging.basicConfig(level=logging.DEBUG)
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


# TODO: add tests for ANY, ALL, MIN, MAX
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

    def test_select_expr(self):
        tree = self.parser.parse("SELECT 3+4;")
        expected_partial = \
            Tree('sql_stmt_list', [
                Tree('sql_stmt', [Tree('select_stmt_full', None)])])
        self.assertTrue(partial_equivalence(tree, expected_partial))

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
        self.assertEqual(1, len(list(tree.find_data("order_by_clause"))))
        tree = self.parser.parse("SELECT c0 FROM t0 ORDER BY c0 ASC")
        self.assertEqual(0, len(list(tree.find_data("unexpected_stmt"))))
        self.assertEqual(1, len(list(tree.find_data("order_by_clause"))))
        tree = self.parser.parse("SELECT c0 FROM t0 ORDER BY c0 DESC;")
        self.assertEqual(0, len(list(tree.find_data("unexpected_stmt"))))
        self.assertEqual(1, len(list(tree.find_data("order_by_clause"))))

    def test_group_by(self):
        tree = self.parser.parse("SELECT c0, SUM(c1) FROM t0 GROUP BY c0;")
        self.assertEqual(0, len(list(tree.find_data("unexpected_stmt"))))
        self.assertEqual(1, len(list(tree.find_data("group_by_clause"))))

    def test_having(self):
        tree = self.parser.parse("SELECT c0, AVG(c1) AS a FROM t0 GROUP BY c0 HAVING a > 0;")
        self.assertEqual(0, len(list(tree.find_data("unexpected_stmt"))))
        self.assertEqual(1, len(list(tree.find_data("having_clause"))))

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

    def test_between(self):
        tree = self.parser.parse("SELECT c0 FROM t0 WHERE c0 BETWEEN 0 AND 3;")
        self.assertEqual(0, len(list(tree.find_data("unexpected_stmt"))))
        self.assertEqual(1, len(list(tree.find_data("k_between"))))

    def test_agg_func(self):
        tree = self.parser.parse("SELECT SUM(c0) FROM t0;")
        self.assertEqual(0, len(list(tree.find_data('unexpected_stmt'))))
        self.assertEqual(1, len(list(tree.find_data('agg_func'))))

    def test_any_all(self):
        tree = self.parser.parse("SELECT c0 FROM t0 WHERE c0 > ANY(SELECT c1 FROM t1);"
                                 "SELECT c0 FROM t0 WHERE c0 > ALL(SELECT c1 FROM t1);")
        self.assertEqual(0, len(list(tree.find_data('unexpected_stmt'))))
        self.assertEqual(1, len(list(tree.find_data('k_any'))))
        self.assertEqual(1, len(list(tree.find_data('k_all'))))

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

    def test_constraints(self):
        stmt = "create table t0 (" \
               "  c0 INT UNIQUE," \
               "  c1 TIMESTAMP DEFAULT (TIMESTAMP '1970-01-04')," \
               "  c2 VARCHAR(128) NOT NULL," \
               "  c3 PRIMARY KEY ON CONFLICT ROLLBACK," \
               "  c4 CHECK (3 + 4)," \
               "  CONSTRAINT \"fk_0\" FOREIGN KEY (id) REFERENCES t1 ON UPDATE CASCADE ON DELETE RESTRICT);"
        tree = self.parser.parse(stmt)
        print(tree)
        self.assertEqual(0, len(list(tree.find_data('unexpected_stmt'))))
        self.assertEqual(5, len(list(tree.find_data('column_constraint'))))

    def test_multiple_stmts(self):
        tree = self.parser.parse("CREATE TABLE t0 (id INT); SELECT id FROM t0;")
        expected_partial =\
            Tree('sql_stmt_list', [
                Tree('sql_stmt', [Tree("create_table_stmt", None)]),
                Tree('sql_stmt', [Tree("select_stmt_full", None)])])
        self.assertTrue(partial_equivalence(tree, expected_partial))

    def test_multiline(self):
        stmt = "SELECT id AS c0\nFROM t0;"
        expected_partial =\
            Tree('sql_stmt_list', [
                Tree('sql_stmt', [Tree('select_stmt_full', None)])])
        tree = self.parser.parse(stmt)
        self.assertTrue(partial_equivalence(tree, expected_partial))

    def test_reduced_1(self):
        stmt0 = "CREATE TABLE IF NOT EXISTS t0 (" \
                "c0 TIMESTAMP DEFAULT (TIMESTAMP '1970-01-04')," \
                "c1 INT2," \
                "c2 INTERVAL NOT NULL  DEFAULT " \
                "((INTERVAL '325458769 year 2060662154 months 321274645 " \
                "days 327813599 hours 325431290 minutes -725505005 seconds'))" \
                "CHECK (true));"
        tree = self.parser.parse(stmt0)
        self.assertEqual(0, len(list(tree.find_data('unexpected_stmt'))))
        stmt1 = "UPSERT INTO t0 (c0, c2) " \
                "VALUES(TIMESTAMP '1970-01-24', " \
                "(INTERVAL '-806173221 year -1414198475 months -756093282 " \
                "days -1436425578 hours -16965656 minutes 2134816769 seconds'));"
        tree = self.parser.parse(stmt1)
        self.assertEqual(0, len(list(tree.find_data('unexpected_stmt'))))

    def test_reduced_2(self):
        stmt0 = "CREATE TABLE IF NOT EXISTS t1 (" \
                "c0 INTERVAL DEFAULT ((INTERVAL '-344682294 year -344682294 months 1023355674 days 1023355674 hours -153452671 minutes 1023355674 seconds')), " \
                "c1 TIMESTAMP, " \
                "c2 TIMESTAMPTZ DEFAULT (NULL), " \
                "CONSTRAINT \"primary\" PRIMARY KEY (c1, c2, c0 DESC));"
        tree = self.parser.parse(stmt0)
        self.assertEqual(7, len(list(tree.find_data('list_item'))))
        stmt1 = "SELECT MIN (agg0) FROM (" \
                "SELECT MIN ('') as agg0 FROM t1 WHERE ((((-9223372036854775808) ::TIMESTAMP)) != (t1.c1)) " \
                "UNION ALL SELECT MIN ('') as agg0 FROM t1 WHERE (NOT (((((-9223372036854775808) ::TIMESTAMP)) != (t1.c1)))) " \
                "UNION ALL SELECT ALL MIN ('') as agg0 FROM t1 WHERE ((((((-9223372036854775808) ::TIMESTAMP)) != (t1.c1))) IS NULL));"
        tree = self.parser.parse(stmt1)
        self.assertEqual(0, len(list(tree.find_data('unexpected_stmt'))))

    def test_reduced3(self):
        # from issue 6
        stmt = "SELECT t1.c0 FROM t1, t2, t0 WHERE ((CONCAT ((t2.c0))) OR ((t0.c0))) UNION SELECT t1.c0 FROM t1, t2, t0 UNION SELECT t1.c0 FROM t1, t2, t0;"
        tree = self.parser.parse(stmt)
        self.assertEqual(0, len(list(tree.find_data('unexpected_stmt'))))

    def test_reduced4(self):
        # from issue 7
        stmt = "CREATE TABLE t1 (c0 VARCHAR, c1 DOUBLE, PRIMARY KEY (c1));"
        tree = self.parser.parse(stmt)
        self.assertEqual(0, len(list(tree.find_data('unexpected_stmt'))))

    def test_reduced5(self):
        # from issue 8
        stmt = "SELECT * FROM t0 WHERE (CASE WHEN (-2092433129 IN (1686547025)) THEN false WHEN (CASE WHEN t0.c0 THEN t0.c0 END) THEN t0.c0 ELSE (CASE '0.4787559219485703' WHEN t0.c0 THEN 0.17285714289053367 WHEN t0.c0 THEN '^h' END) END) UNION SELECT * FROM t0 WHERE ((CASE WHEN (CASE WHEN t0.c0 THEN t0.c0 END) THEN (CASE WHEN t0.c0 THEN '^h' END) END)) UNION SELECT * FROM t0 WHERE (((CASE WHEN (CASE WHEN t0.c0 THEN t0.c0 END) THEN (CASE WHEN t0.c0 THEN '^h' END) END)));"
        tree = self.parser.parse(stmt)
        self.assertEqual(0, len(list(tree.find_data('unexpected_stmt'))))


class UnrecognizedParserTest(unittest.TestCase):
    @classmethod
    def setUpClass(cls) -> None:
        with open('unrecognized.lark') as f:
            grammar = f.read()
        cls.parser = Lark(grammar, start='unexpected_stmt', debug=True, parser='lalr')

    def test_find_list_exprs(self):
        stmt = "UPSERT INTO main.t1 (c0, c2, c1) VALUES" \
               "((INTERVAL '551892156 year 832764392 months 1672989131 days -654812564 hours -234333674 minutes 188738307 seconds'), NULL, TIMESTAMP '1970-01-18'), " \
               "((INTERVAL '788244231 year 1956814059 months 1822208821 days 1801942109 hours -285134875 minutes 1801942109 seconds'), NULL, TIMESTAMP '1970-01-10'), " \
               "((INTERVAL '1959157503 year -1692822432 months 51618894 days 188738307 hours -1249266498 minutes 1956814059 seconds'), NULL, TIMESTAMP '1969-12-12')"
        tree = self.parser.parse(stmt)
        self.assertEqual(4, len(list(tree.find_data('list_expr'))))

    def test_reconstructability(self):
        stmt = "UPSERT INTO main.t1 (c0, c2, c1) VALUES" \
               "((INTERVAL '551892156 year 832764392 months 1672989131 days -654812564 hours -234333674 minutes 188738307 seconds'), NULL, TIMESTAMP '1970-01-18'), " \
               "((INTERVAL '788244231 year 1956814059 months 1822208821 days 1801942109 hours -285134875 minutes 1801942109 seconds'), NULL, TIMESTAMP '1970-01-10'), " \
               "((INTERVAL '1959157503 year -1692822432 months 51618894 days 188738307 hours -1249266498 minutes 1956814059 seconds'), NULL, TIMESTAMP '1969-12-12')"
        tree = self.parser.parse(stmt)
        reconstruction = PrettyPrinter().transform(tree)
        tree2 = self.parser.parse(reconstruction)
        self.assertEqual(tree, tree2)


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
        self.assertEqual(total, recognized)


class StatementRemoverTest(unittest.TestCase):
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


class StatementRemoverByTypeTest(unittest.TestCase):
    @classmethod
    def setUpClass(cls) -> None:
        cls.parser = SQLParser('sql.lark', start="sql_stmt_list", debug=True, parser='lalr')

    def test_insert(self):
        stmt = "CREATE TABLE t0(c0 INT); INSERT INTO t0 VALUES (3);"
        tree = self.parser.parse(stmt)
        remover = StatementRemoverByType()
        results = set(map(lambda x: PrettyPrinter().transform(x[1]), remover.all_transforms(tree)))
        expected = {"CREATE TABLE t0 (c0 INT);", "INSERT INTO t0 VALUES (3);"}
        self.assertEqual(expected, results)

    def test_multi_remove(self):
        stmt = "CREATE TABLE t0(c0 INT); INSERT INTO t0 VALUES (3);"
        tree = self.parser.parse(stmt)
        remover = StatementRemoverByType(multi_remove=True)
        results = set(map(lambda x: PrettyPrinter().transform(x[1]), remover.all_transforms(tree)))
        expected = {"", "CREATE TABLE t0 (c0 INT);", "INSERT INTO t0 VALUES (3);"}
        self.assertEqual(expected, results)


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

    def test_varchar(self):
        stmt = "CREATE TABLE t0 (c0 VARCHAR (128));"
        tree = self.parser.parse(stmt)
        self.assertEqual(stmt, self.printer.transform(tree))

    def test_unexpected(self):
        tree = self.parser.parse("SLCT * FROM t0 WHERE ((3 + 4) - 2) >= 0;")
        self.assertEqual("SLCT * FROM t0 WHERE ((3 + 4) - 2) >= 0;", self.printer.transform(tree))

    def test_whitespace(self):
        tree = self.parser.parse("SELECT     *     FROM    t0    ;")
        self.assertEqual("SELECT * FROM t0;", self.printer.transform(tree))

    def test_nested(self):
        tree = self.parser.parse("SELECT * FROM (SELECT * FROM t0);")
        self.assertEqual("SELECT * FROM (SELECT * FROM t0);", self.printer.transform(tree))

    def test_fully_qualified_column_name(self):
        stmt = "SELECT main.t0.c0 FROM main.t0;"
        tree = self.parser.parse(stmt)
        self.assertEqual(stmt, self.printer.transform(tree))

    def test_reduced2(self):
        stmt0 = "CREATE TABLE IF NOT EXISTS t1 (" \
                "c0 INTERVAL DEFAULT ((INTERVAL '-344682294 year -344682294 months 1023355674 days 1023355674 hours -153452671 minutes 1023355674 seconds')), " \
                "c1 TIMESTAMP, " \
                "c2 TIMESTAMPTZ DEFAULT (NULL), " \
                "CONSTRAINT \"primary\" PRIMARY KEY (c1, c2, c0 DESC));"
        tree = self.parser.parse(stmt0)
        self.assertEqual(tree, self.parser.parse(self.printer.transform(tree)))
        stmt1 = "SELECT MIN (agg0) FROM (" \
                "SELECT MIN ('') as agg0 FROM t1 WHERE ((((-9223372036854775808) ::TIMESTAMP)) != (t1.c1)) " \
                "UNION ALL SELECT MIN ('') as agg0 FROM t1 WHERE (NOT (((((-9223372036854775808) ::TIMESTAMP)) != (t1.c1)))) " \
                "UNION ALL SELECT ALL MIN ('') as agg0 FROM t1 WHERE ((((((-9223372036854775808) ::TIMESTAMP)) != (t1.c1))) IS NULL));"
        tree = self.parser.parse(stmt1)
        print(stmt1)
        print(self.printer.transform(tree))
        self.assertEqual(tree, self.parser.parse(self.printer.transform(tree)))


class CanonicalizerTest(unittest.TestCase):
    @classmethod
    def setUpClass(cls) -> None:
        cls.parser = SQLParser('sql.lark', start='sql_stmt_list', debug=True, parser='lalr')
        cls.pprinter = PrettyPrinter()
        cls.canonicalizer = Canonicalizer()

    def test_types(self):
        stmt = "CREATE TABLE t0 (id VARCHAR(16), a BIGINT, b UNSIGNED INT);"
        tree = self.parser.parse(stmt)
        expected = ["CREATE TABLE t0 (id INT, a INT, b INT);",
                    "CREATE TABLE t0 (id INT, a BIGINT, b UNSIGNED INT);",
                    "CREATE TABLE t0 (id VARCHAR (16), a INT, b UNSIGNED INT);",
                    "CREATE TABLE t0 (id VARCHAR (16), a BIGINT, b INT);"]
        for _, x in self.canonicalizer.all_transforms(tree):
            self.assertIn(self.pprinter.transform(x), expected)

    def test_upsert(self):
        stmt = "UPSERT INTO t0 VALUES (0, 1), (1, 2);"
        tree = self.parser.parse(stmt)
        expected = ["INSERT INTO t0 VALUES (0, 1), (1, 2);"]
        results = list(self.canonicalizer.all_transforms(tree))
        for _, res in results:
            self.assertIn(self.pprinter.transform(res), expected)
        self.assertEqual(1, len(results))


class OptionalRemoverTest(unittest.TestCase):
    @classmethod
    def setUpClass(cls) -> None:
        cls.parser = SQLParser('sql.lark', start='sql_stmt_list', debug=True, parser='lalr')
        cls.pprinter = PrettyPrinter()
        cls.optionals = OptionalFinder().transform(get_grammar('sql.lark', 'lark.lark'))

    def test_from_clause(self):
        stmt = "SELECT * FROM t0 WHERE c0 > c1;"
        tree = self.parser.parse(stmt)
        orm = OptionalRemover(remove_list=[0], optionals=self.optionals)
        result = orm.transform(tree)

        expected = "SELECT * WHERE c0 > c1;"
        self.assertEqual(expected, self.pprinter.transform(result))

    def test_where_clause(self):
        stmt = "SELECT * FROM t0 WHERE c0 > c1;"
        tree = self.parser.parse(stmt)
        orm = OptionalRemover(remove_list=[1], optionals=self.optionals)
        result = orm.transform(tree)

        expected = "SELECT * FROM t0;"
        self.assertEqual(expected, self.pprinter.transform(result))

    def test_all_transforms(self):
        stmt = "SELECT * FROM t0 WHERE c0 > c1 UNION ALL SELECT c0 FROM t0;"
        tree = self.parser.parse(stmt)
        orm = OptionalRemover(optionals=self.optionals)
        self.assertEqual(7, len(list(orm.all_transforms(tree))))


class ColumnRemoverTest(unittest.TestCase):
    @classmethod
    def setUpClass(cls) -> None:
        cls.scrm = ColumnRemover()
        cls.parser = SQLParser('sql.lark', start="sql_stmt_list", debug=True, parser='lalr')
        cls.pprinter = PrettyPrinter()

    def test_simple(self):
        stmt = "INSERT INTO t0(c0, c1, c2) VALUES (0, 1, 2), (2, 1, 0);"
        tree = self.parser.parse(stmt)
        self.scrm.set_up([1])
        result = self.scrm.transform(tree)
        expected = "INSERT INTO t0 (c0, c2) VALUES (0, 2), (2, 0);"
        print(self.pprinter.transform(result))
        self.assertEqual(self.parser.parse(expected), result)

    def test_tree_unmodified(self):
        stmt = "CREATE TABLE t0 (c0 INT);" \
               "INSERT INTO t0 VALUES (0);" \
               "UPDATE t0 SET c0=0;"
        self.scrm.set_up([-1])  # dont remove anything
        tree = self.parser.parse(stmt)
        result = self.scrm.transform(tree)
        self.assertEqual(self.parser.parse(stmt), tree)
        self.assertEqual(self.parser.parse(stmt), result)

    def test_columns_correctly_counted(self):
        stmt = "CREATE TABLE t0 (c0 INT);" \
               "INSERT INTO t0 VALUES (0);" \
               "UPDATE t0 SET c0=0;"
        self.scrm.set_up([-1]) # dont remove anything, just count
        tree = self.parser.parse(stmt)
        self.scrm.transform(tree)
        self.assertEqual(3, self.scrm.index)

    def test_create_table(self):
        stmt = "CREATE TABLE t0 (c0 INT, c1 INT);"
        self.scrm.set_up([1])
        tree = self.parser.parse(stmt)
        result = self.scrm.transform(tree)
        expected = self.parser.parse("CREATE TABLE t0 (c0 INT);")
        self.assertEqual(expected, result)

    def test_no_inserts(self):
        stmt = "SELECT c0, c1 FROM t0;"
        self.scrm.set_up([0])
        result = self.scrm.transform(self.parser.parse(stmt))
        self.assertEqual(self.parser.parse(stmt), result)

    def test_no_explicit_column_refs(self):
        stmt = "INSERT INTO t0 VALUES (0, 1, 2);"
        self.scrm.set_up([0])
        result = self.scrm.transform(self.parser.parse(stmt))
        expected = "INSERT INTO t0 VALUES (1, 2);"
        self.assertEqual(self.parser.parse(expected), result)

    def test_multiple_inserts(self):
        stmt = "INSERT INTO t0(c0, c1, c2) VALUES (0, 1, 2), (2, 1, 0);" \
               "INSERT INTO t1(c0, c1) VALUES (3, 4);"
        tree = self.parser.parse(stmt)
        self.scrm.set_up([3])
        result = self.scrm.transform(tree)
        expected = "INSERT INTO t0 (c0, c1, c2) VALUES (0, 1, 2), (2, 1, 0); " \
                   "INSERT INTO t1 (c1) VALUES (4);"
        print(self.pprinter.transform(result))
        self.assertEqual(self.parser.parse(expected), result)

    def test_update(self):
        stmt = "UPDATE t0 SET c0=0, c1=1;"
        tree = self.parser.parse(stmt)
        self.scrm.set_up([1])
        result = self.scrm.transform(tree)
        expected = self.parser.parse("UPDATE t0 SET c0=0;")
        self.assertEqual(expected, result)

    def test_constraints(self):
        stmt = "CREATE TABLE t0 (id INT UNIQUE, FOREIGN KEY (id) REFERENCES t1);"
        expected = ["CREATE TABLE t0 (FOREIGN KEY (id) REFERENCES t1);",
                    "CREATE TABLE t0 (id INT UNIQUE);"]
        results = list(map(lambda x: PrettyPrinter().transform(x[1]), self.scrm.all_transforms(self.parser.parse(stmt))))
        for exp in expected:
            self.assertIn(exp, results)

    def test_all_transforms(self):
        stmt = "INSERT INTO t0(c0, c1, c2) VALUES (0, 1, 2), (2, 1, 0);"
        expected = [
            "INSERT INTO t0 (c1, c2) VALUES (1, 2), (1, 0);",
            "INSERT INTO t0 (c0, c2) VALUES (0, 2), (2, 0);",
            "INSERT INTO t0 (c0, c1) VALUES (0, 1), (2, 1);"
        ]
        results = list(map(lambda x: x[1], self.scrm.all_transforms(self.parser.parse(stmt))))
        for exp in expected:
            self.assertIn(self.parser.parse(exp), results)


class CompoundSimplifierTest(unittest.TestCase):
    @classmethod
    def setUpClass(cls) -> None:
        cls.parser = SQLParser('sql.lark', start='sql_stmt_list', debug=True, parser='lalr')
        cls.pprinter = PrettyPrinter()

    def test_remove_left(self):
        stmt = "SELECT c0 FROM t0 UNION SELECT c1 FROM t0;"
        expected = "SELECT c1 FROM t0;"
        tree = self.parser.parse(stmt)
        compsimp = CompoundSimplifier([0])
        result = self.pprinter.transform(compsimp.transform(tree))
        self.assertEqual(expected, result)

    def test_remove_right(self):
        stmt = "SELECT c0 FROM t0 UNION SELECT c1 FROM t0;"
        expected = "SELECT c0 FROM t0;"
        tree = self.parser.parse(stmt)
        compsimp = CompoundSimplifier([1])
        result = self.pprinter.transform(compsimp.transform(tree))
        self.assertEqual(expected, result)

    def test_remove_middle(self):
        stmt = "SELECT c0 FROM t0 UNION ALL SELECT c1 FROM t0 UNION SELECT c2 FROM t0;"
        expected = "SELECT c0 FROM t0 UNION SELECT c2 FROM t0;"
        tree = self.parser.parse(stmt)
        compsimp = CompoundSimplifier([1])
        result = self.pprinter.transform(compsimp.transform(tree))
        self.assertEqual(expected, result)

    def test_remove_from_subquery(self):
        stmt = "SELECT c0, (SELECT c1 FROM t1 UNION SELECT c2 FROM t0) FROM t0;"
        expected = "SELECT c0, (SELECT c1 FROM t1) FROM t0;"
        tree = self.parser.parse(stmt)
        compsimp = CompoundSimplifier([1])
        result = self.pprinter.transform(compsimp.transform(tree))
        self.assertEqual(expected, result)

    def test_all_transforms(self):
        stmt = "SELECT c0 FROM t0 UNION SELECT c1 FROM t0 UNION SELECT c2 FROM t0;"
        expected = "SELECT c0 FROM t0 UNION SELECT c1 FROM t0;"
        tree = self.parser.parse(stmt)
        compsimp = CompoundSimplifier()
        result = map(self.pprinter.transform, map(lambda x: x[1], compsimp.all_transforms(tree)))
        self.assertIn(expected, result)


class ExprSimplifierTest(unittest.TestCase):
    @classmethod
    def setUpClass(cls) -> None:
        cls.parser = SQLParser('sql.lark', start="sql_stmt_list", debug=True, parser='lalr')
        cls.simplifier = ExprSimplifier()

    def test_1(self):
        tree = self.parser.parse("SELECT NOT c0 + c1 * c2 FROM t0;")
        for _, x in self.simplifier.all_transforms(tree):
            print(PrettyPrinter().transform(x))
        print(self.simplifier.index)

    def test_2(self):
        tree = self.parser.parse("SELECT NULLIF(c0 + c1, c0 - c1) FROM t0;")
        for _, x in self.simplifier.all_transforms(tree):
            print(PrettyPrinter().transform(x))
        print(self.simplifier.index)

    def test_3(self):
        tree = self.parser.parse("SELECT CAST(c0 * c1 AS INT) FROM t0;")
        for _, x in self.simplifier.all_transforms(tree):
            print(PrettyPrinter().transform(x))
        print(self.simplifier.index)


class CaseSimplifierTest(unittest.TestCase):
    @classmethod
    def setUpClass(cls) -> None:
        cls.parser = SQLParser('sql.lark', start="sql_stmt_list", debug=True, parser='lalr')
        cls.simplifier = CaseSimplifier()

    def test_all(self):
        stmt = 'SELECT (CASE WHEN c0 > 0 THEN c0 WHEN c0 < 0 THEN 0 ELSE NULL END) FROM t0;'
        tree = self.parser.parse(stmt)
        results = set(map(lambda x: PrettyPrinter().transform(x[1]), self.simplifier.all_transforms(tree)))
        expected_partial = {'SELECT (CASE WHEN c0 < 0 THEN 0 ELSE NULL END) FROM t0;',
                            'SELECT (CASE WHEN c0 > 0 THEN c0 ELSE NULL END) FROM t0;',
                            'SELECT (CASE WHEN c0 > 0 THEN c0 WHEN c0 < 0 THEN 0 END) FROM t0;'}
        for x in expected_partial:
            self.assertIn(x, results)


class BalancedParenRemoverTest(unittest.TestCase):
    @classmethod
    def setUpClass(cls) -> None:
        cls.parser = SQLParser('sql.lark', start="sql_stmt_list", debug=True, parser='lalr')
        cls.remover = BalancedParenRemover()

    def test_no_parentheses(self):
        tree = self.parser.parse('SELECT c0 FROM t0;')
        results = list(map(lambda x: PrettyPrinter().transform(x[1]), self.remover.all_transforms(tree)))
        self.assertEqual(0, len(results))

    def test_unrec(self):
        stmt = "SLCT t0.c0 FROM t0 JOIN t2 ON (((t2.c2)) <= (((t0.c0) - (t2.c0)))) WHERE (((t2.c1)) <= (t0.c0));"
        tree = self.parser.parse(stmt)
        results = list(self.remover.all_transforms(tree))
        self.assertEqual(21, len(results))

    def test_multiple(self):
        stmt = "SELECT t0.c0 FROM t0 JOIN t2 ON (((t2.c2)) <= (((t0.c0) - (t2.c0)))) WHERE (((t2.c1)) <= (t0.c0));"
        tree = self.parser.parse(stmt)
        results = list(map(lambda x: PrettyPrinter().transform(x[1]), self.remover.all_transforms(tree)))
        self.assertEqual(21, len(results))

    def test_all_transforms(self):
        tree = self.parser.parse('SELECT ((((0) + 1) + 2) + 3) FROM t0;')
        results = list(map(lambda x: PrettyPrinter().transform(x[1]), self.remover.all_transforms(tree)))
        self.assertIn('SELECT 0 + 1 + 2 + 3 FROM t0;', results)
        self.assertIn('SELECT ((0 + 1 + 2) + 3) FROM t0;', results)


class ValueMinimizerTest(unittest.TestCase):
    @classmethod
    def setUpClass(cls) -> None:
        cls.parser = SQLParser('sql.lark', start="sql_stmt_list", debug=True, parser='lalr')
        cls.minimizer = ValueMinimizer()
        cls.pprinter = PrettyPrinter()

    def test_pos_int(self):
        tree = self.parser.parse("SELECT +9;")
        results = set(map(lambda x: x[1], self.minimizer.all_transforms(tree)))
        expected = {self.parser.parse("SELECT 0;"),
                    self.parser.parse("SELECT -1;"),
                    self.parser.parse("SELECT 1;"),
                    self.parser.parse("SELECT NULL;")}
        self.assertEqual(expected, results)

    def test_neg_float(self):
        tree = self.parser.parse("SELECT -1.0;")
        results = set(map(lambda x: self.pprinter.transform(x[1]), self.minimizer.all_transforms(tree)))
        expected = {"SELECT 0.0;",
                    "SELECT -1.0;",
                    "SELECT 1.0;",
                    "SELECT NULL;"}
        self.assertEqual(expected, results)

    def test_str_in_unrecognized(self):
        # force parse error with SLCT
        tree = self.parser.parse("SLCT 'bla';")
        results = set(map(lambda x: self.pprinter.transform(x[1]), self.minimizer.all_transforms(tree)))
        expected = {"SLCT '';",
                    "SLCT NULL;"}
        self.assertEqual(expected, results)


class SROCTest(unittest.TestCase):
    @classmethod
    def setUpClass(cls) -> None:
        cls.parser = SQLParser('sql.lark', start="sql_stmt_list", debug=True, parser='lalr')
        cls.replacer = SROC()
        cls.pprinter = PrettyPrinter()
        cls.replacements = ["''", '0', '1', '-1', 'NULL']

    def test_simple(self):
        tree = self.parser.parse("SELECT c0 FROM t0;")
        results = set(map(lambda x: self.pprinter.transform(x[1]), self.replacer.all_transforms(tree)))
        expected = {f"SELECT {x} FROM t0;" for x in self.replacements}
        self.assertEqual(expected, results)

    def test_where(self):
        tree = self.parser.parse("SELECT c0 FROM t0 WHERE c0 > 0;")
        results = set(map(lambda x: self.pprinter.transform(x[1]), self.replacer.all_transforms(tree)))
        expected = {f"SELECT {x} FROM t0 WHERE c0 > 0;" for x in self.replacements}
        expected |= {f"SELECT c0 FROM t0 WHERE {x} > 0;" for x in self.replacements}
        expected |= {f"SELECT {x} FROM t0 WHERE {x} > 0;" for x in self.replacements}
        self.assertEqual(expected, results)

    def test_subquery(self):
        tree = self.parser.parse("SELECT c0 FROM (SELECT c1 AS c0 FROM t0);")
        results = set(map(lambda x: self.pprinter.transform(x[1]), self.replacer.all_transforms(tree)))
        expected = {f"SELECT {x} FROM (SELECT {x} AS c0 FROM t0);" for x in self.replacements}
        expected |= {f"SELECT {x} FROM (SELECT c1 AS c0 FROM t0);" for x in self.replacements}
        expected |= {f"SELECT c0 FROM (SELECT {x} AS c0 FROM t0);" for x in self.replacements}
        self.assertEqual(expected, results)

    def test_nested_expr(self):
        tree = self.parser.parse("SELECT (c0 + c1) FROM t0;")
        results = set(map(lambda x: self.pprinter.transform(x[1]), self.replacer.all_transforms(tree)))
        expected = {f"SELECT ({x} + c1) FROM t0;" for x in self.replacements}
        expected |= {f"SELECT (c0 + {x}) FROM t0;" for x in self.replacements}
        expected |= {f"SELECT ({x} + {x}) FROM t0;" for x in self.replacements}
        self.assertEqual(expected, results)

class TokenRemoverTest(unittest.TestCase):
    @classmethod
    def setUpClass(cls) -> None:
        cls.parser = SQLParser('sql.lark', start="sql_stmt_list", debug=True, parser='lalr')
        cls.trm = TokenRemover()

    def test_simple_all_transforms(self):
        stmt = "CHECK (true);"
        tree = self.parser.parse(stmt)
        expected = set(map(self.parser.parse, ["CHECK;", "(true);", ""]))
        result = set(x for _,x in self.trm.all_transforms(tree))
        self.assertEqual(expected, result)

    def test_constraint(self):
        tree = self.parser.parse("CREATE TABLE IF NOT EXISTS t0 (c2 INTERVAL CHECK (true));")
        expected = self.parser.parse("CREATE TABLE IF NOT EXISTS t0 (c2 INTERVAL);")
        results = [x for _, x in self.trm.all_transforms(tree)]
        self.assertIn(expected, results)

    def test_consecutive_tokens(self):
        tree = self.parser.parse("CREATE TABLE IF NOT EXISTS t0 (c2 INTERVAL) CHECK (true);")
        expected = self.parser.parse("CREATE TABLE t0 (c2 INTERVAL) CHECK (true);")
        results = [x for _, x in self.trm.all_transforms(tree)]
        self.assertIn(expected, results)

    def test_remove_column_ref_parseable(self):
        stmt = "UPSERT INTO t0 (c2) VALUES (TIMESTAMP 'year');"
        tree = self.parser.parse(stmt)
        expected = self.parser.parse("UPSERT INTO t0 VALUES (TIMESTAMP 'year');")
        results = [x for _, x in self.trm.all_transforms(tree)]
        self.assertIn(expected, results)

    def test_remove_column_ref_non_parseable(self):
        stmt = "UPSRT INTO t0 (c2) VALUES (TIMESTAMP 'year');"
        tree = self.parser.parse(stmt)
        expected = self.parser.parse("UPSRT INTO t0 VALUES (TIMESTAMP 'year');")
        results = [x for _, x in self.trm.all_transforms(tree)]
        self.assertIn(expected, results)


class TokenRemoverNonConsecTest(unittest.TestCase):
    @classmethod
    def setUpClass(cls) -> None:
        cls.parser = SQLParser('sql.lark', start="sql_stmt_list", debug=True, parser='lalr')
        cls.trm = TokenRemoverNonConsec()

    def test_non_consecutive_tokens(self):
        tree = self.parser.parse("CREATE TABLE IF NOT EXISTS t0 (c2 INTERVAL) CHECK (true);")
        expected = "CREATE TABLE NOT t0 (c2 INTERVAL) CHECK (true);"
        results = map(lambda x: PrettyPrinter().transform(x[1]), self.trm.all_transforms(tree))
        self.assertIn(expected, results)


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


class DuckDBVerifierTest(unittest.TestCase):
    @classmethod
    def setUpClass(cls) -> None:
        cls.parser = SQLParser('sql.lark', start="sql_stmt_list", debug=False, parser='lalr')
        with open('test/real_testcases/duckdb/issue3.sql') as f:
            stmt = f.read()
        cls.verifier = DuckDBVerifier(original_stmt=stmt)

    def test_unmodified(self):
        with open('test/real_testcases/duckdb/issue3.sql') as f:
            tree = self.parser.parse(f.read())
        stmts = list(map(PrettyPrinter().transform, tree.children))
        self.assertTrue(self.verifier.verify([], stmts))

    def test_empty(self):
        self.assertFalse(self.verifier.verify([], []))


class ReducerTest(unittest.TestCase):
    @classmethod
    def setUpClass(cls) -> None:
        parser = SQLParser('sql.lark', start="sql_stmt_list", debug=True, parser='lalr')
        verifier = SQLiteReturnSetVerifier("test/test_reduce.sqlite")
        cls.reducer = Reducer(parser, verifier, [StatementRemover(), ColumnRemover(), ExprSimplifier()], [])
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
        self.assertEqual(expected, result)

    def test_remove_unneeded_columns(self):
        stmt = "CREATE TABLE t0 (c0 INT, c1 INT);" \
               "INSERT INTO t0 (c0, c1) VALUES (0, 1);" \
               "UPDATE t0 SET c1 = 0;" \
               "SELECT c0 FROM t0;"

        expected = "CREATE TABLE t0 (c0 INT);\n" \
                   "INSERT INTO t0 (c0) VALUES (0);\n" \
                   "SELECT c0 FROM t0;"

        result = self.reducer.reduce(stmt)
        self.assertEqual(expected, result)

    def test_expr_simplification(self):
        stmt = "SELECT 1*(3+4)+(0);"
        expected = "SELECT 3 + 4;"

        result = self.reducer.reduce(stmt)
        self.assertEqual(expected, result)


@unittest.skip
class DuckDBReducerTest(unittest.TestCase):
    @classmethod
    def setUpClass(cls) -> None:
        optionals = OptionalFinder().transform(get_grammar('sql.lark', 'lark.lark'))
        cls.parser = SQLParser('sql.lark', start="sql_stmt_list", debug=False, parser='lalr')
        cls.reduction_passes = [StatementRemover(), OptionalRemover(optionals=optionals), CompoundSimplifier(),
                                ColumnRemover(), ExprSimplifier(), BalancedParenRemover(),
                                TokenRemover(), TokenRemoverNonConsec()]
        cls.canonicalizations = [ValueMinimizer(), Canonicalizer(), SROC()]

    def test_duckdb_issue3(self):
        with open('test/real_testcases/duckdb/issue3.sql') as f:
            stmt = f.read()
        reducer = Reducer(self.parser, DuckDBVerifier(stmt, no_subprocess=False),
                          self.reduction_passes, self.canonicalizations)
        print(PrettyPrinter().transform(reducer.reduce(stmt)))

    def test_duckdb_issue4(self):
        with open('test/real_testcases/duckdb/issue4.sql') as f:
            stmt = f.read()
        reducer = Reducer(self.parser, DuckDBVerifier(stmt), self.reduction_passes, self.canonicalizations)
        print(PrettyPrinter().transform(reducer.reduce(stmt)))

    def test_duckdb_issue5(self):
        # requires c52fc9b or 5c4cde5
        with open('test/real_testcases/duckdb/issue5.sql') as f:
            stmt = f.read()
        reducer = Reducer(self.parser, DuckDBVerifier(stmt, no_subprocess=True),
                          self.reduction_passes, self.canonicalizations)
        print(PrettyPrinter().transform(reducer.reduce(stmt)))

    def test_duckdb_issue6(self):
        # requires unknown commit
        with open('test/real_testcases/duckdb/issue6.sql') as f:
            stmt = f.read()
        reducer = Reducer(self.parser, DuckDBVerifier(stmt), self.reduction_passes, self.canonicalizations)
        print(PrettyPrinter().transform(reducer.reduce(stmt)))

    def test_duckdb_issue7(self):
        with open('test/real_testcases/duckdb/issue7.sql') as f:
            stmt = f.read()
        reducer = Reducer(self.parser, DuckDBVerifier(stmt), self.reduction_passes, self.canonicalizations)
        print(PrettyPrinter().transform(reducer.reduce(stmt)))

    def test_duckdb_issue8(self):
        # requires debug build f3c7d39 to reproduce
        with open('test/real_testcases/duckdb/issue8.sql') as f:
            stmt = f.read()
        reducer = Reducer(self.parser, DuckDBVerifier(stmt), self.reduction_passes, self.canonicalizations)
        print(PrettyPrinter().transform(reducer.reduce(stmt)))

    def test_reduce_balanced(self):
        stmts = "CREATE TABLE t2 (c0 real, c1 boolean, c2 double);" \
                "CREATE TABLE t0 (c0 BIGINT);" \
                "SELECT t0.c0 FROM t0 JOIN t2 ON (((t2.c2)) <= (((t0.c0) - (t2.c0))))" \
                "  WHERE (((t2.c1)) <= (t0.c0))" \
                "UNION SELECT t0.c0 FROM t0 JOIN t2 ON (((t0.c0)))" \
                "UNION SELECT t0.c0 FROM t0 JOIN t2 ON (NULL);"
        print(self.parser.parse(stmts).pretty())
        reducer = Reducer(self.parser, DuckDBVerifier(stmts), self.reduction_passes, self.canonicalizations)
        print(PrettyPrinter().transform(reducer.reduce(stmts)))


if __name__ == '__main__':
    unittest.main()
