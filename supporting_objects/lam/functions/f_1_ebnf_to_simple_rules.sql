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
	co_nl  			CONSTANT VARCHAR2(2) := chr(10);
	-- 
	v_final_rules 		parser_grammar_rule_simple_col :=  parser_grammar_rule_simple_col();
    v_rules_1st_gen 	parser_grammar_rule_simple_col :=  parser_grammar_rule_simple_col();
    v_rules_2nd_gen 	parser_grammar_rule_simple_col :=  parser_grammar_rule_simple_col();
    v_simple_rules 		parser_grammar_rule_simple_col;
	v_rhs_tokens		sys.odciVarchar2List;
	v_rule_simple_type 	VARCHAR2(100);
	v_bracket_type 		VARCHAR2(100);
	v_new_rhs 			VARCHAR2(4000);
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
		dbms_output.put_line('********************** OUTER LOOP ***************************************');
		dbms_output.put_line('********************** Iteration '|| v_outer_loop_cnt ||' ***************************************');
		IF v_outer_loop_cnt > 9 
		THEN 
			RAISE_APPLICATION_ERROR( -20001, 'Outer loop has repeated '||v_outer_loop_cnt||' times!' );
		END IF;
		--
		EXIT WHEN v_rules_1st_gen.count = 0;
		--
		dbms_output.put_line('Ln'||$$plsql_line||' v_rules_1st_gen.count: ' ||  v_rules_1st_gen.count);
		FOR ix_1st_gen IN 1 .. v_rules_1st_gen.count 
		LOOP 
		dbms_output.put_line('********************** 1st-gen rule '||ix_1st_gen ||' ***************************************');
		dbms_output.put_line('Ln'||$$plsql_line||' lhs: ' ||  v_rules_1st_gen( ix_1st_gen ).lhs );
		dbms_output.put_line('Ln'||$$plsql_line||' rhs: ' ||  v_rules_1st_gen( ix_1st_gen ).rhs );
		
			v_expand_complex := FALSE;
			-- 
			v_rhs_tokens := parser_rule_util.dbx_tokenize_rhs ( v_rules_1st_gen (ix_1st_gen).rhs  );
			--
			v_rule_simple_type :=  f_rule_is_simple ( p_rule_tokens=> v_rhs_tokens );
			dbms_output.put_line('Ln'||$$plsql_line||' v_rule_simple_type: ' || v_rule_simple_type );
			--
			CASE v_rule_simple_type
			--
			WHEN co_brack_type_curly
			THEN 			-- procedure rules for iteration 0 to N times 
				v_simple_rules:=  f_ebnf_flatten_repetition 
					( p_lhs			=>  v_rules_1st_gen(ix_1st_gen).lhs 
					 ,p_lhs_root	=> p_lhs
					 ,p_rhs_tokens	=> v_rhs_tokens 
					 ,p_open_idx	=> NULL 	-- for better performance, we should change f_rule_is_simple to return open and close index! 
					 ,p_close_idx	=> NULL 
					 ,p_source  	=> p_source
					) ;
        dbms_output.put_line('Ln'||$$plsql_line||' v_simple_rules.count: ' ||  v_simple_rules.count);
				v_final_rules := v_final_rules MULTISET UNION ALL v_simple_rules;
			-- 
			WHEN co_brack_type_square
			THEN       	-- produce rules for occurence 0 or 1 
				v_simple_rules:=  f_ebnf_flatten_optional 
					( p_lhs			=>  v_rules_1st_gen(ix_1st_gen).lhs 
					 ,p_lhs_root	=> p_lhs
					 ,p_rhs_tokens	=> v_rhs_tokens 
					 ,p_open_idx	=> NULL 	-- for better performance, we should change f_rule_is_simple to return open and close index! 
					 ,p_close_idx	=> NULL 
					 ,p_source  	=> p_source
					) ;
        dbms_output.put_line('Ln'||$$plsql_line||' v_simple_rules.count: ' ||  v_simple_rules.count);
				v_final_rules := v_final_rules MULTISET UNION ALL v_simple_rules;
			-- 
			WHEN 'PIPES' 
			THEN 			-- produces alternativ rules 
							-- example   access ::= read | write 
							-- becomes 	 access ::= read  (1) 
							-- becomes 	 access ::= wirte (2) 
				v_simple_rules := f_ebnf_flatten_alternatives
						( p_lhs        => v_rules_1st_gen(ix_1st_gen).lhs
						 ,p_lhs_root   => p_lhs
						 ,p_rhs_tokens => v_rhs_tokens
						,p_source  	=> p_source
						);
        dbms_output.put_line('Ln'||$$plsql_line||' v_simple_rules.count: ' ||  v_simple_rules.count);
				v_final_rules := v_final_rules MULTISET UNION ALL v_simple_rules;
			WHEN 'NOT_SIMPLE' 
			THEN 	
				v_expand_complex := TRUE;
			WHEN 'SIMPLE' 
			THEN 	
				v_final_rules.extend;
				v_final_rules( v_final_rules.last ) := v_rules_1st_gen( ix_1st_gen );
			ELSE 
				RAISE_APPLICATION_ERROR( -20001, 'Return value of f_rule_is_simple not expected: '||v_rule_simple_type );
			END CASE;
			--
        dbms_output.put_line('Ln'||$$plsql_line||' v_final_rules.count: ' ||  v_final_rules.count);
			v_sequence := 0;
			v_expand_iter := 0;
			WHILE v_expand_complex  
			LOOP 
				v_expand_iter := v_expand_iter + 1;
        dbms_output.put_line( co_nl||'Ln'||$$plsql_line||' ************** ' ||' v_expand_iter: ' ||v_expand_iter );
				IF v_expand_iter > 10 THEN 
					-- 
					RAISE_APPLICATION_ERROR( -20001, 'expansion of brackets reached '||v_expand_iter||' iterations!' );
				END IF;
				-- 		
				pr_locate_first_bracket_pair
					( p_input_tokens 	=> v_rhs_tokens 
					 ,po_type			=> v_bracket_type  
					 ,po_open_idx		=> v_open_idx
					 ,po_close_idx		=> v_close_idx
					);
				-- 
        dbms_output.put_line('Ln'||$$plsql_line||' v_bracket_type: ' ||v_bracket_type||' v_open_idx: ' ||v_open_idx||' v_close_idx: ' ||v_close_idx );
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
					--
					SELECT listagg ( column_value, ' ' ) INTO v_new_rhs FROM TABLE ( v_rhs_tokens );
					dbms_output.put_line('Ln'||$$plsql_line||' v_rhs_tokens: ' ||v_new_rhs  );
					dbms_output.put_line('Ln'||$$plsql_line||' last 2nd work rule : ' 
							||co_nl||'   lhs:'||  v_rules_2nd_gen( v_rules_2nd_gen.last ).lhs 
							||co_nl||'   rhs:'||  v_rules_2nd_gen( v_rules_2nd_gen.last ).rhs
							);
				ELSE 
					-- move the rule to 2nd gen and set loop end flag 
					v_rules_2nd_gen.extend;
					v_rules_2nd_gen ( v_rules_2nd_gen.last ) := v_rules_1st_gen( ix_1st_gen );
					v_rules_2nd_gen ( v_rules_2nd_gen.last ).rhs := v_new_rhs;  	 -- this is the link to the produced rules 
        dbms_output.put_line('Ln'||$$plsql_line||' curr rule lhs : ' ||v_rules_1st_gen( ix_1st_gen ).lhs ||' new rhs: ' ||v_new_rhs  );
					v_expand_complex := FALSE;
				END CASE; 
			END LOOP; -- v_expand_complex 
			dbms_output.put_line('Ln'||$$plsql_line||' v_rules_2nd_gen.count: ' ||  v_rules_2nd_gen.count);
			--
		END LOOP; -- over v_rules_1st_gen 
	dbms_output.put_line('Ln'||$$plsql_line||' v_rules_2nd_gen.count: ' ||  v_rules_2nd_gen.count);
		v_rules_1st_gen := v_rules_2nd_gen;
		v_rules_2nd_gen := parser_grammar_rule_simple_col(); 
		-- 
	END LOOP; -- loop forever with loop count check 
	--
	RETURN v_final_rules;
END;
/