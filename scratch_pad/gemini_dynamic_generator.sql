CREATE OR REPLACE FUNCTION generate_parser_package 
	(p_source		IN VARCHAR2 
	,p_package_name IN VARCHAR2 DEFAULT 'PKG_DYNAMIC_PARSER'
) RETURN CLOB IS
    l_clob        CLOB;
    l_spec        CLOB;
    l_body        CLOB;
    
    -- Cursor for unique LHS rules (Type 1)
    CURSOR c_rules IS
        SELECT DISTINCT lhs 
        FROM parser_alt_token 
        ORDER BY lhs;
        
    -- Cursor for alternatives of a specific LHS (Type 2)
    CURSOR c_alts(cp_lhs VARCHAR2) IS
        SELECT DISTINCT alt_no 
        FROM parser_alt_token 
        WHERE lhs = cp_lhs 
        ORDER BY alt_no;
        
    -- Cursor for symbols within a specific alternative
    CURSOR c_symbols(cp_lhs VARCHAR2, cp_alt_no NUMBER) IS
        SELECT position, symbol 
        FROM parser_alt_token 
        WHERE lhs = cp_lhs AND alt_no = cp_alt_no 
        ORDER BY position;

    -- Cursor to find distinct terminal symbols vs LHS rules
    TYPE t_lhs_list IS TABLE OF VARCHAR2(30);
    l_all_lhs NUMBER;
    
    PROCEDURE append_to_clob(p_target IN OUT NOCOPY CLOB, p_text IN VARCHAR2) IS
    BEGIN
        DBMS_LOB.WRITEAPPEND(p_target, LENGTH(p_text), p_text);
    END append_to_clob;

