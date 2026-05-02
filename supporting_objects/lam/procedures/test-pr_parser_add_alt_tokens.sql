declare 
    v_tokens parser_rule_token_col;
    c_rhs VARCHAR2( 1000 ) := 
        '"DECLARE" <declaration_section> "BEGIN" <executable_section> ["EXCEPTION" <exception_section>] "END" [<identifier>] ";"
          | "BEGIN" <executable_section> ["EXCEPTION" <exception_section>] "END" [<identifier>] ";"' 
          ;
begin 
    v_tokens := parser_grammar_gen.tokenize_rhs_refined ( c_rhs );
    pr_parser_add_alt_tokens ( p_lhs=> 'BLOCK', p_tokens  => v_tokens, p_purge_old => true );
end;
/
