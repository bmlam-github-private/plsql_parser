begin dbms_session.reset_package;
end;
/
set serveroutput on 
DECLARE   
   v_lang_tokens lexer_token_col;
   v_success BOOLEAN; 
BEGIN 
    SELECT  
		lexer_token_rec(tok_seq=> tok_seq
		 ,tok_type=> tok_type
		 ,tok_char_cnt=> tok_char_cnt
		 ,tok_text_normal=> tok_text_normal
		 ,tok_text_long=> tok_text_long
		 ,tok_value=> tok_value 
		 )
	BULK COLLECT INTO    v_lang_tokens
    FROM TABLE ( 
        plsql_lexer.code_to_lang_tokens ( 
       '       v_msg VARCHAR2(100) := q''!It''s a "Q" string delimiter block!''; 
     '
		,pi_grammar_source => upper( 'variable_declaration' )
		,pi_remove_comment => 1 
     )
 );
   mini_parser.parse_main ( p_token_stream=> v_lang_tokens, po_success=> v_success );
   dbms_output.put_line ( 'v_succes:' ||case v_success when true then 'true' when false then 'false' else '?' end );
END;
/

SELECT *
    FROM TABLE ( 
        plsql_lexer.code_to_lang_tokens ( 
       '       v_msg VARCHAR2(100) := q''!It''s a "Q" string delimiter block!''; 
     '
		,pi_grammar_source => upper( 'variable_declaration' )
		,pi_remove_comment => 1 
     ) )
;