CREATE OR REPLACE FUNCTION f_extract_rules_from_grammar (
	p_grammar 	CLOB
) RETURN parser_rule_from_grammar_col  
/* 	Break down a text file containing rules (lfs, rhs) and comments (must be in separate lines.
   
	For simplicity the lhs , separator "::=" and the start of rhs must be on the same line! 
	trailing part of the rhs may spill into new lines 
	A rule must be terminated with semicolon aa list character of the line, but traling whitespaces are OK.

sta	The reason for doing this is to allow complex rhs to be split into several lines but we 
	still can extract the lhs and rhs nicely.

Input grammar example:
	short_rule1::= that_is_it;
    # rule for identifiers spans 3 lines 
    identifier ::= letter  
		{letter | 
		digit}	;
	# rule for terms with rule end character in its own line 
    term ::= factor { ("*" | "/" ) factor  }
	;
	# another short rule with semicolon as part of symbol 
    short_rule2 ::= that_is_it ";"      ;
	
Output rules from example

lhs			start_at_line start_at_col	rhs				
----------- ------------- ------------	-------------------------------------------
identifier               1           5	letter  {letter | digit}
term                     6           5	factor { ("*" | "/" ) factor  }
short_rule1              ?            	that_is_it 
short_rule2              ?            	that_is_it ";"
*/
IS
	co_state_exp_beg CONSTANT VARCHAR2(100) := 'exp_beg';
	co_state_exp_end CONSTANT VARCHAR2(100) := 'exp_end';
	v_state  		VARCHAR2(100) := co_state_exp_beg;
	v_return		parser_rule_from_grammar_col := parser_rule_from_grammar_col();
	v_rul_tmp     	parser_rule_from_grammar_rec := parser_rule_from_grammar_rec(null, null, null, null);
	-- v_rule FIND anchor 
    v_lines         	APEX_T_VARCHAR2;
    v_line          	VARCHAR2(32000 	CHAR);
	v_rhs_buf			parser_grammar_rule_simple.rhs%TYPE;
	--v_rul_tmp.lhs 				parser_grammar_rule_simple.lhs%TYPE;
	--v_rul_tmp.rhs 				parser_grammar_rule_simple.rhs%TYPE;
	v_got_rule			BOOLEAN := FALSE;
	v_lhs_rhs_sep_pos 	NUMBER; 
	--v_rul_tmp.start_at_line 	NUMBER; 
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
			OR regexp_like( v_line, '\s*#' )  		-- line is a comment;
		THEN
            CONTINUE;
        END IF;
		--
	dbms_output.put_line ( 'Ln'||$$plsql_line|| rpad( ' ', 40, '* ' ) ||' ln_ix: '|| ln_ix||chr(10)||' v_line: '|| v_line );
		IF v_state = co_state_exp_beg
		THEN 
			v_lhs_rhs_sep_pos := INSTR(v_line, '::=');
			IF v_lhs_rhs_sep_pos > 0 THEN
				v_rul_tmp.lhs := TRIM(SUBSTR(v_line, 1, v_lhs_rhs_sep_pos - 1));
				v_rhs_buf := TRIM( SUBSTR( v_line, v_lhs_rhs_sep_pos + 3) );		-- watch out, end_of_rule may be on the same line! 
				v_rul_tmp.start_at_line := ln_ix;
				v_rul_tmp.start_at_col  := instr( v_line, v_rul_tmp.lhs );
				v_state := co_state_exp_end;
	dbms_output.put_line ( 'Ln'||$$plsql_line||' v_rhs_buf: '|| v_rhs_buf );
			ELSE 
				RAISE_APPLICATION_ERROR ( -20001, 'Something went wrong. '
					||'	ln_xi: '                 || ln_ix
					||'	v_rul_tmp.lhs: '       || v_rul_tmp.lhs
					||'	v_rhs_buf: '             || v_rhs_buf 
					||'	v_rul_tmp.rhs: '       || v_rul_tmp.rhs
					||'	v_state: '    			 || v_state 
					||'	v_got_rule: '            || bool2int( v_got_rule )
					||'	v_lhs_rhs_sep_pos: '     || v_lhs_rhs_sep_pos 
					||'	v_rul_tmp.start_at_line: '|| v_rul_tmp.start_at_line 
					||'	v_rul_tmp.start_at_col: ' || v_rul_tmp.start_at_col
					); 
			END IF;
		END IF; 
