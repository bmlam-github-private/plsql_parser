CREATE OR REPLACE PROCEDURE pr_refresh_rat_of_grammar
(   p_grammar  		IN CLOB
   ,p_source_key    IN VARCHAR2
) AS 
/* Re-create grammar rules and rule alt_tokens from a grammar text p_grammar. The old data of the grammar with the same p_source_key will be deleted beforehand but as one transaction with the newly inserted data
*/
	v_source_key			parser_alt_token.source%TYPE;
	vtab_simple_rule 		parser_grammar_rule_simple_col;
	vtab_rule_alt_token 	parser_alt_token_col; 
BEGIN 
	v_source_key := upper( trim( p_source_key ) );
	-- extract simple rules and persist 
	vtab_simple_rule := f_grammar_2_simple_rules
			( p_grammar 	=> p_grammar 
			 ,p_source_key 	=> v_source_key
			);
dbms_output.put_line ( 'Ln'||$$plsql_line||' xx: '			|| vtab_simple_rule.count );
	IF vtab_simple_rule.count = 0 
	THEN 
		RAISE_APPLICATION_ERROR( -20001, 'Grammar did not yield any simple rules' );
	END IF;
	-- 
	DELETE FROM parser_grammar_rule_simple 
	WHERE source = v_source_key 
	;
	INSERT INTO parser_grammar_rule_simple 
	( 	lhs,	rhs,	lhs_root,	subrule_no, 		source 
	) 
	SELECT 
		lhs,	rhs,	lhs_root,	subrule_no, 	v_source_key
	FROM TABLE ( vtab_simple_rule ) t 
	;
	-- Next: extract tokens from simple rules and persist 
	-- 
	vtab_rule_alt_token :=  f_simp_rules_to_alt_tokens
		( p_tab_simple_rules => 	vtab_simple_rule 
		 ,p_source_key =>			v_source_key 
		 );
	-- 
	IF vtab_rule_alt_token.count = 0 
	THEN 
		RAISE_APPLICATION_ERROR( -20001, 'Simples rules (cnt:' ||vtab_simple_rule.count||') did not yield any tokens!' );
	END IF;
	--
	DELETE FROM parser_alt_token 
	WHERE source = v_source_key 
	;
	INSERT INTO parser_alt_token 
	(	lhs,		alt_no,			position,	symbol,			source 
	) 
	SELECT t.lhs,	t.alt_no,		t.position, t.symbol,		v_source_key 
	FROM TABLE ( vtab_rule_alt_token ) t
	;
	--
	COMMIT; 
	-- 
END;
/	