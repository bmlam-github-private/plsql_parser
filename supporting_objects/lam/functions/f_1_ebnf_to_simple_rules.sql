CREATE OR REPLACE FUNCTION f_1_ebnf_to_simple_rules 
( p_lhs		VARCHAR2 
 ,p_rhs		VARCHAR2 
 ,p_source  VARCHAR2 DEFAULT 'DUMMY'
) 
RETURN parser_grammar_rule_simple_col
AS     
	v_return 		parser_grammar_rule_simple_col :=  parser_grammar_rule_simple_col();
    v_work_rules 	parser_grammar_rule_simple_col :=  parser_grammar_rule_simple_col();
	v_rhs_tokens	sys.odciVarchar2List;
	v_rule_simple_type 	VARCHAR2(100);
BEGIN 
	v_rhs_tokens := parser_rule_util.dbx_tokenize_rhs ( p_rhs );
	v_return.extend;
	v_return(1) := parser_grammar_rule_simple_rec 
			( lhs		=> p_lhs 
 			 ,rhs		=> p_rhs 
 			 ,subrule_no=> 0
 			 ,lhs_root	=> p_rhs 
 			 ,source	=> p_source 
			) ;
	-- 
	--
	v_rule_simple_type :=  f_rule_is_simple ( p_rule_tokens=> v_rhs_tokens )
	;
	CASE v_rule_simple_type
	WHEN 'SQUARE_BRK' 
	THEN null;
	WHEN 'CURLY_BRK' 
	THEN null;
	WHEN 'PIPES' 
	THEN null;
	WHEN 'NOT_SIMPLE' 
	THEN null;
	ELSE 
		RAISE_APPLICATION_ERROR( -20001, 'Return value of f_rule_is_simple not expected: '||v_rule_simple_type );
	END CASE;
	-- 
	
END;
/