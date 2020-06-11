#!/usr/bin/env python3

from subprocess import Popen, PIPE
import sys

sql_content = ''

with open("test.sql", "r") as f:
	line = f.readline()
	while line:
		sql_content += line
		line = f.readline()

process = Popen(['duckdb_cli'], stdout=PIPE, stderr=PIPE, stdin=PIPE, encoding='utf-8', shell=True)
stdout, stderr = process.communicate(input=sql_content + ';\n.exit\n')

if 'ERROR: AddressSanitizer: SEGV' in stderr:
	exit(0)
else:
	exit(1)
