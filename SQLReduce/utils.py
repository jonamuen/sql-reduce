from lark import Tree, Token, Lark
from typing import Union, Optional

from lark.visitors import Transformer, v_args


def partial_equivalence(full: Union[Tree, Token], partial: Optional[Union[Tree, Token]]):
    """
    Compute if a tree is equivalent to a partial tree. A partial tree is a tree
    where some subtrees have been replaced by None. Essentially, the trees are
    compared until a None value is encountered. None has the following equivalences:
    [...] == None
    Tree(...) == None
    Token(...) == None
    :param full:
    :param partial:
    :return:
    """

    if partial is None:
        return True

    if type(full) is Token:
        return type(partial) == Token and full == partial

    if full.data != partial.data:
        return False

    if partial.children is None:
        return True

    if len(full.children) != len(partial.children):
        return False

    for c_full, c_partial in zip(full.children, partial.children):
        if not partial_equivalence(c_full, c_partial):
            return False
    return True


def get_grammar(sql_grammar: str, lark_grammar: str):
    """
    Parse sql grammar using a parser for .lark files. Access to the SQL grammar
    can be used for instance to automatically find some optionals (see OptionalFinder
    and OptionalReducer in reductions.py).
    :param sql_grammar_file: path to the grammar for sql
    :param lark_grammar_file: path to the grammar for .lark files
    :return: a parse tree obtained by parsing sql_grammar_file using the lark_grammar_file
    """
    parser = Lark(lark_grammar)
    return parser.parse(sql_grammar)


def split_into_stmts(text: str):
    """
    Split a string of multiple sql statements into a list of single statements.
    :param text: string of sql statements
    :return: Iterator of strings of single sql statements
    """
    buf = ''
    in_str = False
    for c in text:
        buf += c
        if not in_str:
            if c == "'":
                in_str = True
            elif c == ';':
                yield buf
                buf = ''
        else:
            if c == "'":
                in_str = False
    buf = buf.strip(' \n\t')
    if len(buf) > 0:
        if buf[-1] != ';':
            buf += ';'
        yield buf


class PrettyPrinter(Transformer):
    """
    Computes the string representation of an SQL parse-tree
    """
    def __default_token__(self, token):
        return token.value

    @v_args(tree=True)
    def sql_stmt(self, tree):
        s = ""
        for c in tree.children:
            s += (c + ' ')
        s = s.rstrip()
        return s.lstrip() + ';\n'

    def sql_stmt_list(self, children):
        return self._list(children, '').rstrip('\n')

    def column_list(self, children):
        return self._list(children)

    def values_list(self, children):
        return self._list(children)

    def value_tuple(self, children):
        return '(' + self._list(children) + ')'

    def subquery_or_expr_list(self, children):
        return self._list(children)

    def column_def_list(self, children):
        return self._list(children)

    def list_expr(self, children):
        return '(' + self._list(children) + ')'

    def name_list(self, children):
        return self._list(children)

    def assign_list(self, children):
        return self._list(children)

    def _list(self, children, sep=', '):
        """
        Return string representation of common list like patterns (e.g. list of
        columns in an INSERT statement).
        :param children: list of list items
        :param sep: character(s) to insert between list items
        :return: str
        """
        s = ""
        for c in children:
            s += (c + sep)
        return s.rstrip(sep)

    def __default__(self, data, children, meta):
        s = ""
        for c in children:
            # no space before ";", ")", "," and "."
            if c in (";", ")", ",", "."):
                s = s.rstrip()
            s += (c + " ")
            # no space after "(", "::" and "."
            if c in ("(", "::", "."):
                s = s.rstrip()
        return s.rstrip()