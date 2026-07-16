--set serveroutput on 
DECLARE   
   v_tab_tokens parser_token_col;
   v_success BOOLEAN; 
BEGIN 
    SELECT  
    parser_token_rec(tok_seq=> tok_seq
 ,tok_type=> tok_type
 ,tok_char_cnt=> tok_char_cnt
 ,tok_text_normal=> tok_text_normal
 ,tok_text_long=> tok_text_long
 )
BULK COLLECT INTO    v_tab_tokens
    FROM TABLE ( 
        plsql_lexer.tokenize_code ( 
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
     )
 );
   pkg_dynamic_parser.parse_main ( v_tab_tokens, v_success );
   dbms_output.put_line ( 'v_succes:' ||case v_success when true then 'true' when false then 'false' else '?' end );
END;
/