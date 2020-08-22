# SQL-Reduce

A Reduction Tool for SQL

Author: Jonas Müntener

## Purpose

SQL-Reduce can reduce the length of an SQL query while maintaining some property of the query.
For instance, one might wish to reduce a long, bug-triggering query to a smaller query that triggers the same bug, which makes it easier to identify and fix the bug.

Suppose a hypothetical database management system crashes if the value `1` is returned by a `SELECT` statement.
The original query which led to the crash might look like this:

    CREATE TABLE t0 (c0 INT, c1 INT);
    INSERT INTO t0 VALUES (2, 3);
    SELECT 1, c0, c1 FROM t0;

SQL-Reduce would *reduce* this query to `SELECT 1;` which triggers the same (hypothetical) bug.

## Installation

(SQL-Reduce was developed with python 3.8.2. Other versions might work, but were not tested.)

1. Clone the repository from [github](https://github.com/jonamuen/sql-reduce/).

2. Install dependencies with `pip install -r requirements.txt`.
Currently, [lark](https://github.com/lark-parser/lark) and [duckdb](https://www.duckdb.org/) are the only dependencies.

3. (optional) If you wish to run `sql-reduce.py` from any directory, install the `SQLReduce` module with
`pip install .`

## How does it work?

SQL-Reduce applies *reduction passes* which remove a part of the input query, generating a *reduction candidate*.
It then runs a user-supplied script to check if the reduction candidate has the desired property (e.g. if it crashes the database when executed).
If this is the case, the reduction candidate will be accepted and the entire process will start over.
Otherwise, the reduction candidate will be discarded and a different reduction pass will be applied.
Once all reduction passes have been exhaustively applied, SQL-Reduce outputs the reduced query and terminates.

## Usage
- Example:
  - `testcase.sql`: a SQL test case that should be reduced
  - `test.py`: reads a file with the same name as the test case (`testcase.sql` in this example) from its working directory and returns `0` if the file triggers the desired bug, `1` otherwise
  - Reduce with: `./sql-reduce.py path/to/test.py path/to/testcase.sql`
  - The current best reduction will be continuously written to `reduced.sql`. Check this file if you suspect that the reducer is stuck.
  - Once the reducer has terminated, it additionally writes the best reduction to `stdout`.
- If more verbose progress reporting is desired, pass the `-v` flag to `sql-reduce.py`.
- Type `./sql-reduce.py --help` for more help

## Performance
In my experience, slow performance was mostly due to verification.
Verification with an test script that connects to a database took about 0.5 - 2s for each reduction candidate, whereas generating a reduction candidate took ~1ms.

## Test suite

SQL-Reduce comes with a test suite that tests the parser and all reduction passes.
Some of the tests rely on the files in the `tests` directory.
Run it with `python3 -m unittest tests.py`

## Adding reduction passes

SQL-Reduce is extensible, that is, it's easy to add your own reduction passes.
The easiest way to write one is to inherit from `ReductionPassBottomUp` from `SQLReduce.reductions`.
Reduction passes are implemented as parse tree transformations based on the `Transformer` class from the Lark parsing library.
Your reduction pass can define methods whose name corresponds to that of a grammar rule.
Such methods will be called when the tree transformer encounters a node corresponding to the grammar rule in the tree.

To work with the methods provided by `ReductionPassBottomUp`, your reduction pass must increment the `index` field after encountering a reducible pattern and only apply the reduction if the `index` (before incrementing) is in the `remove_list` field.
These fields are used by the `all_transforms` method to generate all reduction candidates for the reduction pass.

To include your reduction pass, add an instance of it to the `reduction_passes` list in `sql-reduce.py`.
Note that the order of reduction passes is critical for performance.
In particular, it is important that reduction passes that quickly achieve large reductions (e.g `StatementRemover`) are first in the list and thus executed before the other reduction passes.

Take a look at the `ConstraintRemover` pass in `SQLReduce/reductions.py` for a relatively straight-forward example.

## Reporting issues, ideas, etc.

Feel free to open issues on GitHub if you have ideas for improvement or encounter issues.

## Attributions

The file `SQLReduce/lark.lark` was copied from the [lark repository](https://github.com/lark-parser/lark).
It is licensed under an MIT license (license terms included in file).
