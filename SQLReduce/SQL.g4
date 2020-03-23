grammar SQL;

sql_statement_list
    : ';'* (sql_stmt (';')+)+ EOF
;

sql_stmt
    : select_stmt
    | create_table_stmt
    | unexpected_stmt
;

select_stmt
    : K_SELECT name_or_value (',' name_or_value)* K_FROM NAME
;

create_table_stmt
    : K_CREATE K_TABLE NAME '(' column_def_list ')'
;

unexpected_stmt
    : error {print("WARNING: unknown statement" + $error.text)}
;

error
    : .*?  //*? match non-greedily
;

column_def_list
    : NAME sql_type? (',' NAME sql_type?)*
;

// TODO: check what names are allowed and how values are specified
name_or_value
    : NAME
    | VALUE
;

sql_type
    : NAME ('('VALUE ')')?
;


keyword
    : K_SELECT
    | K_UPDATE
    | K_CREATE
    | K_TABLE
;

K_SELECT : 'SELECT';
K_UPDATE : 'UPDATE';
K_CREATE : 'CREATE';
K_TABLE : 'TABLE';
K_FROM : 'FROM';

EQUAL : '=';

NAME
    : [a-zA-Z_] [a-zA-Z0-9]*
;

VALUE
    : '\'' (~['])* '\''                         // string literal
    | ('+'|'-')? [0-9]+ ('.'[0-9]*)?              // number literal
;

WS
    : [ \t\r\n] -> channel(HIDDEN)
;