CREATE OR REPLACE FUNCTION f_grammar_2_rule_tokens
(   p_grammar   IN CLOB
   ,p_source    IN VARCHAR2
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
	v_source_normed := trim( upper ( p_source ) );
	vtab_simple_rules := f_grammar_2_simple_rules
		( p_grammar =>	p_grammar 
		 ,p_source  =>  v_source_normed
		);
	-- 
	FOR r_simple_rule IN  	( 
		SELECT * 
		FROM TABLE( vtab_simple_rules ) 
	) LOOP 
		FOR r_tok IN (
			SELECT t.column_value	AS symbol 
				,rownum 			AS seq 
			FROM TABLE ( fn_split_by_whitespaces ( r_simple_rule.rhs ) ) t
		) LOOP 
			vtab_return.extend ;
			vtab_return( vtab_return.last ) := parser_alt_token_rec 
				( lhs => r_simple_rule.lhs 
				 ,alt_no => r_simple_rule.subrule_no 
				 ,position => r_tok.seq 
				 ,symbol => r_tok.symbol 
				 ,source => p_source 
				 ); 
		END LOOP; -- over sequenced tokens of RHS 
	END LOOP; -- over simple rules 
	-- 
	RETURN vtab_return; 
END;
/	