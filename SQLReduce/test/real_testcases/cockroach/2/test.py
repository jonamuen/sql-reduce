#!/usr/bin/env python3

import random
from subprocess import Popen, PIPE
import threading
import string

# generate a random DBMS name so that multiple test scripts can run in parallel
rand_db_name = ''.join(random.choices(string.ascii_uppercase, k=10))

sql_content = '''
-- ensure that the automatic error reporting is off
SET CLUSTER SETTING debug.panic_on_failed_assertions = true;
SET CLUSTER SETTING diagnostics.reporting.enabled = false;
SET CLUSTER SETTING diagnostics.reporting.send_crash_reports = false;
\set errexit false;
-- start with a fresh database
DROP DATABASE IF EXISTS ''' + rand_db_name + ''' CASCADE;
CREATE DATABASE ''' + rand_db_name + ''';
USE ''' + rand_db_name + ''';
'''

with open("test.sql", "r") as f:
	line = f.readline()
	while line:
		if line.startswith('USE') or line.startswith('DROP DATABASE') or line.startswith('CREATE DATABASE'):
			pass # ignore to ensure that we always start with a fresh database
		else:
			sql_content += line
		line = f.readline()

process = Popen(['cockroach sql --insecure'], stdout=PIPE, stderr=PIPE, stdin=PIPE, encoding='utf-8', shell=True)
stdout, stderr = process.communicate(input=sql_content + ';\nexit\n')

print(stderr)
if 'unordered spans' in stderr:
	exit(0)
else:
	exit(1)