BEGIN
    -- Initialize CLOBs
    DBMS_LOB.CREATETEMPORARY(l_spec, TRUE);
    DBMS_LOB.CREATETEMPORARY(l_body, TRUE);
    DBMS_LOB.CREATETEMPORARY(l_clob, TRUE);

    -- 1. BUILD PACKAGE SPECIFICATION HEADERS
    append_to_clob(l_spec, 'CREATE OR REPLACE PACKAGE ' || p_package_name || ' AS' || CHR(10));
    append_to_clob(l_spec, '  -- Global collection type for tokens' || CHR(10));
    append_to_clob(l_spec, '  TYPE t_token_list IS TABLE OF parser_token_rec;' || CHR(10)|| CHR(10));
    append_to_clob(l_spec, '  g_tokens         t_token_list;' || CHR(10));
    append_to_clob(l_spec, '  g_curr_token_ix  NUMBER := 1;' || CHR(10) || CHR(10));

    -- 2. BUILD PACKAGE BODY HEADERS
    append_to_clob(l_body, 'CREATE OR REPLACE PACKAGE BODY ' || p_package_name || ' AS' || CHR(10) || CHR(10));
    
    -- Forward declarations in Body for Type 2 rules (Alts) to allow arbitrary order recursion
    FOR r IN c_rules LOOP
        FOR a IN c_alts(r.lhs) LOOP
            append_to_clob(l_body, '  PROCEDURE ' || r.lhs || '_' || a.alt_no || '(po_success OUT BOOLEAN);' || CHR(10));
        END LOOP;
    END LOOP;
    append_to_clob(l_body, CHR(10));

    -- 3. GENERATE SUBPROGRAMS (Type 1 and Type 2)
    FOR r IN c_rules LOOP
        -- Add Type 1 (LHS master rule) to Specification
        append_to_clob(l_spec, '  PROCEDURE ' || r.lhs || '(po_success OUT BOOLEAN);' || CHR(10));

        -- Add Type 1 (LHS master rule) to Body
        append_to_clob(l_body, '  PROCEDURE ' || r.lhs || '(po_success OUT BOOLEAN) IS' || CHR(10));
        append_to_clob(l_body, '    l_entry_idx NUMBER := g_curr_token_ix;' || CHR(10));
        append_to_clob(l_body, '  BEGIN' || CHR(10));
        append_to_clob(l_body, '    po_success := FALSE;' || CHR(10));
        
        -- Loop through alternatives inside Type 1
        FOR a IN c_alts(r.lhs) LOOP
            append_to_clob(l_body, '    IF NOT po_success THEN' || CHR(10));
            append_to_clob(l_body, '      ' || r.lhs || '_' || a.alt_no || '(po_success);' || CHR(10));
            append_to_clob(l_body, '      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;' || CHR(10));
            append_to_clob(l_body, '    END IF;' || CHR(10));
        END LOOP;
        append_to_clob(l_body, '  END ' || r.lhs || ';' || CHR(10) || CHR(10));

        -- Add Type 2 (Alternative rules) to Body
        FOR a IN c_alts(r.lhs) LOOP
            append_to_clob(l_body, '  PROCEDURE ' || r.lhs || '_' || a.alt_no || '(po_success OUT BOOLEAN) IS' || CHR(10));
            append_to_clob(l_body, '    l_entry_idx NUMBER := g_curr_token_ix;' || CHR(10));
            append_to_clob(l_body, '  BEGIN' || CHR(10));
            append_to_clob(l_body, '    po_success := TRUE;' || CHR(10));
            
            -- Process sequence symbols inside Alternative
            FOR s IN c_symbols(r.lhs, a.alt_no) LOOP
                append_to_clob(l_body, '    -- Position ' || s.position || ': Symbol ' || s.symbol || CHR(10));
                append_to_clob(l_body, '    IF po_success THEN' || CHR(10));
                
                -- Check if symbol is another LHS rule (Non-Terminal)
                SELECT COUNT(*) 
				INTO l_all_lhs 
				FROM (
					SELECT DISTINCT lhs FROM parser_alt_token )
					WHERE lhs = s.symbol 
					;
                
                IF l_all_lhs > 0 THEN
                    -- Call sub-rule
                    append_to_clob(l_body, '      ' || s.symbol || '(po_success);' || CHR(10));
                ELSE
                    -- Terminal Token validation match
                    append_to_clob(l_body, '      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = ''' || s.symbol || ''' THEN' || CHR(10));
                    append_to_clob(l_body, '        g_curr_token_ix := g_curr_token_ix + 1;' || CHR(10));
                    append_to_clob(l_body, '      ELSE' || CHR(10));
                    append_to_clob(l_body, '        po_success := FALSE;' || CHR(10));
                    append_to_clob(l_body, '      END IF;' || CHR(10));
                END IF;
                append_to_clob(l_body, '    END IF;' || CHR(10));
            END LOOP;
            
            -- Backtrack if alternative sequence failed midway
            append_to_clob(l_body, '    IF NOT po_success THEN' || CHR(10));
            append_to_clob(l_body, '      g_curr_token_ix := l_entry_idx;' || CHR(10));
            append_to_clob(l_body, '    END IF;' || CHR(10));
            append_to_clob(l_body, '  END ' || r.lhs || '_' || a.alt_no || ';' || CHR(10) || CHR(10));
        END LOOP;
    END LOOP;

    -- 4. BONUS: DETERMINE TOP-LEVEL RULES & GENERATE MAIN SUBPROGRAM
    append_to_clob(l_spec, CHR(10) || '  -- Main entry point for top-level parsing rules' || CHR(10));
    append_to_clob(l_spec, '  PROCEDURE parse_main(p_token_stream IN t_token_list, po_success OUT BOOLEAN);' || CHR(10));
    
    append_to_clob(l_body, '  PROCEDURE parse_main(p_token_stream IN t_token_list, po_success OUT BOOLEAN) IS' || CHR(10));
    append_to_clob(l_body, '  BEGIN' || CHR(10));
    append_to_clob(l_body, '    g_tokens := p_token_stream;' || CHR(10));
    append_to_clob(l_body, '    g_curr_token_ix := 1;' || CHR(10));
    append_to_clob(l_body, '    po_success := FALSE;' || CHR(10) || CHR(10));
    
    -- Identify top level rules using an anti-join query
    FOR top_rule IN (
        SELECT DISTINCT lhs 
        FROM parser_alt_token
        WHERE lhs NOT IN (
            SELECT DISTINCT symbol 
            FROM parser_alt_token 
            WHERE symbol IS NOT NULL
        )
        ORDER BY lhs
    ) LOOP
        append_to_clob(l_body, '    IF NOT po_success THEN' || CHR(10));
        append_to_clob(l_body, '      g_curr_token_ix := 1; -- Reset stream index for next entry option' || CHR(10));
        append_to_clob(l_body, '      ' || top_rule.lhs || '(po_success);' || CHR(10));
        append_to_clob(l_body, '    END IF;' || CHR(10));
    END LOOP;
    
    append_to_clob(l_body, '  END parse_main;' || CHR(10) || CHR(10));

    -- 5. CLOSE OUT STRINGS
    append_to_clob(l_spec, 'END ' || p_package_name || ';');
    append_to_clob(l_body, 'END ' || p_package_name || ';');

    -- Combine into final CLOB
    DBMS_LOB.APPEND(l_clob, l_spec);
    DBMS_LOB.WRITEAPPEND(l_clob, 2, CHR(10) || CHR(10));
    DBMS_LOB.APPEND(l_clob, l_body);

    RETURN l_clob;
END;
/
