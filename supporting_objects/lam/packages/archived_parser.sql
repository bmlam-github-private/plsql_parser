PROCEDURE compute_first_sets
IS
    v_changed BOOLEAN := TRUE;
BEGIN
    DELETE FROM parser_first_sets;

    -- initialize: terminals map to themselves
    FOR t IN (
        SELECT DISTINCT REGEXP_SUBSTR(rhs, '"[^"]+"') AS token
        FROM parser_grammar_rules
        CONNECT BY REGEXP_SUBSTR(rhs, '"[^"]+"', 1, LEVEL) IS NOT NULL
    )
    LOOP
      check_loop;
        INSERT INTO parser_first_sets(symbol, token)
        VALUES (t.token, t.token);
    END LOOP;

    -- iterate until no change
    WHILE v_changed LOOP
      check_loop;
        v_changed := FALSE;

        FOR r IN (SELECT lhs, rhs FROM parser_grammar_rules)
        LOOP
        check_loop;
            DECLARE
                v_first VARCHAR2(100);
            BEGIN
                -- first symbol in RHS
                v_first := REGEXP_SUBSTR(r.rhs, '^\s*("[^"]+"|\S+)');

                FOR f IN (
                    SELECT token FROM parser_first_sets WHERE symbol = v_first
                )
                LOOP
      check_loop;
                    BEGIN
                        INSERT INTO parser_first_sets(symbol, token)
                        VALUES (r.lhs, f.token);
                        v_changed := TRUE;
                    EXCEPTION
                        WHEN DUP_VAL_ON_INDEX THEN NULL;
                    END;
                END LOOP;
            END;
        END LOOP;
    END LOOP;
END compute_first_sets;
--
FUNCTION first_condition(p_rhs VARCHAR2) RETURN VARCHAR2
IS
    v_first VARCHAR2(100);
    v_list  VARCHAR2(4000);
BEGIN
    v_first := REGEXP_SUBSTR(p_rhs, '^\s*("[^"]+"|\S+)');

    FOR f IN (
        SELECT token FROM parser_first_sets WHERE symbol = v_first
    )
    LOOP
      check_loop;
        v_list := v_list || ',' || f.token;
    END LOOP;

    RETURN '(' || LTRIM(v_list, ',') || ')';
END first_condition;
--
FUNCTION get_parser_code_v3 -- worst than _v2 !  
RETURN CLOB 
IS
   pragma autonomous_transaction;
   -- 
    v_code CLOB := EMPTY_CLOB();

    PROCEDURE append_line(p_line VARCHAR2) IS
    BEGIN
        v_code := v_code || p_line || CHR(10);
    END;

    FUNCTION clean_name(p_name VARCHAR2) RETURN VARCHAR2 IS
    BEGIN
        RETURN REPLACE(REPLACE(p_name,'"',''),'<','');
    END;

    ------------------------------------------------------------------
    -- generate RHS body (same as before)
    ------------------------------------------------------------------
    PROCEDURE rhs_to_code(p_rhs VARCHAR2) IS
    BEGIN
        -- simplified: reuse previous version
        append_line('   -- parse '||p_rhs);
    END;

BEGIN
    -- compute FIRST sets first
    compute_first_sets;

    ------------------------------------------------------------------
    -- generate procedures
    ------------------------------------------------------------------
    FOR nt IN (
        SELECT lhs FROM parser_grammar_rules GROUP BY lhs
    )
    LOOP
        append_line('PROCEDURE parse_'||clean_name(nt.lhs)||' IS');
        append_line('BEGIN');

        DECLARE
            v_count NUMBER;
        BEGIN
            SELECT COUNT(*) INTO v_count
            FROM parser_grammar_rules WHERE lhs = nt.lhs;

            IF v_count > 1 THEN
                append_line('   CASE');

                FOR r IN (
                    SELECT rhs FROM parser_grammar_rules WHERE lhs = nt.lhs
                )
                LOOP
      check_loop;
                    append_line(
                        '      WHEN lookahead IN ' ||
                        first_condition(r.rhs) || ' THEN'
                    );

                    rhs_to_code(r.rhs);
                END LOOP;

                append_line('      ELSE raise_syntax_error;');
                append_line('   END CASE;');

            ELSE
                FOR r IN (
                    SELECT rhs FROM parser_grammar_rules WHERE lhs = nt.lhs
                )
                LOOP
      check_loop;
                    rhs_to_code(r.rhs);
                END LOOP;
            END IF;
        END;

        append_line('END parse_'||clean_name(nt.lhs)||';');
        append_line('');
    END LOOP;
    commit; 
    RETURN v_code;
