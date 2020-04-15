from lark import Token, Transformer, Tree
from copy import deepcopy
from typing import Union, Tuple


class NamedTree(Tree):
    """
    Allow indexing a tree to access children.
    """
    def __getitem__(self, item: Union[str, Tuple[str, int]]):
        """
        If item is a string, return a list of all children (DataToken or Tree)
        whose data attribute is equal to item.
        If item is a tuple of (a, i), return the i'th item whose data attribute
        is equal to a or None.
        :param item:
        :return:
        """
        if type(item) == tuple:
            item, index = item
            count = 0
            for c in self.children:
                if c.data == item:
                    if count == index:
                        return c
                    count += 1
            return None
        else:
            res = []
            for c in self.children:
                if c.data == item:
                    res.append(c)
            return res

    def __delitem__(self, key):
        if type(key) == tuple:
            item, index = key
            count = 0
            for i, c in enumerate(self.children):
                if c.data == item:
                    if count == index:
                        del self.children[i]
                        return
                    count += 1
        else:
            del_list = []
            for i, c in enumerate(self.children):
                if c.data == key:
                    del_list.append(i)
            for i in del_list[::-1]:
                del self.children[i]

    def __deepcopy__(self, memodict=None):
        return NamedTree(self.data, deepcopy(self.children), self.meta)

    def __repr__(self):
        return 'NamedTree(%s, %s)' % (self.data, self.children)


class NamedTreeConstructor(Transformer):
    """
    The transform method inherited from Transformer constructs a NamedTree
    from a Tree.
    """
    def __default__(self, data, children, meta):
        return NamedTree(data, children, meta)

    def __default_token__(self, token):
        t = DataToken(token.type, token.value)
        t.from_token(token)
        assert type(t) == DataToken
        return t


class DataToken(Token):
    """
    Same as Token, except it also exposes a data field like Tree.
    The data field holds the same value as type.
    """
    __slots__ = ['data']

    def __init__(self, type_, value, pos_in_stream=None, line=None, column=None, end_line=None, end_column=None, end_pos=None):
        super().__init__()
        self.type = type_
        self.pos_in_stream = pos_in_stream
        self.value = value
        self.line = line
        self.column = column
        self.end_line = end_line
        self.end_column = end_column
        self.end_pos = end_pos
        self.data = self.type

    def from_token(self, t: Token):
        self.type = t.type
        self.pos_in_stream = t.pos_in_stream
        self.value = t.value
        self.line = t.line
        self.column = t.column
        self.end_line = t.end_line
        self.end_column = t.end_column
        self.end_pos = t.end_pos

    def __repr__(self):
        return 'DataToken(%s, %r)' % (self.type, self.value)

    def __deepcopy__(self, memo):
        return DataToken(self.type, self.value, self.pos_in_stream, self.line, self.column)

    def __eq__(self, other):
        if isinstance(other, Token) and self.type != other.type:
            return False

        return str.__eq__(self, other)

    __hash__ = str.__hash__
