class Ast:
    pass

class RuleNode(Ast):
    def __init__(self, children):
        self.children = children
        self.rule = None

    def __str__(self):
        s = ''
        for c in self.children:
            s = s + ' ' + str(c)
        return s

    def __repr__(self):
        return f"RuleNode({str(list(map(repr, self.children)))})"


class TerminalNode(Ast):
    def __init__(self, text: str):
        self.text = text

    def __str__(self):
        return self.text

    def __repr__(self):
        return f"TerminalNode({self.text})"
