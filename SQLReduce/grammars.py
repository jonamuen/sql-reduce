from .locator import lark_path, sql_path, unrecognized_path


def _expand_grammar(filename):
    """
    Replace newlines preceded by a backslash with whitespace.
    This allows linebreaks inside grammar definitions.
    :param filename: path to file
    :return: A string containing the expanded grammar.
    """
    grammar = ""
    with open(filename) as in_file:
        for line in in_file:
            if len(line) >= 2 and line[-2] == '\\':
                grammar += (line[:-2] + ' ')
            else:
                grammar += line
    return grammar+'\n'


lark = _expand_grammar(lark_path)
sql = _expand_grammar(sql_path)
unrecognized = _expand_grammar(unrecognized_path)

del lark_path
del sql_path
del unrecognized_path
