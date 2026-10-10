CREATE OR REPLACE FUNCTION f_grammar_2_simple_rules 
( p_grammar  	CLOB 
 ,p_source		VARCHAR2 
) RETURN parser_grammar_rule_simple_col
AS 
/*  convert a EBNF grammar to simple BNF rules 

Example input grammar:
	<column_expression> ::= <term> { ( "+" | "-" ) <term> } ;
	<term>              ::= <factor> { ( "*" | "/" ) <factor> }
		;
	<factor>            ::= identifier 
						  | literal 
						  | function_call 
						  | "(" <column_expression> ")"	;
*/ 
	vtab_return 		parser_grammar_rule_simple_col := parser_grammar_rule_simple_col();
	vtab_ret_tmp 		parser_grammar_rule_simple_col ;		-- result from one EBFN rule before adding to return value 
	--
	vtab_ebnf_rules 	parser_rule_from_grammar_col;
	v_ebnf_rule 		parser_rule_from_grammar_rec;
	v_source_normed 	parser_grammar_rule_simple.source%TYPE;
BEGIN 
	v_source_normed := trim( upper ( p_source ) );
	vtab_ebnf_rules := f_extract_rules_from_grammar ( p_grammar=> p_grammar );
	-- 
	FOR i IN 1 .. vtab_ebnf_rules.count 
	LOOP 
		v_ebnf_rule := vtab_ebnf_rules( i );
		vtab_ret_tmp := parser_rule_util. fn_1_ebnf_to_simple
					( p_lhs=> v_ebnf_rule.lhs 
					, p_rhs=> v_ebnf_rule.rhs 
					, p_source=> v_source_normed 
					);
		-- add result to return value 
		vtab_return := vtab_return MULTISET UNION ALL vtab_ret_tmp;
	END LOOP;
	-- 
	RETURN vtab_return;
END;
/

