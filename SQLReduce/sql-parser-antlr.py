import sys
from antlr4 import *

from parser.SQLLexer import SQLLexer
from parser.SQLParser import SQLParser
from parser.SQLVisitor import SQLVisitor

from astnodebase import RuleNode, SqlStmtListNode, SqlStmtNode, TerminalNode

class PrettyPrinter(SQLVisitor):
    def visitTerminal(self, node):
        s = str(node)
        if s == "<EOF>":
            return ""
        return s

    def aggregateResult(self, aggregate, nextResult):
        if aggregate is None:
            return nextResult
        return aggregate + " " + nextResult

class StatementRemover(SQLVisitor):
    # def visitSql_statement_list(self, ctx:SQLParser.Sql_statement_listContext):
    #     print(f"sql stmt list: {ctx}")
    #     return ctx
    def __init__(self, remove_indices=[]):
        self.removeIndices = remove_indices
        self.stmt_count = 0

    def visitSql_stmt(self, ctx:SQLParser.Sql_stmtContext):
        self.stmt_count += 1
        if self.stmt_count in self.removeIndices:
            print(f"Removing: {ctx}")
            return ctx
        else:
            return ctx

    def visitChildren(self, node):
        r = super().visitChildren(node)
        print(f"visit children {r}")
        return r

    def visit(self, tree: SQLParser.Sql_statement_listContext):
        print(f"visit called {tree}, num children: {tree.getChildCount()}")
        return self.visitChildren(tree)

    def visitTerminal(self, node):
        return node

    def aggregateResult(self, aggregate, nextResult):
        pass

class EmptyTransform(SQLVisitor):
    def visit(self, tree):
        return ParserRuleContext()


class AstConstructor(SQLVisitor):
    def aggregateResult(self, aggregate, nextResult):
        print(f'aggregating: {str(aggregate)}, {str(nextResult)}')
        if aggregate is None:
            if nextResult is not None:
                return RuleNode([nextResult])
            else:
                return RuleNode([])
        else:
            aggregate.children.append(nextResult)
            return aggregate

    def visitSql_statement_list(self, ctx:SQLParser.Sql_statement_listContext):
        return SqlStmtListNode(self.visitChildren(ctx))

    def visitSql_stmt(self, ctx:SQLParser.Sql_stmtContext):
        return SqlStmtNode(self.visitChildren(ctx))

    def visitTerminal(self, node):
        print(f'Visiting terminal: {str(node)}')
        return TerminalNode(str(node))

def main(argv):
    input_stream = StdinStream()
    lexer = SQLLexer(input_stream)
    stream = CommonTokenStream(lexer)
    parser = SQLParser(stream)
    tree = parser.sql_statement_list()
    print(type(tree))
    p = PrettyPrinter()
    print(p.visit(tree))
    ast_constructor = AstConstructor()
    ast = ast_constructor.visit(tree)
    print(f'AST: {repr(ast)}')


if __name__ == '__main__':
    main(sys.argv)