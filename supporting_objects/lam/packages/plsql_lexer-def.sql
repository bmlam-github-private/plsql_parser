CREATE OR REPLACE PACKAGE plsql_lexer AS
    FUNCTION tokenize_code(p_code IN CLOB) RETURN parser_token_col PIPELINED;
END plsql_lexer;
/

