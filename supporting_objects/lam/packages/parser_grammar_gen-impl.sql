CREATE OR REPLACE PACKAGE BODY parser_grammar_generator IS

   FUNCTION is_terminal(p_symbol VARCHAR2) RETURN BOOLEAN IS
   BEGIN
      -- convention: uppercase = terminal
      RETURN (p_symbol = UPPER(p_symbol));
   END;

   FUNCTION normalize_name(p_name VARCHAR2) RETURN VARCHAR2 IS
   BEGIN
      RETURN LOWER(REPLACE(p_name, ' ', '_'));
   END;

   PROCEDURE generate_parser(p_package_name VARCHAR2) IS

      v_spec   CLOB := '';
      v_body   CLOB := '';

   BEGIN
      -- ======================
      -- PACKAGE SPEC
      -- ======================
      v_spec := 'CREATE OR REPLACE PACKAGE ' || p_package_name || ' IS' || CHR(10);

      FOR r IN (SELECT DISTINCT lhs FROM grammar_rules) LOOP
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
         FROM grammar_rules
         ORDER BY lhs
      ) LOOP

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
      DBMS_OUTPUT.PUT_LINE(v_spec);
      DBMS_OUTPUT.PUT_LINE(v_body);

   END generate_parser;

END;
/