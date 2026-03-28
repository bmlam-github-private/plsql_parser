CREATE OR REPLACE FUNCTION bnf_to_insert_stmts (p_bnf CLOB)
RETURN CLOB
IS
    v_sql        CLOB := EMPTY_CLOB();

    v_start_pos  PLS_INTEGER := 1;
    v_lhs_pos    PLS_INTEGER;
    v_next_pos   PLS_INTEGER;

    v_lhs        VARCHAR2(200);
    v_rhs        CLOB;

    ------------------------------------------------------------------
    -- escape quotes
    ------------------------------------------------------------------
    FUNCTION esc(p_text CLOB) RETURN CLOB IS
    BEGIN
        RETURN REPLACE(p_text, '''', '''''');
    END;

BEGIN
    LOOP
        ------------------------------------------------------------------
        -- find next <lhs> ::=
        ------------------------------------------------------------------
        v_lhs_pos := REGEXP_INSTR(
                        p_bnf,
                        '<[^>]+>\s*::=',
                        v_start_pos
                     );

        EXIT WHEN v_lhs_pos = 0;

        ------------------------------------------------------------------
        -- extract LHS
        ------------------------------------------------------------------
        v_lhs := REGEXP_SUBSTR(
                    p_bnf,
                    '<[^>]+>',
                    v_lhs_pos
                 );

        ------------------------------------------------------------------
        -- find start of RHS (position after ::=)
        ------------------------------------------------------------------
        DECLARE
            v_rhs_start PLS_INTEGER;
        BEGIN
            v_rhs_start := REGEXP_INSTR(
                              p_bnf,
                              '::=',
                              v_lhs_pos
                           ) + 3;

            ------------------------------------------------------------------
            -- find next <lhs> ::= (forward scan)
            ------------------------------------------------------------------
            v_next_pos := REGEXP_INSTR(
                              p_bnf,
                              '<[^>]+>\s*::=',
                              v_rhs_start
                          );

            ------------------------------------------------------------------
            -- extract RHS using SUBSTR (no regex!)
            ------------------------------------------------------------------
            IF v_next_pos = 0 THEN
                v_rhs := DBMS_LOB.SUBSTR(
                            p_bnf,
                            DBMS_LOB.GETLENGTH(p_bnf) - v_rhs_start + 1,
                            v_rhs_start
                         );
                v_start_pos := DBMS_LOB.GETLENGTH(p_bnf) + 1;
            ELSE
                v_rhs := DBMS_LOB.SUBSTR(
                            p_bnf,
                            v_next_pos - v_rhs_start,
                            v_rhs_start
                         );
                v_start_pos := v_next_pos;
            END IF;

            ------------------------------------------------------------------
            -- normalize whitespace
            ------------------------------------------------------------------
            v_rhs := REGEXP_REPLACE(v_rhs, '\s+', ' ');

            ------------------------------------------------------------------
            -- emit INSERT
            ------------------------------------------------------------------
            v_sql := v_sql ||
                'INSERT INTO grammar_rules(lhs, rhs) VALUES (' ||
                '''' || esc(v_lhs) || ''', ' ||
                '''' || esc(TRIM(v_rhs)) || '''' ||
                ');' || CHR(10);

        END;
    END LOOP;

    RETURN v_sql;
END;
/