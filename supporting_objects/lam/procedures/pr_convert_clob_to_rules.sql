CREATE OR REPLACE PROCEDURE pr_convert_clob_to_rules
( p_clob		CLOB
 ,p_comments 	VARCHAR2 
 )
AS 
    v_pos        PLS_INTEGER := 1;
    v_line       VARCHAR2(32767);
    v_lhs        VARCHAR2(4000);
    v_rhs        VARCHAR2(4000);
    v_len        PLS_INTEGER;
    v_newline    PLS_INTEGER;
    -- 
    TYPE hash_occurrence IS TABLE OF INTEGER INDEX BY VARCHAR2(100);
    v_lhs_occ hash_occurrence;  -- allow detection of duplicate lhs 
BEGIN
    IF p_clob IS NULL THEN
        RETURN;
    END IF;

    v_len := DBMS_LOB.getlength(p_clob);

    WHILE v_pos <= v_len LOOP
        -- Find next newline
        v_newline := DBMS_LOB.instr(p_clob, CHR(10), v_pos);

        IF v_newline = 0 THEN
            v_newline := v_len + 1;
        END IF;

        -- Extract line
        v_line := TRIM(DBMS_LOB.substr(p_clob, v_newline - v_pos, v_pos));

        -- Move position
        v_pos := v_newline + 1;

        -- Skip empty lines
        IF v_line IS NULL THEN
            CONTINUE;
        END IF;

        -- Parse LHS and RHS
        DECLARE
            v_sep_pos PLS_INTEGER;
        BEGIN
            v_sep_pos := INSTR(v_line, '::=');

            IF v_sep_pos > 0 THEN
                v_lhs := TRIM(SUBSTR(v_line, 1, v_sep_pos - 1));
                v_rhs := TRIM(SUBSTR(v_line, v_sep_pos + 3));

                -- Merge into table
                MERGE INTO parser_grammar_rules t
                USING (
					SELECT v_lhs AS lhs
						 , v_rhs AS rhs 
						 , p_comments AS comments 
						 FROM dual
						 ) s
                ON (t.lhs = s.lhs 
					AND t.rhs = s.rhs
				)
                WHEN NOT MATCHED THEN
                    INSERT (lhs, 	rhs,	comments )
                    VALUES (s.lhs, s.rhs, s.comments)
                WHEN MATCHED THEN
                    UPDATE
						SET comments = comments||' ; '||s.comments 
					;
            END IF;
        END;
    END LOOP;
	COMMIT; 
END;
/

show errors 