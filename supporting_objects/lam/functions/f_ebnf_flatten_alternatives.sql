CREATE OR REPLACE FUNCTION f_ebnf_flatten_alternatives 
( p_lhs			VARCHAR2 
 ,p_lhs_root	VARCHAR2 
 ,p_rhs_tokens	sys.odciVarchar2List 
 ,p_source  VARCHAR2 DEFAULT 'DUMMY'
) RETURN parser_grammar_rule_simple_col
/* When an EBNF rule rhs has several alternatives indicated by pipe sign 
  the function returns all the alternatives which is represented by type parser_grammar_rule_simple 
  In the end the next step of parsing deals with various alternatives for the same LHS without dealing with pipe signs
*/
AS
	v_return parser_grammar_rule_simple_col := parser_grammar_rule_simple_col();
    v_scan_pos	NUMBER := 1;  
	v_pipe_pos	NUMBER := 1;
	v_end_pos	NUMBER := 1;
	v_alt_seq	NUMBER := 0;
	v_new_rhs 	parser_grammar_rule_simple.rhs%TYPE;
BEGIN 
	WHILE v_scan_pos <= p_rhs_tokens.count 
	LOOP 
        -- Find the next pipe
		v_pipe_pos := 
			f_find_token
				( p_tokens		=> p_rhs_tokens 
				 ,p_tok_value 	=> '|'
				 ,p_start_at	=> v_scan_pos 
				);
		v_end_pos := CASE WHEN v_pipe_pos > 0 THEN v_pipe_pos - 1 ELSE p_rhs_tokens.count END;
        --dbms_output.put_line('Ln'||$$plsql_line||'  Loop Start -> v_scan_pos=' || v_scan_pos || ', v_end_pos=' || v_end_pos || ', v_pipe_pos=' || v_pipe_pos);
		-- 
		WITH ordered AS ( 
			SELECT column_value AS tok 
				,  rownum 		AS pos 
			FROM TABLE ( p_rhs_tokens )
			ORDER BY rownum 
		)
		SELECT listagg ( tok, ' ' ) WITHIN GROUP ( ORDER BY pos )
		INTO v_new_rhs			-- will be empty if scan_pos 1 and pipe_pos 1 
		FROM ordered 
		WHERE pos BETWEEN v_scan_pos AND v_end_pos
		;
        --dbms_output.put_line('Ln'||$$plsql_line||'  Extracted v_new_rhs: "' || NVL(v_new_rhs, '<NULL>') || '"');
		IF v_new_rhs IS NOT NULL THEN 
			v_alt_seq := v_alt_seq + 1;
			v_return.extend; 
			v_return ( v_return.last ) := parser_grammar_rule_simple_rec 
					( lhs        => p_lhs 
					 ,rhs        => v_new_rhs
					 ,lhs_root   => p_lhs_root
					 ,subrule_no => v_alt_seq 
					 ,source     => p_source
					);
            --dbms_output.put_line('Ln'||$$plsql_line||'  -> Added subrule #' || v_alt_seq || ' to collection.');
		END IF;
		--
        -- Exit if no more pipes were found
        EXIT WHEN v_pipe_pos = 0;

        -- Advance scan position past the pipe
        v_scan_pos := v_pipe_pos + 1;
	END LOOP;
	--
    --dbms_output.put_line('Ln'||$$plsql_line||'  <<< Exiting f_ebnf_flatten_alternatives. Total rules generated: ' || v_return.count);
	RETURN v_return;
END;
/