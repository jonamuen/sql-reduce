CC = java -jar /usr/local/lib/antlr-4.8-complete.jar
CFLAGS = -o parser -Dlanguage=Python3 -visitor
GRUN = java org.antlr.v4.gui.TestRig

sqlparser: SQL.g4
	export CLASSPATH=".:/usr/local/lib/antlr-4.8-complete.jar:$CLASSPATH"
	$(CC) $(CFLAGS) SQL.g4
	echo "" > parser/__init__.py
