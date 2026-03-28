CREATE OR REPLACE PACKAGE BODY parser_grammar_gen IS
--
    co_nl   CONSTANT VARCHAR2(2) :=CHR(10); 
--
    SUBTYPE type_vc2_100 IS VARCHAR2(100);
    --
    TYPE table_of_bool_index_by_vc2
    IS TABLE OF BOOLEAN  INDEX BY VARCHAR2(100)
    ;
    gv_method_called        table_of_bool_index_by_vc2;
    gv_method_implemented   table_of_bool_index_by_vc2;
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

    ----------------------------------------------------------------------
    -- Utility: clean symbol name for procedure name
    ----------------------------------------------------------------------
FUNCTION clean_name(p_name VARCHAR2) RETURN VARCHAR2 IS
        v_return    VARCHAR2(100);
    BEGIN 
         v_return := REPLACE(p_name,'-','_');

         RETURN regexp_substr ( v_return, '[_a-zA-Z0-9]+') ;
    END clean_name;
--
--
FUNCTION is_terminal(p_symbol VARCHAR2) RETURN BOOLEAN IS
   BEGIN
      -- convention: uppercase = terminal
      RETURN (p_symbol = UPPER(p_symbol));
   END;
--
--
    FUNCTION tokenize_rhs_raw (p_rhs VARCHAR2) RETURN SYS.ODCIVARCHAR2LIST 
    IS
        v_pos    PLS_INTEGER := 1;
        v_len    PLS_INTEGER := LENGTH(p_rhs);
        v_ch     CHAR(1);
        v_buf    VARCHAR2(200);
        v_return SYS.ODCIVARCHAR2LIST := sys.ODCIVARCHAR2LIST ();
    BEGIN
        v_buf := '';
        WHILE v_pos <= v_len LOOP
            v_ch := SUBSTR(p_rhs,v_pos,1);

            CASE 
                WHEN v_ch IN ( ' ', chr(10) ) THEN
                    IF v_buf IS NOT NULL THEN
                        v_return.EXTEND;
                        v_return(v_return.COUNT) := v_buf;
                        v_buf := '';
                    END IF;
                WHEN v_ch IN ( '{','}','[',']','|','(',')',';' ) THEN
                    IF v_buf IS NOT NULL THEN
                        v_return.EXTEND;
                        v_return(v_return.COUNT) := v_buf;
                        v_buf := '';
                    END IF;
                    v_return.EXTEND;
                    v_return(v_return.COUNT) := v_ch;
                ELSE
                    v_buf := v_buf || v_ch;
            END CASE;

            v_pos := v_pos + 1;
        END LOOP;

        IF v_buf IS NOT NULL THEN
            v_return.EXTEND;
            v_return(v_return.COUNT) := v_buf;
        END IF;

        RETURN v_return;
    END tokenize_rhs_raw; 

