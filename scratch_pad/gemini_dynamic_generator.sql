CREATE OR REPLACE FUNCTION generate_parser_proc RETURN CLOB IS
    v_clob        CLOB;
    v_line        VARCHAR2(32767);
    v_prev_lhs    VARCHAR2(30) := '~FIRST~';
    v_prev_alt    NUMBER(2)    := -1;
    
    -- Cursor grabs layout sequenced strictly by Rule, Alt Number, and Position
    CURSOR c_rules IS
        SELECT lhs, alt_no, position, symbol
          FROM parser_rule_alt_tokens
         ORDER BY lhs, alt_no, position;
BEGIN
    -- Initialize the CLOB
    DBMS_LOB.CREATEMB_LOB(v_clob);
    DBMS_LOB.OPEN(v_clob, DBMS_LOB.LOB_READWRITE);

    -- Append Global Header and Helper Definitions
    v_line := '/* AUTOMATICALLY GENERATED LINEAR PARSER CODE */' || CHR(10) ||
              'PACKAGE BODY dynamic_parser IS' || CHR(10) || CHR(10) ||
              '    -- Global parser state tracking' || CHR(10) ||
              '    g_ptr  PLS_INTEGER := 1;' || CHR(10) || CHR(10) ||
              '    -- Core matching tool' || CHR(10) ||
              '    PROCEDURE match(p_expected VARCHAR2) IS' || CHR(10) ||
              '    BEGIN' || CHR(10) ||
              '        IF g_ptr <= g_tokens.COUNT AND g_tokens(g_ptr) = p_expected THEN' || CHR(10) ||
              '            g_ptr := g_ptr + 1;' || CHR(10) ||
              '        ELSE' || CHR(10) ||
              '            RAISE_APPLICATION_ERROR(-20002, ''Token mismatch. Expected: '' || p_expected);' || CHR(10) ||
              '        END IF;' || CHR(10) ||
              '    END match;' || CHR(10) || CHR(10);
    DBMS_LOB.WRITEAPPEND(v_clob, LENGTH(v_line), v_line);

    FOR r IN c_rules LOOP
        
        -- Detect transition to a new Alternative Procedure
        IF r.lhs != v_prev_lhs OR r.alt_no != v_prev_alt THEN
            
            -- Close out the previous subprocedure if it's not the initial loop iteration
            IF v_prev_lhs != '~FIRST~' THEN
                v_line := '    EXCEPTION' || CHR(10) ||
                          '        WHEN OTHERS THEN' || CHR(10) ||
                          '            g_ptr := v_start_ptr; -- Rollback token pointer state' || CHR(10) ||
                          '            RAISE;' || CHR(10) ||
                          '    END parse_' || v_prev_lhs || '_' || v_prev_alt || ';' || CHR(10) || CHR(10);
                DBMS_LOB.WRITEAPPEND(v_clob, LENGTH(v_line), v_line);
            END IF;
            
            -- Start a brand new, clean subprocedure dedicated to LHS + ALT_NO
            v_line := '    PROCEDURE parse_' || r.lhs || '_' || r.alt_no || ' IS' || CHR(10) ||
                      '        v_start_ptr PLS_INTEGER := g_ptr;' || CHR(10) ||
                      '    BEGIN' || CHR(10);
            DBMS_LOB.WRITEAPPEND(v_clob, LENGTH(v_line), v_line);
            
            v_prev_lhs := r.lhs;
            v_prev_alt := r.alt_no;
        END IF;

        -- Write the matching instruction step for this token position
        -- If upper-case, treat as terminal token string literal; otherwise, treat as subprogram rule dispatch
        IF r.symbol = UPPER(r.symbol) AND r.symbol != LOWER(r.symbol) THEN
            v_line := '        match(''' || r.symbol || ''');' || CHR(10);
        ELSE
            -- Note: For composite sub-rules, you would wrap calls in try/catch or call their master coordinator rule
            v_line := '        parse_' || r.symbol || '_1;' || CHR(10); 
        END IF;
        DBMS_LOB.WRITEAPPEND(v_clob, LENGTH(v_line), v_line);

    END LOOP;

    -- Clean wrap up of the final trailing procedure inside the cursor buffer
    IF v_prev_lhs != '~FIRST~' THEN
        v_line := '    EXCEPTION' || CHR(10) ||
                  '        WHEN OTHERS THEN' || CHR(10) ||
                  '            g_ptr := v_start_ptr;' || CHR(10) ||
                  '            RAISE;' || CHR(10) ||
                  '    END parse_' || v_prev_lhs || '_' || v_prev_alt || ';' || CHR(10) || CHR(10);
        DBMS_LOB.WRITEAPPEND(v_clob, LENGTH(v_line), v_line);
    END IF;

    v_line := 'END dynamic_parser;';
    DBMS_LOB.WRITEAPPEND(v_clob, LENGTH(v_line), v_line);

    RETURN v_clob;
END;
/

/* examplary AUTOMATICALLY GENERATED LINEAR PARSER CODE 
PACKAGE BODY dynamic_parser IS

    g_ptr  PLS_INTEGER := 1;

    PROCEDURE match(p_expected VARCHAR2) IS ...

    PROCEDURE parse_expr_1 IS
        v_start_ptr PLS_INTEGER := g_ptr;
    BEGIN
        match('ID');
        match('=');
        match('NUMBER');
    EXCEPTION
        WHEN OTHERS THEN
            g_ptr := v_start_ptr; -- Reset position back to original state on failure
            RAISE;
    END parse_expr_1;

    PROCEDURE parse_expr_2 IS
        v_start_ptr PLS_INTEGER := g_ptr;
    BEGIN
        match('ID');
        match('+');
        match('ID');
    EXCEPTION
        WHEN OTHERS THEN
            g_ptr := v_start_ptr; -- Reset position back to original state on failure
            RAISE;
    END parse_expr_2;

END dynamic_parser;
*/
