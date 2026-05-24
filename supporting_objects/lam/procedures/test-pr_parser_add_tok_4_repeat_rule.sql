declare 
	v_lhs	VARCHAR2(30) := '<test_column_list>';
    v_tokens parser_rule_token_col;
    c_rhs VARCHAR2( 1000 ) := 
        '<test_column_expr> {, <test_column_expr>}' 
          ;
begin 
    v_tokens := parser_grammar_gen.tokenize_rhs_refined ( c_rhs );
    pr_parser_add_tok_4_repeat_rule ( p_lhs=> v_lhs, p_rhs_tokens  => v_tokens
        , p_source => 'plausi_test'
	);
end;
/
