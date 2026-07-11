CREATE OR REPLACE PACKAGE plsql_lexer AS
    FUNCTION tokenize_code
		(p_code IN CLOB
		) 
	RETURN parser_token_col PIPELINED
	;
	-- New function to reverse the process
	FUNCTION tokens_to_clob
		(p_tokens IN parser_token_col
		) RETURN CLOB
		;
END plsql_lexer;
/

