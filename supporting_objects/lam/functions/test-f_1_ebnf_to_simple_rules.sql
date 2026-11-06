SELECT *
FROM TABLE ( f_1_ebnf_to_simple_rules( p_lhs => 'select_stmt', p_rhs => '[with_clause] query_block { set_operator  query_block} [ order_by_clause ] [for_update_clause]' )
	)
; 
