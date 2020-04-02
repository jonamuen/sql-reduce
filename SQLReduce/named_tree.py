from lark import Token, Transformer, Tree


class NamedTree(Tree):
    def __getitem__(self, item):
        res = []
        for c in self.children:
            if isinstance(c, NamedTree) and c.data == item:
                res.append(c)
            elif isinstance(c, Token) and c.type == item:
                res.append(c)
        return res


class NamedTreeConstructor(Transformer):
    def __default__(self, data, children, meta):
        return NamedTree(data, children, meta)