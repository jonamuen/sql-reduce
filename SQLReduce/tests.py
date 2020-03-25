import unittest
from lark import Lark, Tree, Token
from lark import ParseError
from sql_parser import expand_grammar
from tree_tools import partial_equivalence


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
    def setUp(self) -> None:
        expand_grammar('sql.lark')
        with open("sql.lark") as f:
            self.parser = Lark(f, start="sql_stmt_list", debug=True, parser='lalr')

    def test_simple_select(self):
        self.parser.parse("SELECT 0;")

    def test_simple_select_from(self):
        self.parser.parse("SELECT c0 FROM t0;")

    def test_simple_create(self):
        self.parser.parse("CREATE TABLE t0 (id INT);")

    def test_simple_parse_error(self):
        # missing ; at end
        self.assertRaises(ParseError, lambda: self.parser.parse("SELECT c0 FROM t0"))

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
        self.assertEqual(2, len(tree.children))
        self.assertEqual("sql_stmt", tree.children[0].data)
        self.assertEqual("sql_stmt", tree.children[1].data)
        self.assertEqual("create_table_stmt", tree.children[0].children[0].data)
        self.assertEqual("select_stmt", tree.children[1].children[0].data)


if __name__ == '__main__':
    unittest.main()
