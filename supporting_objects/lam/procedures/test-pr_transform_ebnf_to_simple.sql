BEGIN
    -- EXECUTE IMMEDIATE 'TRUNCATE TABLE simple_grammar_rules';
    
    -- Notice the structural spaces around brackets to act as explicit delimiters
    pr_transform_ebnf_to_simple	(
--		p_lhs=>		'<select_statement>'
--		,p_rhs=>        '[ <with_clause> ] <query_block> { <set_operator> <query_block> } * [ <order_by_clause> ] [ <for_update_clause> ]'    
		p_lhs=> '<select_statement_no_fancy>'
       ,p_rhs=>   '  <with_clause>   <query_block>   <set_operator> <query_block>       <order_by_clause>     <for_update_clause>  ' 
       ,p_source=>   'manual_test'    );
    
    COMMIT;
END;
/