END get_parser_code_v3 ;
--
--
-- 
   FUNCTION get_parser_code_v1 -- packaged, but not supporting repitition and alternatives
      (p_package_name   VARCHAR2
      ,p_type           VARCHAR2 DEFAULT 'ALL'
      ) 
   RETURN CLOB 
      IS
      v_return CLOB :='';
      v_spec   CLOB := '';
      v_body   CLOB := '';

   BEGIN
      IF lower( p_type) NOT IN ('def','impl','all')
      THEN 
         RAISE_APPLICATION_ERROR( -20001, 'pi_type invalid!');
      END IF;
      -- ======================
      -- PACKAGE SPEC
      -- ======================
      v_spec := 'CREATE OR REPLACE PACKAGE ' || p_package_name || ' IS' || CHR(10);

      FOR r IN (
            SELECT DISTINCT lhs 
            FROM parser_grammar_rules
      ) LOOP
         v_spec := v_spec ||
            '  PROCEDURE parse_' || normalize_name(r.lhs) || ';' || CHR(10);
      END LOOP;

      v_spec := v_spec || 'END;' || CHR(10) || '/';

      -- ======================
      -- PACKAGE BODY
      -- ======================
      v_body := 'CREATE OR REPLACE PACKAGE BODY ' || p_package_name || ' IS' || CHR(10);

      -- helper stubs
      v_body := v_body || '
   PROCEDURE match(p_token VARCHAR2) IS
   BEGIN
      NULL; -- implement token check
   END;

   PROCEDURE match_identifier IS
   BEGIN
      NULL;
   END;

   FUNCTION next_token RETURN VARCHAR2 IS
   BEGIN
      RETURN NULL;
   END;
';

      -- ======================
      -- GENERATE PROCEDURES
      -- ======================
      FOR r IN (
         SELECT lhs, rhs
         FROM parser_grammar_rules
         ORDER BY lhs
      ) LOOP
      check_loop;

         DECLARE
            v_proc_name VARCHAR2(200);
            v_line      VARCHAR2(4000);
         BEGIN
            v_proc_name := 'parse_' || normalize_name(r.lhs);

            v_body := v_body ||
               CHR(10) || '  PROCEDURE ' || v_proc_name || ' IS' || CHR(10) ||
               '  BEGIN' || CHR(10);

            -- split RHS tokens
            FOR token IN (
               SELECT REGEXP_SUBSTR(r.rhs, '[^ ]+', 1, LEVEL) AS sym
               FROM dual
               CONNECT BY REGEXP_SUBSTR(r.rhs, '[^ ]+', 1, LEVEL) IS NOT NULL
            ) LOOP
      check_loop;

               IF is_terminal(token.sym) THEN

                  IF token.sym = 'IDENTIFIER' THEN
                     v_line := '    match_identifier;';
                  ELSE
                     v_line := '    match(''' || token.sym || ''');';
                  END IF;

               ELSE
                  v_line := '    parse_' || normalize_name(token.sym) || ';';
               END IF;

               v_body := v_body || v_line || CHR(10);

            END LOOP;

            v_body := v_body ||
               '  END;' || CHR(10);

         END;

      END LOOP;

      v_body := v_body || 'END;' || CHR(10) || '/';

      -- ======================
      -- OUTPUT
      -- ======================
      CASE lower(p_type)
      WHEN 'def' THEN 
         v_return := v_spec;
      WHEN 'impl' THEN 
         v_return := v_body;
      ELSE 
         v_return := v_spec || chr(10) || v_body;
      END CASE;

      RETURN v_return;
   END get_parser_code_v1;
