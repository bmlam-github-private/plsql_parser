CREATE OR REPLACE FUNCTION f_simp_rules_to_alt_tokens 
( p_tab_simple_rules 	IN 	parser_grammar_rule_simple_col
, p_source_key			IN 	VARCHAR2 
)
RETURN parser_alt_token_col
AS 
/* a grammar has been converted to simple rules and this function shall return 
the collection of rule alternative tokens 
*/
	vtab_return 		parser_alt_token_col := parser_alt_token_col(); 
BEGIN 
	FOR r_simple_rule IN  	( 
		SELECT * 
		FROM TABLE( p_tab_simple_rules ) 
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
				 ,source => p_source_key 
				 ); 
		END LOOP; -- over sequenced tokens of RHS 
	END LOOP; -- over simple rules 
	RETURN vtab_return; 
END;
/

	