set serveroutput on 

SELECT *
--tok_seq, tok_type, tok_char_cnt, tok_text_normal , tok_text_long 
FROM TABLE(plsql_lexer.code_to_lang_tokens( pi_code=>
    'DECLARE        v_msg VARCHAR2(100) := q''!It''s a "Q" string delimiter block!'';
       v_num NUMBER := 123.45;  -- inline comment
     BEGIN      null;     END;'
     , pi_grammar_source=> 'PLSQL_EXCLUDING_SQL'
     , pi_remove_comment => 1 
))
ORDER BY tok_seq
;

--SELECT *
----tok_seq, tok_type, tok_char_cnt, tok_text_normal , tok_text_long 
--FROM TABLE(plsql_lexer.code_to_basic_tokens(
--    'DECLARE
--       v_msg VARCHAR2(100) := q''!It''s a "Q" string delimiter block!''; -- inline comment
--       v_num NUMBER := 123.45;
--     BEGIN
--       /* Multi line block 
--          evaluation check */
--       IF v_num <> 0 THEN
--          DBMS_OUTPUT.PUT_LINE(v_msg);
--       END IF;
--       SELECT COUNT(*) 
--       INTO v_dummy 
--       FROM funny_schema.dba_oops@db_link_a.world
--     END;'
--     ||'/*'||rpad( '.', 5000, '.' )||'*/'
--))
--ORDER BY tok_seq
--;