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
       'DECLARE
       v_msg VARCHAR2(100) := q''!It''s a "Q" string delimiter block!''; -- inline comment
       v_num NUMBER := 123.45;
     BEGIN
       /* Multi line block 
          evaluation check */
       IF v_num <> 0 THEN
          DBMS_OUTPUT.PUT_LINE(v_msg);
       END IF;
     END;'
     ||'/*'||rpad( '.', 500, '.' )||'*/'
		,pi_grammar_source => 'PLSQL_EXCLUDING_SQL'
		,pi_remove_comment => 1 
     )
 );
   pkg_dynamic_parser.parse_main ( p_token_stream=> v_lang_tokens, po_success=> v_success );
   dbms_output.put_line ( 'v_succes:' ||case v_success when true then 'true' when false then 'false' else '?' end );
END;
/