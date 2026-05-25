CREATE OR REPLACE PROCEDURE pr_convert_clob_to_rules
( p_clob		CLOB
 ,p_source 	VARCHAR2 
 )
AS 
    v_pos        PLS_INTEGER := 1;
    v_line       VARCHAR2(32767);
    v_lhs        VARCHAR2(4000);
    v_rhs        VARCHAR2(4000);
    v_len        PLS_INTEGER;
    v_newline    PLS_INTEGER;
	v_source_normed 	parser_grammar_rule_ebnf.source%TYPE;
    -- 
BEGIN
    IF p_clob IS NULL THEN
        RETURN;
    END IF;
	--
	v_source_normed := trim( upper ( p_source ) );
    v_len := DBMS_LOB.getlength(p_clob);

	DELETE parser_grammar_rule_ebnf 
	WHERE source = v_source_normed
	; 
    WHILE v_pos <= v_len 
	LOOP
        -- Find next newline
        v_newline := DBMS_LOB.instr(p_clob, CHR(10), v_pos);
--dbms_output.put_line ( 'Ln'||$$plsql_line||' v_newline:'||v_newline||' v_pos:'||v_pos );
        IF v_newline = 0 THEN
            v_newline := v_len + 1;
        END IF;
--dbms_output.put_line ( 'Ln'||$$plsql_line||' v_newline:'||v_newline );

        -- Extract line
        v_line := TRIM(DBMS_LOB.substr(p_clob, v_newline - v_pos, v_pos));

        -- Move position
        v_pos := v_newline + 1;
--dbms_output.put_line ( 'Ln'||$$plsql_line||' v_pos:'||v_pos ||' v_line:'||v_line );

        -- Skip empty lines
        IF v_line IS NULL 
			OR instr( ltrim( v_line ), '#' ) = 1 		-- line is a comment;
		THEN
            CONTINUE;
        END IF;

        -- Parse LHS and RHS
        DECLARE
            v_sep_pos PLS_INTEGER;
        BEGIN
            v_sep_pos := INSTR(v_line, '::=');
--dbms_output.put_line ( 'Ln'||$$plsql_line||' v_sep_pos:'||v_sep_pos );

			IF v_sep_pos > 0 THEN
                v_lhs := TRIM(SUBSTR(v_line, 1, v_sep_pos - 1));
                v_rhs := TRIM(SUBSTR(v_line, v_sep_pos + 3));

                --  into table
                INSERT INTO parser_grammar_rule_ebnf t
						(lhs, 	rhs,	source )
                    VALUES (v_lhs, v_rhs, 	v_source_normed )
					;
            END IF;
        END;
    END LOOP;
	COMMIT; 
END;
/

--show errors 