dbms_output.put_line ( 'Ln'||$$plsql_line||' v_state:'||v_state ||' v_rul_tmp.lhs: '||v_rul_tmp.lhs ||' v_rul_tmp.start_at_line:'||v_rul_tmp.start_at_line 	);
		IF v_state = co_state_exp_end THEN 
			DECLARE 
				v_rule_end_pos 	NUMBER;
			BEGIN 
				v_rule_end_pos := regexp_instr( v_line, ';\s*$' ) ;	-- this excludes the case where semicolon is part of a symbol because if the semicolon would to be followed by double qoute or other character.
dbms_output.put_line ( 'Ln'||$$plsql_line||' v_state:'||v_state 	||'	v_rule_end_pos: '               || v_rule_end_pos );
				IF v_rule_end_pos = 0 
				THEN 
					IF NOT v_rul_tmp.start_at_line = ln_ix 
					THEN 
						-- entire line is part of rhs 
						v_rhs_buf := v_rhs_buf ||' '||trim( v_line );
					END IF; 
dbms_output.put_line ( 'Ln'||$$plsql_line||' v_rhs_buf: '  || v_rhs_buf );
				ELSE -- end of rule found 
					IF v_rul_tmp.start_at_line = ln_ix 
					THEN -- rule is in a single line , ignore buffer 
						v_rhs_buf := trim( substr( v_line, v_lhs_rhs_sep_pos+3 ) );
					ELSE 
						v_rhs_buf := v_rhs_buf || ' '||trim(  substr( v_line, 1, v_rule_end_pos ) );
					END IF;
					-- chop the rule end character 
					v_rul_tmp.rhs := substr( v_rhs_buf, 1, length( v_rhs_buf )-1 ) ;
dbms_output.put_line ( 'Ln'||$$plsql_line||' v_rhs_buf: '  || v_rhs_buf ||'	v_rul_tmp.rhs: ' || v_rul_tmp.rhs );
					--
					v_got_rule := TRUE;
				END IF;
				-- 
			END; 
		END IF;
dbms_output.put_line ( 'Ln'||$$plsql_line||'	v_lhs_rhs_sep_pos: '    || v_lhs_rhs_sep_pos ||' v_got_rule: ' || bool2int( v_got_rule ) ||'	v_rul_tmp.rhs: '                 || v_rul_tmp.rhs);
		-- crop the rule 
		IF v_got_rule
		THEN 
			-- add rule to return 
			v_return.extend;
			v_return( v_return.count ):= v_rul_tmp;
			v_rul_tmp := parser_rule_from_grammar_rec(null, null, null, null); 		-- re-init
			--
			v_got_rule := FALSE; 
			v_state	:= co_state_exp_beg;
			v_lhs_rhs_sep_pos := NULL; 
		END IF;
		-- 
dbms_output.put_line ( 'Ln'||$$plsql_line
					||'	v_state: '               || v_state 
					||'	v_rul_tmp.lhs: '                 || v_rul_tmp.lhs
					||'	v_rhs_buf: '             || v_rhs_buf 
					||'	v_got_rule: '            || bool2int( v_got_rule )
					||'	v_rul_tmp.start_at_line: '    || v_rul_tmp.start_at_line 
					); 
    END LOOP;
	--
	dbms_output.put_line ( 'Ln'||$$plsql_line||' v_return.count:'||v_return.count );			
	RETURN v_return; 

END;
/	