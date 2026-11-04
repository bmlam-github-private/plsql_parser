CREATE OR REPLACE FUNCTION f_1_ebnf_to_simple_rules 
( p_lhs		VARCHAR2 
 ,p_rhs		VARCHAR2 
 ,p_source  VARCHAR2 DEFAULT 'DUMMY'
) 
RETURN parser_grammar_rule_simple_col
AS     
	CONSTANT	co_brack_type_round 	CONSTANT VARCHAR2( 100 ) := upper('round_brk');
	CONSTANT	co_brack_type_curly 	CONSTANT VARCHAR2( 100 ) := upper('curly_brk');
	CONSTANT	co_brack_type_square 	CONSTANT VARCHAR2( 100 ) := upper('square_brk');
	-- 
	v_final_rules 		parser_grammar_rule_simple_col :=  parser_grammar_rule_simple_col();
    v_rules_1st_gen 	parser_grammar_rule_simple_col :=  parser_grammar_rule_simple_col();
    v_rules_2nd_gen 	parser_grammar_rule_simple_col :=  parser_grammar_rule_simple_col();
	v_rhs_tokens		sys.odciVarchar2List;
	v_rule_simple_type 	VARCHAR2(100);
	v_recursive_expand			BOOLEAN := FALSE;
	v_nesting_level  	NUMBER := 0;
	v_bracket_found		BOOLEAN := FALSE;
	-- 
	PROCEDURE pr_process_1_bracket_pair 
		( p_lhs_curr			VARCHAR2 
		 ,p_bracket_type 		VARCHAR2 
		 ,p_open_idx 			NUMBER 
		 ,p_close_idx 			NUMBER 
		 ,pio_rhs_tokens  IN OUT sys.odciVarchar2List 
		)
	AS 
	/*  Replace content of brackets in list of tokens in place and produce a surrogate rule 
		produced rules will added to a table in outer scope v_rules_2nd_gen ? 
	*/ 
		v_tokens_out 		sys.odciVarchar2List := sys.odciVarchar2List();
		v_new_rule_lhs 	parser_alt_token.lhs%TYPE;
		v_bracket_type 		VARCHAR2(100);
	BEGIN 
		v_nesting_level :=v_nesting_level + 1;
		-- 
	END pr_process_1_bracket_pair;
	-- 
BEGIN 
	IF p_lhs IS NULL THEN 
		RETURN v_final_rules;
	END IF;
	-- convert to ebnf rule tokens 
	v_rhs_tokens := parser_rule_util.dbx_tokenize_rhs ( p_rhs );
	-- populate array with root rule 
	v_rules_1st_gen.extend;
	v_rules_1st_gen(1) := parser_grammar_rule_simple_rec 
			( lhs		=> p_lhs 
 			 ,rhs		=> p_rhs 
 			 ,subrule_no=> 0
 			 ,lhs_root	=> p_rhs 
 			 ,source	=> p_source 
			) ;
	-- 
	v_final_rules := v_rules_1st_gen; 	-- initial value 
	-- we hope that eventually all work rules will have been consumed and found surrogates in v_final_rules 
	WHILE v_rules_1st_gen.count > 0
	LOOP 
		FOR rule_ix IN 1 .. v_rules_1st_gen.count 
		LOOP 
			v_recursive_expand := FALSE;
			-- 
			v_rhs_tokens := parser_rule_util.dbx_tokenize_rhs ( v_rules_1st_gen (rule_ix).rhs  );
			v_rule_simple_type :=  f_rule_is_simple ( p_rule_tokens=> v_rhs_tokens )
			;
			CASE 
			WHEN co_brack_type_curly
			THEN null;		-- procedure rules for iteration 0 to N times 
			WHEN co_brack_type_square
			THEN null;		-- produce rules for occurence 0 or 1 
			WHEN 'PIPES' 
			THEN null;		-- produces alternativ rules 
			WHEN 'NOT_SIMPLE' 
			THEN 	
				v_recursive_expand := TRUE;
			ELSE 
				RAISE_APPLICATION_ERROR( -20001, 'Return value of f_rule_is_simple not expected: '||v_rule_simple_type );
			END CASE;
			--
			--
			WHILE v_recursive_expand THEN 
			LOOP 
				IF v_expand_iter > 100 THEN 
					-- 
					RAISE_APPLICATION_ERROR( -20001, 'expansion of brackets reached max. nesting level '||v_expand_iter );
				END IF;
				-- 		
				pr_locate_first_bracket_pair
					( p_input_tokens 	=> v_rhs_tokens 
					 ,po_type			=> v_bracket_type 
					 ,po_open_idx		=> v_open_idx
					 ,po_close_idx		=> v_close_idx
					);
				CASE 		
				WHEN v_bracket_type IN 
					( co_brack_type_curly
					 ,co_brack_type_round
					 ,co_brack_type_square 
					) 
				THEN 
					pr_process_1_bracket_pair 
						( p_lhs_curr			=> v_rules_1st_gen( rule_ix ).lhs 
						 ,p_bracket_type 		=> v_bracket_type 
						 ,p_open_idx 			=> v_open_idx 
						 ,p_close_idx 			=> v_close_idx 
						 ,pio_rhs_tokens  		=> v_rhs_tokens 
						)
				END CASE; 
			END LOOP; -- v_recursive_expand 
			--
			v_rules_1st_gen := v_rules_second_gen;
			v_rules_2nd_gen.delete; 
		END LOOP; -- over v_rules_1st_gen 
		-- 
END;
/