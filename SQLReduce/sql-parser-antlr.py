import sys
from antlr4 import *
from SQLiteLexer import SQLiteLexer
from SQLiteParser import SQLiteParser
from SQLiteParser import ParserRuleContext
from SQLiteListener import SQLiteListener
from SQLiteVisitor import SQLiteVisitor


class KeyPrinter(SQLiteListener):
    def enterParse(self, ctx:SQLiteParser.ParseContext):
        i = ctx.getRuleIndex()
        for k in SQLiteParser.__dict__:
            if SQLiteParser.__dict__[k] == i:
                print(f"enterParse: {k}")
    def exitEveryRule(self, ctx:ParserRuleContext):
        i = ctx.getRuleIndex()
        for k in SQLiteParser.__dict__:
            if SQLiteParser.__dict__[k] == i:
                print(k)

class PrettyPrinter(SQLiteVisitor):
    def visitTerminal(self, node):
        s = str(node)
        if s == "<EOF>":
            return ""
        return s

    def aggregateResult(self, aggregate, nextResult):
        if aggregate is None:
            return nextResult
        return aggregate + " " + nextResult

class EmptyTransform(SQLiteVisitor):
    def visit(self, tree):
        return ParserRuleContext()


def main(argv):
    input_stream = StdinStream()
    lexer = SQLiteLexer(input_stream)
    stream = CommonTokenStream(lexer)
    parser = SQLiteParser(stream)
    tree = parser.parse()
    printer = KeyPrinter()
    walker = ParseTreeWalker()
    walker.walk(printer, tree)
    p = PrettyPrinter()
    e = EmptyTransform().visit(tree)
    print(e)
    print(p.visit(tree))
    print(p.visit(e))


if __name__ == '__main__':
    main(sys.argv)