--
    FUNCTION tokenize_rhs_refined (p_rhs VARCHAR2) RETURN parser_rule_token_col 
    AS 
      v_return  parser_rule_token_col := parser_rule_token_col();
      v_tokens_raw SYS.ODCIVARCHAR2LIST := SYS.ODCIVARCHAR2LIST();
      v_ix  PLS_INTEGER := 1;
      v_tok          VARCHAR2(100);
      -- 
      FUNCTION look_ahead_raw ( p_offset PLS_INTEGER)
      RETURN VARCHAR2  
      AS 
      BEGIN 
         IF v_ix + p_offset <= v_tokens_raw.count THEN RETURN v_tokens_raw( v_ix + p_offset ); 
         END IF;
         --
         RETURN NULL;
      END look_ahead_raw;
      --
    BEGIN 
      v_tokens_raw := tokenize_rhs_raw( p_rhs );
      --
      WHILE v_ix <= v_tokens_raw.count 
      LOOP
         CASE
         WHEN  trim(v_tokens_raw ( v_ix ))   = '"'
           and trim(look_ahead_raw( 1 )  )       = ';'
           and trim(look_ahead_raw( 2 )  )       = '"'
         THEN 
            v_ix := v_ix + 3;
            v_return.extend;
            v_return( v_return.count ) :=
               parser_rule_token_rec( content => ';'
                              , type => 'TERMINAL'
                              );
         WHEN v_tokens_raw ( v_ix ) LIKE '<%>' 
         THEN 
            v_tok := v_tokens_raw ( v_ix );
            v_ix := v_ix + 1;
            v_return.extend;
            v_return( v_return.count ) :=
               parser_rule_token_rec( content => substr( v_tok, 2, length( v_tok ) - 2 )
                              , type => 'RULE'
                              );
         WHEN v_tokens_raw ( v_ix ) = '[' 
         THEN 
            v_tok := v_tokens_raw ( v_ix );
            v_ix := v_ix + 1;
            v_return.extend;
            v_return( v_return.count ) :=
               parser_rule_token_rec( content => v_tok
                              , type => 'OPTIONAL_START'
                              );
         WHEN v_tokens_raw ( v_ix ) = ']' 
         THEN 
            v_tok := v_tokens_raw ( v_ix );
            v_ix := v_ix + 1;
            v_return.extend;
            v_return( v_return.count ) :=
               parser_rule_token_rec( content => v_tok
                              , type => 'OPTIONAL_END'
                              );
         WHEN v_tokens_raw ( v_ix ) LIKE '"%"' 
         THEN 
            v_tok := v_tokens_raw ( v_ix );
            v_ix := v_ix + 1;
            v_return.extend;
            v_return( v_return.count ) :=
               parser_rule_token_rec( content => substr( v_tok, 2, length( v_tok ) - 2 )
                              , type => 'KEYWORD'
                              );
         WHEN v_tokens_raw ( v_ix ) LIKE '|' 
         THEN 
            v_tok := v_tokens_raw ( v_ix );
            v_ix := v_ix + 1;
            v_return.extend;
            v_return( v_return.count ) :=
               parser_rule_token_rec( content => v_tok 
                              , type => 'ALTERNATIVE'
                              );
         ELSE 
            v_tok := v_tokens_raw ( v_ix );
            v_ix := v_ix + 1;
            v_return.extend;
            v_return( v_return.count ) :=
               parser_rule_token_rec( content => v_tok
                              , type => 'OTHERS'
                              );
         END CAse;

      end LOOP;
      -- 
      RETURN v_return;
    END tokenize_rhs_refined;

-- 
FUNCTION get_parser_code_v2      -- sequence of procedures , does not  consider alternatives correctly
RETURN CLOB
IS
    co_state_initial      CONSTANT VARCHAR2( 10 ) := 'initial';
    CURSOR c_rules IS
        SELECT lhs, rhs FROM parser_grammar_rules ORDER BY lhs;

    v_lhs  parser_grammar_rules.lhs%TYPE;
    v_rhs  parser_grammar_rules.rhs%TYPE;
    v_proc_name     VARCHAR2(100);

    v_code CLOB := EMPTY_CLOB();  -- will hold all generated procedures

    ----------------------------------------------------------------------
    -- Append a line to the CLOB
    ----------------------------------------------------------------------
    PROCEDURE append_line(p_line VARCHAR2) IS
        v_proc_name type_vc2_100;
    BEGIN
        IF p_line IS NOT NULL   -- as long as we have not figured out while there are empty tokenw 
        THEN
            v_code := v_code 
            -- still not figured out while the toke triples " ; " have not been all detected
            -- so if they occur replace them 
             ||  p_line 
             || CHR(10);
            IF regexp_like ( p_line, '^(xparse_[_a-zA-Z0-9]+)(;)$' )
            THEN  
                v_proc_name := substr( p_line, 1, length( p_line) -1 );
                gv_method_called ( v_proc_name ) := true;
            END IF;
        END IF;
    END;

    ----------------------------------------------------------------------
    -- Convert RHS into PL/SQL parse code recursively
    ----------------------------------------------------------------------
    PROCEDURE rhs_to_code(p_rhs VARCHAR2) IS
        v_tokens_refined parser_rule_token_col; 
