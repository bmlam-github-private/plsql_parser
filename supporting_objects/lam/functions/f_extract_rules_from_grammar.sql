CREATE OR REPLACE FUNCTION f_extract_rules_from_grammar (
	p_grammar 	CLOB
) RETURN parser_rule_from_grammar_col  
/* 	Break down a text file containing rules (lfs, rhs) and comments (must be in separate lines.
   
	For simplicity the lhs , separator "::=" and the start of rhs must be on the same line! 
	trailing part of the rhs may spill into new lines 
	A rule must be terminated with semicolon aa list character of the line, but traling whitespaces are OK.

sta	The reason for doing this is to allow complex rhs to be split into several lines but we 
	still can extract the lhs and rhs nicely.

Input text example:
	short_rule1::= that_is_it;
    # rule for identifiers 
    identifier ::= letter  
		{letter | digit}	;
	# rule for identifiers 
    term ::= factor { ("*" | "/" ) factor  }
	;
    short_rule2 ::= that_is_it;Output rules from example

lhs			start_at_line start_at_col	rhs				
----------- ------------- ------------	-------------------------------------------
identifier               1           5	letter  {letter | digit}
term                     6           5	factor { ("*" | "/" ) factor  }
short_rule1              ?            	that_is_it 
short_rule2              ?            	that_is_it 
*/
IS
	co_state_exp_beg CONSTANT VARCHAR2(100) := 'exp_beg';
	co_state_exp_end CONSTANT VARCHAR2(100) := 'exp_end';
	v_state  		VARCHAR2(100) := co_state_exp_beg;
	v_return		parser_rule_from_grammar_col := parser_rule_from_grammar_col();
	v_rule          parser_rule_from_grammar_rec;
    v_lines         	APEX_T_VARCHAR2;
    v_line          	VARCHAR2(32000 	CHAR);
	v_lhs 				parser_grammar_rule_simple.lhs%TYPE;
	v_rhs 				parser_grammar_rule_simple.rhs%TYPE;
	v_got_rule			BOOLEAN := FALSE;
	v_lhs_rhs_sep_pos 	NUMBER; 
	v_rule_start_line 	NUMBER; 
	-- 
	FUNCTION bool2int (p_bool BOOLEAN) RETURN VARCHAR2 AS BEGIN RETURN CASE WHEN p_bool THEN 'True' WHEN NOT p_bool THEN 'False' ELSE '?' END; END bool2int;
	--
BEGIN 
    v_lines := f_apex_split_clob ( p_clob => p_grammar , p_sep=> chr(10) );
	FOR ln_ix IN 1 .. v_lines.count 
	LOOP 
		v_line := v_lines( ln_ix );
        -- Skip empty lines
        IF v_line IS NULL 
			OR instr( ltrim( v_line ), '#' ) = 1 		-- line is a comment;
		THEN
            CONTINUE;
        END IF;
		--
		IF v_state = co_state_exp_beg
		THEN 
			v_lhs_rhs_sep_pos := INSTR(v_line, '::=');
	--dbms_output.put_line ( 'Ln'||$$plsql_line|| ' v_lhs_rhs_sep_pos: '||  v_lhs_rhs_sep_pos );
	--dbms_output.put_line ( 'Ln'||$$plsql_line||' v_sep_pos:'||v_sep_pos );
			IF v_lhs_rhs_sep_pos > 0 THEN
				v_lhs := TRIM(SUBSTR(v_line, 1, v_lhs_rhs_sep_pos - 1));
				v_rhs := TRIM(SUBSTR(v_line, v_lhs_rhs_sep_pos + 3));		-- watch out, end_of_rule may be on the same line! 
				v_rule_start_line := ln_ix;
				v_state := co_state_exp_end;
			ELSE 
				RAISE_APPLICATION_ERROR ( -20001, 'Something went wrong. '
					||'	ln_xi: '                 || ln_ix
					||'	v_lhs: '                 || v_lhs
					||'	v_rhs: '                 || v_rhs
					||'	v_state : '    			 || v_state 
					||'	v_got_rule: '            || bool2int( v_got_rule )
					||'	v_lhs_rhs_sep_pos : '    || v_lhs_rhs_sep_pos 
					||'	v_rule_start_line : '    || v_rule_start_line 
					); 
			END IF;
		END IF; 
		IF v_state = co_state_exp_end THEN 
			DECLARE 
				v_rule_end_pos 	NUMBER;
				v_rhs_len		NUMBER;
			BEGIN 
				v_rule_end_pos := regexp_instr( v_line, ';\s*$' ) ;
				IF v_rule_end_pos > 0 THEN 
					IF v_rule_start_line = ln_ix 
					THEN -- lhs and rhs at the same line 
						v_rhs_len := v_rule_end_pos - v_lhs_rhs_sep_pos - 1;
						v_rhs := substr( v_line, v_rule_end_pos+3, v_rhs_len );
					ELSE 
						v_rhs := v_rhs || ' '||trim(  substr( v_line, 1, v_rule_end_pos - 1 ) );
					END IF; 
					v_got_rule := TRUE;
					v_state := co_state_exp_beg;
				ELSE -- line is still part of rhs 
					v_rhs := v_rhs ||' '||trim( v_line );
				END IF;
			END;
		END IF;
		-- crop the rule 
		IF v_got_rule
		THEN 
			-- add rule to return 
			v_return.extend;
			v_rule := parser_rule_from_grammar_rec
				(lhs => v_lhs 
				,rhs => v_rhs
				,start_at_line => v_rule_start_line
				,start_at_col  => NULL 
			);
			v_return( v_return.count ):= v_rule;
			--
			v_got_rule := FALSE; 
			v_lhs_rhs_sep_pos := NULL; 
			v_rule_start_line := NULL; 
			v_rhs := NULL; 
		END IF;
    END LOOP;
	--
	dbms_output.put_line ( 'Ln'||$$plsql_line||' v_return.count:'||v_return.count );			
	RETURN v_return; 

END;
/	