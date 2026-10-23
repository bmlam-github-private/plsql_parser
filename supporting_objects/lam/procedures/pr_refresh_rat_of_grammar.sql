CREATE OR REPLACE PROCEDURE pr_refresh_rat_of_grammar
(   p_grammar  		IN CLOB
   ,p_source_key    IN VARCHAR2
) AS 
/* Re-create grammar rules and rule tokens from a grammar text p_grammar. The old data of the grammar with the same p_source_key will be deleted beforehand but as one transaction with the newly inserted data
*/
	v_simple_rule_col 	parser_grammar_rule_simple_col;
	v_source_key		parser_alt_token.source%TYPE;
BEGIN 
	-- extract simple rules and persist 
	v_simple_rule_col := f_grammar_2_simple_rules
			( p_grammar 	=> p_grammar 
			 ,p_source_key 	=> v_source_key
			);
	IF v_simple_rule_col.count = 0 
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
	FROM TABLE ( v_simple_rule_col ) t 
	;
	-- Next: extract tokens and persist 
	-- 
	-- 
	COMMIT; 
	-- 
END;
/	