from verifier import AbstractVerifier, SQLiteReturnSetVerifier
from transformation import AbstractTransformationsIterator, PrettyPrinter, StatementRemover
from typing import List
from sql_parser import SQLParser


class Reducer:
    def __init__(self, parser: SQLParser, verifier: AbstractVerifier,
                 transforms: List[AbstractTransformationsIterator]):
        self.transforms = transforms
        self.pprinter = PrettyPrinter()
        self.parser = parser
        self.verifier = verifier

    def reduce(self, stmt: str):
        """
        reduce takes as input a SQL statement and executes the provided
        transformations until a fixed point is reached. Fixed point:
        \forall t \in self.transforms \forall c \in t.all_transforms not verify(stmt, c)
        :param stmt:
        :return:
        """
        fixed_point = False
        tree = self.parser.parse(stmt)
        best = tree.__deepcopy__(None)
        itr_counter = 0
        while not fixed_point:
            fixed_point = True
            for t in self.transforms:
                for candidate in t.all_transforms(best):
                    itr_counter += 1
                    stmts_old = list(map(self.pprinter.transform, tree.children))
                    stmts_cand = list(map(self.pprinter.transform, candidate.children))
                    stmt_old = self.pprinter.transform(best)
                    stmt_cand = self.pprinter.transform(candidate)
                    if len(stmt_cand) < len(stmt_old) and self.verifier.verify(stmts_old, stmts_cand):
                        fixed_point = False
                        best = candidate
                        break
        print(f"Iterations: {itr_counter}")
        return best


if __name__ == '__main__':
    transforms = [StatementRemover()]

    parser = SQLParser("sql.lark", start="sql_stmt_list", debug=True, parser='lalr')
    vrf = SQLiteReturnSetVerifier('test/test_reduce.sqlite')
    r = Reducer(parser, vrf, transforms)
    reduced = r.reduce("CREATE TABLE t0 (id INT); INSERT INTO t0 VALUES (0);"
                       "INSERT INTO t0 VALUES (1); SELECT * FROM t0 WHERE id = 0;")
    print(r.pprinter.transform(reduced))
