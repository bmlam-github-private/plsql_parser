CREATE OR REPLACE FUNCTION f_ebnf_flatten_repetition 
( p_lhs			VARCHAR2 
 ,p_lhs_root	VARCHAR2 
 ,p_rhs_tokens	sys.odciVarchar2List 
 ,p_open_idx	NUMBER 
 ,p_close_idx	NUMBER 
 ,p_source  VARCHAR2 DEFAULT 'DUMMY'
) RETURN parser_grammar_rule_simple_col
/* When an EBNF rule rhs is bracketed by curly brackets, meaning the symbol within the brackets may occur 0 to N times, 
  the function returns two rows plus, each represented by type parser_grammar_rule_simple.
  row 1 has the same lhs, but the rhs is mutated with the bracketed elements replaced by a new subrule which is named lhs + _<abbreviation_of_first_key>_lst_ 
  row 2 has as lhs the new subrule name constructed above and all bracketed symbols except the brackets. At the end, an alternative with epsilon is appended
  In the end the next step of parsing deals with the two alternatives for the same LHS without dealing with curly brackets 
  Example: 
	select_list ::= column_expr { "," column_expr }
  Row 1
*/
AS
	v_return parser_grammar_rule_simple_col := parser_grammar_rule_simple_col();
	v_head			VARCHAR2(1000);
	v_tail			VARCHAR2(1000);
	v_new_rhs		VARCHAR2(1000);
	v_temp_tokens   sys.odciVarchar2List;
	v_new_rule_name	VARCHAR2(1000);
	v_open_idx		NUMBER;
	v_close_idx		NUMBER;
BEGIN 
	v_open_idx 	:= p_open_idx;
	v_close_idx	:= p_close_idx;
	IF v_open_idx IS NULL OR v_close_idx IS NULL 
	THEN 
		DECLARE 
			v_type_dummy 	VARCHAR2(100);
		BEGIN 
			pr_locate_first_bracket_pair
				(p_input_tokens => p_rhs_tokens
				,po_type        => v_type_dummy 
				,po_open_idx    => v_open_idx 
				,po_close_idx   => v_close_idx 
				);
	--dbms_output.put_line ( $$plsql_unit||':'||$$plsql_line||' v_type_dummy: '||v_type_dummy );
			IF v_type_dummy <> 'CURLY_BRK' 
			THEN 
				RAISE_APPLICATION_ERROR( -20001, 'No brackets positions given and no curly brackets pair found!' );
			END IF;
		END;
	END IF; 
	--dbms_output.put_line ( $$plsql_unit||':'||$$plsql_line||' v_open_idx: '||v_open_idx ||' v_close_idx: '|| v_close_idx);
	-- Row 1 with unchanged LHS 
	WITH ordered AS (
		SELECT column_value 	AS tok 
			,  ROWNUM			AS pos 
		FROM TABLE ( p_rhs_tokens )
		ORDER BY pos 
	)
	SELECT tok 
	BULK COLLECT INTO v_temp_tokens 
	FROM ordered 
	WHERE pos between v_open_idx +1 AND v_close_idx - 1 
	;
	v_new_rule_name := f_make_short_new_name ( p_prefix => p_lhs, p_tokens=> v_temp_tokens );
	v_new_rule_name := v_new_rule_name||'_lst';
	--dbms_output.put_line ( $$plsql_unit||':'||$$plsql_line||' v_temp_tokens.count: '||v_temp_tokens.count ||' v_new_rule_name: '|| v_new_rule_name);
	-- 
	WITH ordered AS (
		SELECT column_value 	AS tok 
			,  ROWNUM			AS pos 
		FROM TABLE ( p_rhs_tokens )
		ORDER BY pos 
	)
	SELECT listagg ( tok, ' ' ) WITHIN GROUP ( ORDER BY rownum )
	INTO v_head 
	FROM ordered 
	WHERE pos < v_open_idx
	;
	WITH ordered AS (
		SELECT column_value 	AS tok 
			,  ROWNUM			AS pos 
		FROM TABLE ( p_rhs_tokens )
		ORDER BY pos 
	)
	SELECT listagg ( tok, ' ' ) WITHIN GROUP ( ORDER BY rownum )
	INTO v_tail 
	FROM ordered 
	WHERE pos > v_close_idx
	;
	v_new_rhs := v_head ||' '||v_new_rule_name ||' '||v_tail;
	v_return.extend ;
	v_return( v_return.last ) := parser_grammar_rule_simple_rec 
            ( lhs        => p_lhs
             ,rhs        => v_new_rhs
             ,lhs_root   => p_lhs_root
             ,subrule_no => 1 
             ,source     => p_source
            );
	--
	-- row 2 
	v_return.extend ;
	SELECT listagg ( column_value, ' ' ) WITHIN GROUP ( ORDER BY rownum )
	INTO v_new_rhs 
	FROM TABLE ( v_temp_tokens )
	;
	v_new_rhs := v_new_rhs ||' | epsilon';
	v_return( v_return.last ) := parser_grammar_rule_simple_rec 
            ( lhs        => v_new_rule_name 
             ,rhs        => v_new_rhs
             ,lhs_root   => p_lhs_root
             ,subrule_no => 1 
             ,source     => p_source
            );
	-- 
	RETURN v_return;
END;
/