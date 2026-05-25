 CREATE OR REPLACE PROCEDURE pr_resolve_ebnf_rules 
 ( p_source		VARCHAR2 
 )
 AS
 -- Expand the EBNF rules in the table to simple rules which are more straight-forward for code generator 
	v_source_normed 	parser_grammar_rule_ebnf.source%TYPE;
 BEGIN 
	v_source_normed := trim( upper ( p_source ) );
	FOR r_rule IN ( 
		SELECT lhs,		rhs 
		FROM parser_grammar_rule_ebnf 
		where source = v_source_normed 
		ORDER BY 1, 2 
	) LOOP 
		pr_transform_ebnf_to_simple	(
			p_lhs=> 	r_rule.lhs 
		   ,p_rhs=>   	r_rule.rhs 
		   ,p_source=>  v_source_normed 
		   );
	END LOOP;
 END;
 /