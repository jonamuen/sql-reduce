# SQL Reduce

A Reduction Tool for SQL

Bachelor's thesis of Jonas Müntener

## Installation

(SQLReduce was developed with python 3.8.2. Other versions might work, but weren't tested.)

1. Clone or download the repository

2. `cd sql-reduce/SQLReduce`

3. Install dependencies with `pip install -r requirements.txt`.
Currently, lark (a parser generator) is the only dependency.

4. Execute on a testcase with: `./main.py path_to_verifier path_to_sql`
The verifier should read a file `test.sql` and return `0` if it still triggers the desired bug, `1` otherwise.

## Adding reduction passes

SQLReduce is extensible, in that reduction passes can be added easily. To write your own reduction pass, you must implement the `AbstractTransformationsIterator` interface from `transformation.py`. This interface requires you to implement the function `all_transforms(tree: Tree) -> Iterator[Tree]`.

An implementation of `all_transforms` should yield all reductions that your reduction pass is able to provide. For instance, the already implemented `StatementRemover` yields different combinations of removing one or more SQL statements from the parse tree. Note that your implementation should yield a COPY of the provided tree. The `Tree` class provides a function `__deepcopy__(None)`* to facilitate this.

Alternatively, your reduction pass can additionally inherit from `lark.Transformer`. This allows you to implement functions for specific grammar rules. Take a look at the [documentation for transformers](https://lark-parser.readthedocs.io/en/latest/visitors/).

To include your reduction pass, add an instance of it to the `reduction_passes` list in `main.py`. Note that the order of reduction passes is critical for performance. In particular, it is important that coarse grained reduction passes that quickly achieve large reductions (e.g `StatementRemover`) are first in the list and thus executed before the other reduction passes.

If you think your reduction pass could benefit others, feel free to open a merge request.

* The argument to `__deepcopy__` doesn't seem to do anything, but it is required. Setting it to `None` has worked well for me.

## Reporting issues, ideas, etc.

Open an issue in gitlab or write me an email: jonamuen@student.ethz.ch
