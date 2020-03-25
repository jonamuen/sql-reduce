from lark import Tree, Token
from typing import Union, Optional


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
