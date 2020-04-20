from lark import Tree, Token, Lark
from typing import Union, Optional


def expand_grammar(filename: str):
    """
    Replace newlines preceded by a backslash with whitespace.
    This allows linebreaks inside grammar definitions.
    :param filename: path to file
    :return: The filename of the expanded grammar file.
    """
    name, extension = filename.split('.')
    exp_filename = name + 'expanded.' + extension
    with open(filename) as in_file:
        with open(exp_filename, 'w') as out_file:
            for line in in_file:
                if len(line) >= 2 and line[-2] == '\\':
                    out_file.write(line[:-2] + ' ')
                else:
                    out_file.write(line)
            out_file.write('\n')
    return exp_filename


def partial_equivalence(full: Union[Tree, Token], partial: Optional[Union[Tree, Token]]):
    # TODO: define equivalence formally and prove correctness of this function
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


def get_grammar(sql_grammar_file: str, lark_grammar_file: str):
    """
    Parse sql grammar using a parser for .lark files. Access to the SQL grammar
    can be used for instance to automatically find some optionals (see OptionalFinder
    and OptionalReducer in transformation.py).
    :param sql_grammar_file: path to the grammar for sql
    :param lark_grammar_file: path to the grammar for .lark files
    :return: a parse tree obtained by parsing sql_grammar_file using the lark_grammar_file
    """
    with open(lark_grammar_file, 'r') as f:
        parser = Lark(f)
        with open(expand_grammar(sql_grammar_file)) as grammar_file:
            return parser.parse(grammar_file.read())
