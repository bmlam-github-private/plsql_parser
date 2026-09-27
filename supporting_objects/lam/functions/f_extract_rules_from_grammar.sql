CREATE OR REPLACE FUNCTION f_extract_rules_from_grammar (
	p_grammar 	CLOB
) RETURN parser_rule_from_grammer_col  
/* Break down a text file containing rules (lfs, rhs) and comments (must be in separate lines.
	For simplicity the lhs , separator "::=" and the start of rhs must be on the same line! 
	trailing part of the rhs may spill into new lines 
	A rule must be terminated with semicolon aa list character of the line, but traling whitespaces are OK.
Input text example:
	# rule for identifiers 
    identifier ::= letter  
		{letter | digit}
	;
	# rule for identifiers 
    term ::= factor { ("*" | "/" ) factor  }
	;
Output rules from example

lhs			start_at_line start_at_col	rhs				
----------- ------------- ------------	-------------------------------------------
identifier               1           5	letter  {letter | digit}
term                     6           5	factor { ("*" | "/" ) factor  }
*/
IS
	v_return		parser_rule_from_grammer_col := parser_rule_from_grammer_col();
    v_lines         APEX_T_VARCHAR2;
    v_line          VARCHAR2(32000 	CHAR);
	v_rhs 			parser_grammar_rule_simple.rhs%TYPE;
	v_expect_rhs_end 	BOOLEAN := FALSE;
	v_rule_start_line 	NUMBER; 
	
BEGIN 
    v_lines := f_apex_split_clob ( p_clob => p_clob , p_sep=> chr(10) );
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
		IF v_expect_rhs_end THEN 
			DECLARE 
				v_rule_end_found NUMBER;
			BEGIN 
				v_rule_end_found := regexp_instr( v_line, ';\s*$' ) ;
				IF v_rule_end_found > 0 THEN 
					v_rhs := v_rhs || substr( v_line, 1, v_rule_end_found - 1 );
					v_expect_rhs_end := FALSE;
					-- add rule to return 
					v_return.extend;
					v_return( v_return.count ).lhs := v_lhs ;
					v_return( v_return.count ).rhs := v_rhs ;
					v_return( v_return.count ).start_at_line := v_rule_start_line;
				END IF;
			END;
		ELSE 
			-- Look for LHS and RHS
			DECLARE
				v_lhs_rhs_sep_pos PLS_INTEGER;
				v_lhs 			parser_grammar_rule_simple.lhs%TYPE;
			BEGIN
				v_lhs_rhs_sep_pos := INSTR(v_line, '::=');
	--dbms_output.put_line ( 'Ln'||$$plsql_line|| ' v_lhs_rhs_sep_pos: '||  v_lhs_rhs_sep_pos );
	--dbms_output.put_line ( 'Ln'||$$plsql_line||' v_sep_pos:'||v_sep_pos );

				IF v_lhs_rhs_sep_pos > 0 THEN
					v_lhs := TRIM(SUBSTR(v_line, 1, v_lhs_rhs_sep_pos - 1));
					v_rhs := TRIM(SUBSTR(v_line, v_lhs_rhs_sep_pos + 3));
					v_rule_start_line := ln_ix;
					v_expect_rhs_end := TRUE;
				END IF;
			END;
		END IF;
    END LOOP;
	--
	dbms_output.put_line ( 'Ln'||$$plsql_line||' v_return.count:'||v_return.count );			
	RETURN v_return; 

END;
/	