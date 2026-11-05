CREATE OR REPLACE PROCEDURE pr_process_1_bracket_pair 
( p_subrule_prefix		VARCHAR2 
 ,p_lhs_root      		VARCHAR2 
 ,p_source        		VARCHAR2 
 ,p_bracket_type 		VARCHAR2 --   ROUND_BRK, CURLY_BRK or SQUARE_BRK
 ,p_open_idx 			NUMBER   -- index of open bracket 
 ,p_close_idx 			NUMBER	 -- index of close bracket 
 ,p_sequence 			NUMBER	
 ,p_brk_suffix_map_json VARCHAR2 
 ,pio_rhs_tokens  		IN OUT 			sys.odciVarchar2List 
 ,pio_work_rules  		IN OUT NOCOPY 	parser_grammar_rule_simple_col 
) AS 
/* Replace the tokens of a EBNF rule RHS so that whichever tokens are between p_open_idx and p_close_idx 
   will be replaced by a new subrule. The name of the new subrule is constructed by concatinating
	* p_subrule_prefix 
	* <subrule_suffix> 
	* p_sequence 
	<subrule_suffix> will be extracted from p_brk_suffix_map_json which is the value of the attribute by the names
		ROUND_BRK, CURLY_BRK or SQUARE_BRK as attribute name 
	pio_rhs_tokens does will have a new token with tne new subrule name inserted, but pruned of the tokens between 
	p_open_idx and p_close_idx. The pruned tokens are converted to a string which becomes RHS of a new record of 
	type parser_grammar_rule_simple_rec with these attributes 
		LHS              : name of new subrule 
		RHS              : string based on pruned tokens 
		LHS_ROOT         : equals p_lhs_root
		SUBRULE_NO       : equals p_sequence 
		SOURCE           : equals p_source
	
	The new parser_grammar_rule_simple_rec instance is appended to pio_work_rules. 
	pio_rhs_tokens shall have no gap in the indexes 
*/ 
  v_subrule_suffix VARCHAR2(100);
  v_new_subrule    VARCHAR2(4000);
  v_new_rhs        VARCHAR2(32767);
  v_new_tokens     sys.odciVarchar2List := sys.odciVarchar2List();
BEGIN 
  -- sanity checks
  IF false then 
	  IF 0 = 1
	   OR ( p_bracket_type  = 'ROUND_BRK' 
			AND ( pio_rhs_tokens( p_open_idx ) 	<> '(' OR 
				  pio_rhs_tokens( p_close_idx ) <> ')'   )
		) 
		OR ( p_bracket_type = 'SQUARE_BRK' 
			AND ( pio_rhs_tokens( p_open_idx ) <> '[' OR 
				  pio_rhs_tokens( p_close_idx ) <> ']'    )
		)
		OR ( p_bracket_type = 'CURLY_BRK' 
			AND ( pio_rhs_tokens( p_open_idx ) 	<> '{' OR 
				  pio_rhs_tokens( p_close_idx ) <> '}'   )
		)
		THEN 
			RAISE_APPLICATION_ERROR ( -20001, 'Open or close index does not point to expected symbols according to bracket type '||p_bracket_type );
		END IF;
		
	  -- 1. Extract the subrule suffix from the JSON map based on the bracket type
	  v_subrule_suffix := JSON_VALUE(p_brk_suffix_map_json, '$."' || p_bracket_type || '"');
	  IF v_subrule_suffix IS NULL THEN
		v_subrule_suffix := JSON_VALUE(p_brk_suffix_map_json, '$.' || p_bracket_type);
	  END IF;
   END IF; -- switch sanity-checks 
   -- 
  -- 2. Construct the new subrule name
  v_new_subrule := p_subrule_prefix || v_subrule_suffix || '_'||TO_CHAR(p_sequence);

  -- 3. Extract and concatenate the tokens *between* the open and close brackets for the new RHS
  v_new_rhs := '';
  IF p_close_idx > p_open_idx  THEN
	  IF p_bracket_type = 'ROUND_BRK' 
	  THEN 
	  -- if the bracket pair is round, we want to remove them from the new RHS 
		FOR i IN (p_open_idx + 1) .. (p_close_idx - 1) LOOP
		  IF i = p_open_idx + 1 THEN
			v_new_rhs := pio_rhs_tokens(i);
		  ELSE
			v_new_rhs := v_new_rhs || ' ' || pio_rhs_tokens(i);
		  END IF;
		END LOOP;
	  ELSE 
	  -- keep the brackets if square or curly 
		FOR i IN p_open_idx  .. p_close_idx LOOP
		  IF i = p_open_idx THEN
			v_new_rhs := pio_rhs_tokens(i);
		  ELSE
			v_new_rhs := v_new_rhs || ' ' || pio_rhs_tokens(i);
		  END IF;
		END LOOP;
	  END IF;
  END IF; -- plausi check open and close index 

  -- 4. Create and append the new grammar rule record to pio_work_rules
  pio_work_rules.EXTEND;
  pio_work_rules(pio_work_rules.LAST) := parser_grammar_rule_simple_rec(
      lhs        => v_new_subrule,
      rhs        => v_new_rhs,
      lhs_root   => p_lhs_root,
      subrule_no => p_sequence,
      source     => p_source
  );

  -- 5. Rebuild pio_rhs_tokens:
  --    - Keep tokens before p_open_idx
  --    - Insert the new subrule token (replacing the bracket pair and inner tokens entirely)
  --    - Keep tokens after p_close_idx
  
  -- Copy tokens before opening bracket
  IF p_open_idx > 1 THEN
    FOR i IN 1 .. (p_open_idx - 1) LOOP
      v_new_tokens.EXTEND;
      v_new_tokens(v_new_tokens.LAST) := pio_rhs_tokens(i);
    END LOOP;
  END IF;

  -- Insert new subrule token
  v_new_tokens.EXTEND;
  v_new_tokens(v_new_tokens.LAST) := v_new_subrule;

  -- Copy tokens after closing bracket
  IF p_close_idx < pio_rhs_tokens.COUNT THEN
    FOR i IN (p_close_idx + 1) .. pio_rhs_tokens.COUNT LOOP
      v_new_tokens.EXTEND;
      v_new_tokens(v_new_tokens.LAST) := pio_rhs_tokens(i);
    END LOOP;
  END IF;

  -- Assign back to IN OUT parameter with dense indices
  pio_rhs_tokens := v_new_tokens;
END;
/

