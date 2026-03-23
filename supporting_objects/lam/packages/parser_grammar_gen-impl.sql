CREATE OR REPLACE PACKAGE BODY parser_grammar_gen IS

--
    gv_count_down NUMBER := 10000;
--
PROCEDURE check_loop  
AS 
BEGIN 
   gv_count_down := gv_count_down - 1;
   IF gv_count_down < 0 
   THEN 
      RAISE_APPLICATION_ERROR( -20001, 'loop checked!');
   END IF;
end check_loop;

   FUNCTION is_terminal(p_symbol VARCHAR2) RETURN BOOLEAN IS
   BEGIN
      -- convention: uppercase = terminal
      RETURN (p_symbol = UPPER(p_symbol));
   END;

   FUNCTION normalize_name(p_name VARCHAR2) RETURN VARCHAR2 IS
   BEGIN
      RETURN LOWER(REPLACE(p_name, ' ', '_'));
   END;
--
--
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
-- 
FUNCTION get_parser_code_v2      -- sequence of procedures , does not  consider alternatives correctly
RETURN CLOB
IS
    CURSOR c_rules IS
        SELECT lhs, rhs FROM parser_grammar_rules ORDER BY lhs;

    v_lhs  parser_grammar_rules.lhs%TYPE;
    v_rhs  parser_grammar_rules.rhs%TYPE;

    v_code CLOB := EMPTY_CLOB();  -- will hold all generated procedures

    ----------------------------------------------------------------------
    -- Utility: clean symbol name for procedure name
    ----------------------------------------------------------------------
    FUNCTION clean_name(p_name VARCHAR2) RETURN VARCHAR2 IS
    BEGIN
        RETURN REPLACE(p_name,'-','_');
    END;

    ----------------------------------------------------------------------
    -- Append a line to the CLOB
    ----------------------------------------------------------------------
    PROCEDURE append_line(p_line VARCHAR2) IS
    BEGIN
        v_code := v_code || p_line || CHR(10);
    END;

    ----------------------------------------------------------------------
    -- Tokenize the RHS ignoring human-readable whitespace
    ----------------------------------------------------------------------
    FUNCTION tokenize_rhs(p_rhs VARCHAR2) RETURN SYS.ODCIVARCHAR2LIST IS
        v_tokens SYS.ODCIVARCHAR2LIST := SYS.ODCIVARCHAR2LIST();
        v_tok    VARCHAR2(200);
        v_pos    PLS_INTEGER := 1;
        v_len    PLS_INTEGER := LENGTH(p_rhs);
        v_ch     CHAR(1);
        v_buf    VARCHAR2(200);
    BEGIN
        v_buf := '';
        WHILE v_pos <= v_len LOOP
            v_ch := SUBSTR(p_rhs,v_pos,1);

            CASE 
                WHEN v_ch = ' ' THEN
                    IF v_buf IS NOT NULL THEN
                        v_tokens.EXTEND;
                        v_tokens(v_tokens.COUNT) := v_buf;
                        v_buf := '';
                    END IF;
                WHEN v_ch IN ( '{','}','[',']','|','(',')',';' ) THEN
                    IF v_buf IS NOT NULL THEN
                        v_tokens.EXTEND;
                        v_tokens(v_tokens.COUNT) := v_buf;
                        v_buf := '';
                    END IF;
                    v_tokens.EXTEND;
                    v_tokens(v_tokens.COUNT) := v_ch;
                ELSE
                    v_buf := v_buf || v_ch;
            END CASE;

            v_pos := v_pos + 1;
        END LOOP;

        IF v_buf IS NOT NULL THEN
            v_tokens.EXTEND;
            v_tokens(v_tokens.COUNT) := v_buf;
        END IF;

        RETURN v_tokens;
    END;

    ----------------------------------------------------------------------
    -- Convert RHS into PL/SQL parse code recursively
    ----------------------------------------------------------------------
    PROCEDURE rhs_to_code(p_rhs VARCHAR2) IS
        v_tokens SYS.ODCIVARCHAR2LIST := tokenize_rhs(p_rhs);
        v_i      PLS_INTEGER := 1;

        PROCEDURE parse_token
        AS 
        BEGIN
            IF v_i > v_tokens.COUNT THEN
                RETURN;
            END IF;

            DECLARE
                v_tok VARCHAR2(200) := v_tokens(v_i);
            BEGIN
                CASE v_tok
                    WHEN '{' THEN
                        append_line('   -- repetition start');
                        append_line('   WHILE lookahead IN (...symbols...) LOOP');
                        v_i := v_i + 1;
                        WHILE v_i <= v_tokens.COUNT AND v_tokens(v_i) != '}' LOOP
                            parse_token;
                        END LOOP;
                        append_line('   END LOOP; -- end repetition');
                        v_i := v_i + 1;
                    WHEN '[' THEN
                        append_line('   -- optional start');
                        append_line('   IF lookahead IN (...symbols...) THEN');
                        v_i := v_i + 1;
                        WHILE v_i <= v_tokens.COUNT AND v_tokens(v_i) != ']' LOOP
                            parse_token;
                        END LOOP;
                        append_line('   END IF; -- end optional');
                        v_i := v_i + 1;
                    WHEN '|' THEN
                        -- alternatives handled at parent level
                        v_i := v_i + 1;
                    ELSE
                        append_line('   parse_'||clean_name(v_tok)||';');
                        v_i := v_i + 1;
                END CASE;
            END;
        END parse_token;

    BEGIN
        WHILE v_i <= v_tokens.COUNT LOOP
            parse_token;
        END LOOP;
    END;

BEGIN
    FOR r IN c_rules LOOP
        v_lhs := clean_name(r.lhs);
        v_rhs := r.rhs;

        append_line('PROCEDURE parse_'||v_lhs||' IS');
        append_line('BEGIN');

        rhs_to_code(v_rhs);

        append_line('END parse_'||v_lhs||';');
        append_line('');
    END LOOP;

    RETURN v_code;
 END get_parser_code_v2;
--

END; -- package 
/