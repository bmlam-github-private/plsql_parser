CREATE OR REPLACE PACKAGE plsql_lexer AS
    FUNCTION code_to_basic_tokens
		(pi_code IN CLOB
		) 
	RETURN parser_token_col PIPELINED
	;
	-- function to reverse the process
	FUNCTION basic_tokens_to_clob
		(pi_tokens IN parser_token_col
		) RETURN CLOB
		;
	--
    FUNCTION code_to_lang_tokens
		(pi_code IN CLOB
		,pi_grammar_source 		IN VARCHAR2
		,pi_remove_comment		IN 	NUMBER DEFAULT 0 
		) 
	RETURN parser_token_col
	;
END plsql_lexer;
/

