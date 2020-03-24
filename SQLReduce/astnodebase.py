class AstNodeBase:
    pass


class RuleNode(AstNodeBase):
    def __init__(self, initializer):
        if type(initializer) is RuleNode:
            self.children = initializer.children
        elif type(initializer) is list:
            self.children = initializer
        else:
            raise TypeError(f"Unsupported type for initializer: {type(initializer)}")

    def __str__(self):
        s = ''
        for c in self.children:
            s = s + ' ' + str(c)
        return s

    def __repr__(self):
        return f"RuleNode({str(list(map(repr, self.children)))})"


class SqlStmtListNode(RuleNode):
    def __repr__(self):
        return f"SqlStmtListNode({str(list(map(repr, self.children)))})"


class SqlStmtNode(RuleNode):
    def __repr__(self):
        return f"SqlStmtNode({list(map(repr, self.children))})"


class TerminalNode(AstNodeBase):
    def __init__(self, text: str):
        self.text = text

    def __str__(self):
        return self.text

    def __repr__(self):
        return f"TerminalNode({self.text})"
