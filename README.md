# SQL Reduce

A Reduction Tool for SQL

Bachelor's thesis of Jonas Müntener

## Installation

(SQLReduce was developed with python 3.8.2. Other versions might work, but weren't tested.)

1. Clone or download the repository

2. `cd sql-reduce/SQLReduce`

3. Install dependencies with `pip install -r requirements.txt`.
Currently, lark (a parser generator) is the only dependency.

## Usage Example
- Given: 
  - `testcase.sql`: a SQL testcase that should be reduced
  - `test.py`: executes the file `test.sql` in same directory as `test.py` and returns `0` if the desired bug is triggered, `1` otherwise
  - Reduce with: `./main.py path/to/test.py path/to/testcase.sql`
  - The current best reduction will be continuously written to `best.sql`. Check this file if you suspect that the reducer might be stuck.
  - Once the reducer has terminated, it additionaly writes the best reduction to `stdout`.
  - Note: to pass reduction candidates from the reducer to the verifier, the file `test.sql` in the directory where the verifier resides will be (over-)written.
  - Note 2: interrupting `main` with `ctrl-c` doesn't work correctly if subprocesses (e.g. the external verifier) are running. If you want to stop `main`, just kill it from a separate terminal. The best reduction achieved so far should be in `best.sql`.

## Performance
In my experience, slow performance was mostly due to verfication. Verification with an external executable that connects to a database took about 0.5 - 2s for each reduction candidate, whereas generating a reduction candidate took ~1ms.

## Adding reduction passes

SQLReduce is extensible, in that reduction passes can be added easily. To write your own reduction pass, you must implement the `AbstractTransformationsIterator` interface from `transformation.py`. This interface requires you to implement the function `all_transforms(tree: Tree) -> Iterator[Tree]`.

An implementation of `all_transforms` should yield all reductions that your reduction pass is able to provide. For instance, the already implemented `StatementRemover` yields different combinations of removing one or more SQL statements from the parse tree. Note that your implementation should yield a COPY of the provided tree. The `Tree` class provides a function `__deepcopy__(memo)`* to facilitate this.

Alternatively, your reduction pass can additionally inherit from `lark.Transformer`. This allows you to implement functions for specific grammar rules. Take a look at the [documentation for transformers](https://lark-parser.readthedocs.io/en/latest/visitors/).

To include your reduction pass, add an instance of it to the `reduction_passes` list in `main.py`. Note that the order of reduction passes is critical for performance. In particular, it is important that coarse grained reduction passes that quickly achieve large reductions (e.g `StatementRemover`) are first in the list and thus executed before the other reduction passes.

If you think your reduction pass could benefit others, feel free to open a merge request.

* The argument to `__deepcopy__` is usually optional. For some reason, `Tree`'s implementation requires it, but it can be set to `None`.

## Reporting issues, ideas, etc.

Open an issue in gitlab or write me an email: jonamuen@student.ethz.ch
