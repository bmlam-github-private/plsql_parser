set serveroutput on size 1000000
;
DECLARE
    x parser_alt_token_col;
    gram_clob   CLOB;
BEGIN 
    parser_rule_util. pr_set_global ( p_key=> 'max_nesting', p_value => 199 );
    parser_rule_util. pr_set_global ( p_key=> 'nesting_dump_loop', p_value => 9 );
    --
    SELECT "CONTENT"
    INTO gram_clob 
    FROM temp_clob
    where upper("REMARKS") = 'PLSQL_EXCLUDING_SQL'
    ;
    x := 
    parser_rule_util. fn_grammar_clob_to_rule_tokens
    (  p_clob => gram_clob
        , p_source => 'PLSQL_EXCLUDING_SQL'  
        , p_persist => TRUE 
        , p_max_nesting => 999 
        ); 
END;
/
