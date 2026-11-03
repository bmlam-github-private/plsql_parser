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
	v_symb_len 			NUMBER;
BEGIN 
	FOR r_simple_rule IN  	( 
		SELECT * 
		FROM TABLE( p_tab_simple_rules ) 
	) LOOP 
		FOR r_tok IN (
			SELECT t.column_value	AS symbol 
				,row_number() 		AS seq 
			FROM TABLE ( fn_split_by_whitespaces ( r_simple_rule.rhs ) ) t
		) LOOP 
			BEGIN 
				vtab_return.extend ;
				vtab_return( vtab_return.last ) := parser_alt_token_rec 
					( lhs => r_simple_rule.lhs 
					 ,alt_no => r_simple_rule.subrule_no 
					 ,position => r_tok.seq 
					 ,symbol => r_tok.symbol 
					 ,source => p_source_key 
					 ); 
			EXCEPTION 
				WHEN OTHERS THEN
					v_symb_len := length( r_tok.symbol ); 
					pck_std_log.error ( a_err_code=> sqlcode, a_comp=> $$plsql_unit
						, a_text => 'rec lhs: '			||r_simple_rule.lhs 
									||'  subrule_no: '	||r_simple_rule.subrule_no
									||'  r_tok.seq: '	||r_tok.seq
									||'  r_tok.symbol: '||substr( r_tok.symbol, 1, 50)||CASE WHEN v_symb_len > 50 THEN '..' END
									||'  v_symb_len: '	||v_symb_len
									||'  p_source_key: '	||p_source_key
									);
					RAISE; 
			END;
		END LOOP; -- over sequenced tokens of RHS 
	END LOOP; -- over simple rules 
	RETURN vtab_return; 
END;
/

	