-- v_return
        v_i      PLS_INTEGER := 1;
        -- 
        PROCEDURE parse_token
        AS 
        BEGIN
            IF v_i > v_tokens_refined.COUNT THEN
                RETURN;
            END IF;

            DECLARE
                v_tok_rec parser_rule_token_rec := v_tokens_refined (v_i);
            BEGIN
                CASE 
                  WHEN v_tok_rec.content =  '{' 
                  THEN
                        append_line('   -- repetition start');
                        append_line('   WHILE next_rule_token IN (...symbols...) LOOP');
                        v_i := v_i + 1;
                        WHILE v_i <= v_tokens_refined.COUNT AND v_tokens_refined(v_i).content != '}' LOOP
                            parse_token;
                        END LOOP;
                        append_line('   END LOOP; -- end repetition');
                        v_i := v_i + 1;
                  WHEN v_tok_rec.content = '[' 
                  THEN
                        append_line('   -- optional start');
                        append_line('   IF next_rule_token IN (...symbols...) THEN');
                        v_i := v_i + 1;
                        WHILE v_i <= v_tokens_refined.COUNT AND v_tokens_refined (v_i).content != ']' LOOP
                            parse_token;
                        END LOOP;
                        append_line('   END IF; -- end optional');
                        v_i := v_i + 1;
                  WHEN v_tok_rec.content = '|' 
                  THEN
                        -- alternatives handled at parent level
                        v_i := v_i + 1;
                  ELSE
dbms_output.put_line ( 'Ln'||$$plsql_line||' v_tok_rec.content: ' ||v_tok_rec.content) ;       
                        append_line('   parse_'||clean_name(v_tok_rec.content)||';');
                        v_i := v_i + 1;
                END CASE;
            END;
        END parse_token;

    BEGIN
        v_tokens_refined := tokenize_rhs_refined(p_rhs);
        WHILE v_i <= v_tokens_refined.COUNT LOOP
            parse_token;
        END LOOP;
    END rhs_to_code;

BEGIN
    FOR r IN c_rules LOOP
        v_lhs := clean_name(r.lhs);
        v_rhs := r.rhs;
        v_proc_name := LOWER( 'parse_'||v_lhs );
        gv_method_implemented( v_proc_name ) := TRUE;
        append_line('PROCEDURE '||v_proc_name||' IS');
        append_line('BEGIN');

        rhs_to_code(v_rhs);

        append_line('END '||v_proc_name||';');
        append_line('--');
    END LOOP;

    RETURN v_code;
 END get_parser_code_v2;
--
FUNCTION get_package_helpers 
RETURN CLOB 
IS
    v_return                CLOB;
    co_next_rule_token_template CONSTANT LONG :=
Q'[--
FUNCTIN next_rule_token 
RETURN VARCHAR2 
AS 
BEGIN 
    RETURN <rule_token_collection>( <rule_token_index> ).context ;
END next_rule_token;  
--
]';
BEGIN 
    RETURN v_return;
END get_package_helpers;
--
--
FUNCTION get_parser_package_code (
    p_package_name  IN  VARCHAR2 
)
RETURN CLOB 
IS
    v_return                CLOB;
    v_proc_implentations    CLOB;
    v_spec                  CLOB;
    v_body                  CLOB;
BEGIN 

    -- the body 
    v_proc_implentations := get_parser_code_v2;
    v_body := 
q'{
CREATE OR REPLACE BODY <package_name>
AS
}' 
    || get_package_helpers  
    || v_proc_implentations
    || co_nl 
    ||'END;'
    ||';'
    ||'/'
    ;
    v_return := 
          v_spec 
        ||v_body 
        ;
    FOR rec_repl IN (
        SELECT 'xx' text_from,  'yy' text_to FROM dual WHERE 1=0
        UNION ALL SELECT '<package_name>',          p_package_name      FROM dual
        UNION ALL SELECT '<rule_token_collection>', 'gv_rule_tokens'    FROM dual 
    ) LOOP   
        v_return := replace ( v_return, rec_repl.text_from, rec_repl.text_to );
    END LOOP ;
    --
    RETURN v_return;
END get_parser_package_code;

END; -- package 
/