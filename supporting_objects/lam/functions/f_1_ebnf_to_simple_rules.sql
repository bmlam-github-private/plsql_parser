CREATE OR REPLACE FUNCTION f_1_ebnf_to_simple_rules 
( p_lhs		VARCHAR2 
 ,p_rhs		VARCHAR2 
 ,p_source  VARCHAR2 DEFAULT 'DUMMY'
) 
RETURN parser_grammar_rule_simple_col
AS     
	co_brack_type_round 	CONSTANT VARCHAR2( 100 ) := upper('round_brk');
	co_brack_type_curly 	CONSTANT VARCHAR2( 100 ) := upper('curly_brk');
	co_brack_type_square 	CONSTANT VARCHAR2( 100 ) := upper('square_brk');
	co_brk_suffix_map_json	CONSTANT VARCHAR2( 1000 ) := '{ "ROUND_BRK": "_gr_", "CURLY_BRK": "_0n_", "SQUARE_BRK": "_op_" }' ;

	-- 
	v_final_rules 		parser_grammar_rule_simple_col :=  parser_grammar_rule_simple_col();
    v_rules_1st_gen 	parser_grammar_rule_simple_col :=  parser_grammar_rule_simple_col();
    v_rules_2nd_gen 	parser_grammar_rule_simple_col :=  parser_grammar_rule_simple_col();
    v_simple_rules 		parser_grammar_rule_simple_col;
	v_rhs_tokens		sys.odciVarchar2List;
	v_rule_simple_type 	VARCHAR2(100);
	v_bracket_type 		VARCHAR2(100);
	v_expand_complex	BOOLEAN := FALSE;
	v_outer_loop_cnt  	NUMBER := 0;
	v_expand_iter  		NUMBER := 0;
	v_sequence  		NUMBER;
	v_open_idx  		NUMBER;
	v_close_idx  		NUMBER;
	v_bracket_found		BOOLEAN := FALSE;
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
	-- we hope that eventually all work rules will have been consumed and found surrogates in v_final_rules 
	
	WHILE TRUE LOOP 
		v_outer_loop_cnt := v_outer_loop_cnt + 1;
		IF v_outer_loop_cnt > 99 
		THEN 
			RAISE_APPLICATION_ERROR( -20001, 'Outer loop hass repeated '||v_outer_loop_cnt||' times!' );
		END IF;
		--
		EXIT WHEN v_rules_1st_gen.count = 0;
		--
		dbms_output.put_line('Ln'||$$plsql_line||' v_rules_1st_gen.count: ' ||  v_rules_1st_gen.count);
		FOR ix_1st_gen IN 1 .. v_rules_1st_gen.count 
		LOOP 
			v_expand_complex := FALSE;
			-- 
			v_rhs_tokens := parser_rule_util.dbx_tokenize_rhs ( v_rules_1st_gen (ix_1st_gen).rhs  );
			v_rule_simple_type :=  f_rule_is_simple ( p_rule_tokens=> v_rhs_tokens );
			dbms_output.put_line('Ln'||$$plsql_line||' v_rule_simple_type: ' || v_rule_simple_type );
			--
			CASE v_rule_simple_type
			WHEN co_brack_type_curly
			THEN null;		-- procedure rules for iteration 0 to N times 
			WHEN co_brack_type_square
			THEN null;		-- produce rules for occurence 0 or 1 
			WHEN 'PIPES' 
			THEN 			-- produces alternativ rules 
							-- example   access ::= read | write 
							-- becomes 	 access ::= read  (1) 
							-- becomes 	 access ::= wirte (2) 
				v_simple_rules := f_ebnf_flatten_alternatives
							( p_lhs        => v_rules_1st_gen(ix_1st_gen).lhs
							 ,p_lhs_root   => p_lhs
							 ,p_rhs_tokens => v_rhs_tokens
							);
				v_final_rules := v_final_rules MULTISET UNION ALL v_simple_rules;
			WHEN 'NOT_SIMPLE' 
			THEN 	
				v_expand_complex := TRUE;
			ELSE 
				RAISE_APPLICATION_ERROR( -20001, 'Return value of f_rule_is_simple not expected: '||v_rule_simple_type );
			END CASE;
			--
        dbms_output.put_line('Ln'||$$plsql_line||' v_final_rules.count: ' ||  v_final_rules.count);
			v_sequence := 0;
			WHILE v_expand_complex  
			LOOP 
				v_expand_iter := v_expand_iter + 1;
				IF v_expand_iter > 100 THEN 
					-- 
					RAISE_APPLICATION_ERROR( -20001, 'expansion of brackets reached '||v_expand_iter||' iterations '||v_expand_iter );
				END IF;
				-- 		
				pr_locate_first_bracket_pair
					( p_input_tokens 	=> v_rhs_tokens 
					 ,po_type			=> v_bracket_type 
					 ,po_open_idx		=> v_open_idx
					 ,po_close_idx		=> v_close_idx
					);
				-- 
				CASE 		
				WHEN v_bracket_type IN 
					( co_brack_type_curly
					 ,co_brack_type_round
					 ,co_brack_type_square 
					) 
				THEN 
					v_sequence := v_sequence + 1;
					pr_process_1_bracket_pair 
					( p_subrule_prefix		=> v_rules_1st_gen( ix_1st_gen ).lhs 		
					 ,p_lhs_root      		=> p_lhs 
					 ,p_source        		=> p_source        		
					 ,p_bracket_type 		=> v_bracket_type 			
					 ,p_open_idx 			=> v_open_idx 				
					 ,p_close_idx 			=> v_close_idx 			
					 ,p_sequence 			=> v_sequence 				
					 ,p_brk_suffix_map_json => co_brk_suffix_map_json 	
					 ,pio_rhs_tokens  		=> v_rhs_tokens  			
					 ,pio_work_rules  		=> v_rules_2nd_gen
					) ;
				ELSE 
					-- move the rule to 2nd gen and set loop end flag 
					v_rules_2nd_gen.extend;
					v_rules_2nd_gen ( v_rules_2nd_gen.last ) := v_rules_1st_gen( ix_1st_gen );
					v_expand_complex := FALSE;
				END CASE; 
			END LOOP; -- v_expand_complex 
			dbms_output.put_line('Ln'||$$plsql_line||' v_rules_2nd_gen.count: ' ||  v_rules_2nd_gen.count);
			--
		END LOOP; -- over v_rules_1st_gen 
		v_rules_1st_gen := v_rules_2nd_gen;
		v_rules_2nd_gen := parser_grammar_rule_simple_col(); 
		-- 
	END LOOP; -- loop forever with loop count check 
	--
	RETURN v_final_rules;
END;
/