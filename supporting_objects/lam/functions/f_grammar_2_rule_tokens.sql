CREATE OR REPLACE FUNCTION f_grammar_2_rule_tokens
(   p_grammar   	IN CLOB
   ,p_source_key    IN VARCHAR2
)
RETURN parser_alt_token_col
AS 
/*  convert a EBNF grammar to rule tokens, aka first-sets 

Example input grammar:
	<column_expression> ::= <term> { ( "+" | "-" ) <term> } ;
	<term>              ::= <factor> { ( "*" | "/" ) <factor> }
		;
	<factor>            ::= identifier 
						  | literal 
						  | function_call 
						  | "(" <column_expression> ")"	;
						  
NOTA BENE: rule alt_no is not to be used if higher alt_no exist(s) ! 						  
*/ 
	vtab_return 		parser_alt_token_col := parser_alt_token_col(); 
	v_source_normed 	parser_grammar_rule_simple.source%TYPE;
	vtab_simple_rules 	parser_grammar_rule_simple_col;
BEGIN 
	v_source_normed := trim( upper ( p_source_key ) );
	vtab_simple_rules := f_grammar_2_simple_rules
		( p_grammar =>	p_grammar 
		 ,p_source_key  =>  v_source_normed
		);
	-- 
	vtab_return := f_simp_rules_to_alt_tokens 
		(  p_tab_simple_rules =>	vtab_simple_rules 
		  ,p_source_key	=>			v_source_normed
		);
	-- 
	RETURN vtab_return; 
END;
/	