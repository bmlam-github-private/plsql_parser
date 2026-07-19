CREATE OR REPLACE PACKAGE BODY parser_grammar_gen IS
--
  co_nl   CONSTANT VARCHAR2(2) :=CHR(10); 
--
  SUBTYPE type_vc2_100  IS VARCHAR2(100);
  SUBTYPE type_vc2_1k   IS VARCHAR2(1000);
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
FUNCTION tokenize_rhs_refined (p_rhs VARCHAR2) 
RETURN parser_rule_token_col 
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
-- Version up to May? 2026 ?
-- which has some of Minh'symb tweeks regarding check which procedure is "called" and "created" 
/*
  co_state_initial      CONSTANT VARCHAR2( 10 ) := 'initial';

  v_lhs  parser_grammar_rules.lhs%TYPE;
  v_rhs  parser_grammar_rules.rhs%TYPE;
  v_proc_name     VARCHAR2(100);

  v_code CLOB := EMPTY_CLOB();  -- will hold all generated procedures

  ----------------------------------------------------------------------
  -- Append altern line to the CLOB
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
    /* what we want to achieve in case of repitition:
-- an solution example for 
--lhs: <declaration_section>
--rhs:  <declaration> {<declaration>}*
PROCEDURE parse_declaration_section IS
BEGIN
   -- mandatory first occurrence
   parse_declaration;

   -- repetition: { <declaration> }*
   WHILE is_start_of_declaration(lookahead) LOOP
      parse_declaration;
      -- for more robustness
      if NOT is_valid_token (lookahead ) THEN 
        RAISE error
      end if
   END LOOP;
END;
    *--/
      co_repetition_code_templale  CONSTANT type_vc2_1k :=  
      Q'[  --
   -- mandatory first occurrence
parse_<rule>;
-- repetition: { <rule> }*
WHILE is_start_of_rule( lookahead ) LOOP
  parse_<rule>;
  -- for more robustness
  IF NOT is_valid_token ( lookahead ) THEN 
    RAISE_APPLICATION_ERROR( -20001, 'Invalid token '|| is_valid_token );
  END IF;
END LOOP;
]';
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
  FOR r IN (
      SELECT lhs, rhs 
      FROM parser_grammar_rules 
      ORDER BY lhs
    ) 
  LOOP
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
  */ 
  BEGIN return null; 
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
FUNCTION fn_norm_as_proc_name 
	(p_input 	VARCHAR2 
) RETURN VARCHAR2 
AS 
	l_return VARCHAR2(100) := p_input;
BEGIN
	IF l_return LIKE '%]' 	
	THEN 
		l_return := 		substr( l_return, 1, length( l_return ) -1 ) ;
	END IF;
	-- 
	IF l_return LIKE '[%' 	
	THEN 
		l_return := substr( l_return, 2 ) ;
	END IF;
	-- 
	IF 		substr ( l_return, 1, 1 ) 	= '<'
		AND substr ( l_return, -1) 		= '>'
	THEN 
		l_return := substr( l_return, 2, length ( l_return ) - 2 );
	END IF;
	--
	IF l_return LIKE '"%"' 	
	THEN 
		l_return := substr( l_return, 2, length ( l_return ) - 2 );
	END IF;
	-- 
	RETURN 'pr_'||lower( l_return );
END fn_norm_as_proc_name;
--
FUNCTION fn_get_parser_package_code 
	(p_source			IN VARCHAR2 
	,p_package_name 	IN VARCHAR2 DEFAULT 'PKG_DYNAMIC_PARSER'
	,p_spec_body_mask 	IN INTEGER DEFAULT 2 -- 0 both, 1-spec only, 2-body only
) RETURN CLOB IS
    l_clob        CLOB;
    l_spec        CLOB;
    l_body        CLOB;
    
    -- Cursor for unique LHS rules (Type 1)
    CURSOR c_rules IS
		WITH dist_lhs AS ( 
			SELECT DISTINCT lhs 
			FROM parser_alt_token 
			WHERE source = upper( trim( p_source ) ) 
		) 
		SELECT lhs 
			, parser_grammar_gen. fn_norm_as_proc_name ( p_input=> lhs ) lhs_procname 
			, row_number() OVER ( PARTITION BY NULL ORDER BY lhs ) 	as seq 
			, count(*) OVER ( PARTITION BY NULL ORDER BY lhs ) 		as tot 
		FROM dist_lhs
		ORDER BY lhs
			;
        
    -- Cursor for alternatives of altern specific LHS (Type 2)
    CURSOR c_alternatives(cp_lhs VARCHAR2) IS
        SELECT DISTINCT alt_no 
        FROM parser_alt_token 
        WHERE lhs = cp_lhs 
        ORDER BY alt_no;
        
    -- Cursor for symbols within altern specific alternative
    CURSOR c_symbols(cp_lhs VARCHAR2, cp_alt_no NUMBER) IS
        SELECT position, symbol 
			, symbol_cleansed 
        FROM v_parser_alt_token 
        WHERE lhs = cp_lhs AND alt_no = cp_alt_no 
        ORDER BY position;

    -- Cursor to find distinct terminal symbols vs LHS rules
    TYPE t_lhs_list IS TABLE OF VARCHAR2(30);
    l_all_lhs NUMBER;
    
    PROCEDURE append_to_clob(p_target IN OUT NOCOPY CLOB, p_text IN VARCHAR2) IS
    BEGIN
        DBMS_LOB.WRITEAPPEND(p_target, LENGTH(p_text), p_text);
    END append_to_clob;

BEGIN	-- fn_get_parser_package_code 
-- RAISE_APPLICATION_ERROR( -20001, 'ln'||$$plsql_line );
dbms_output.put_line (  'ln'||$$plsql_line );
    -- Initialize CLOBs
    DBMS_LOB.CREATETEMPORARY(l_spec, TRUE);
    DBMS_LOB.CREATETEMPORARY(l_body, TRUE);
    DBMS_LOB.CREATETEMPORARY(l_clob, TRUE);

    -- 1. BUILD PACKAGE SPECIFICATION HEADERS
    append_to_clob(l_spec, 'CREATE OR REPLACE PACKAGE ' || p_package_name || ' AS' || CHR(10));
    append_to_clob(l_spec, '  -- Global collection type for tokens' || CHR(10));
    append_to_clob(l_spec, '  g_tokens         parser_token_col;' || CHR(10));
    append_to_clob(l_spec, '  g_curr_token_ix  NUMBER := 1;' || CHR(10) || CHR(10));

    -- 2. BUILD PACKAGE BODY HEADERS
    append_to_clob(l_body, 'CREATE OR REPLACE PACKAGE BODY ' || p_package_name || ' AS' || CHR(10) || CHR(10));
    
    -- Forward declarations in Body for Type 2 rules (Alts) to allow arbitrary order recursion
    FOR r IN c_rules LOOP
        FOR altern IN c_alternatives(r.lhs) LOOP
            append_to_clob(l_body, '  PROCEDURE ' || fn_norm_as_proc_name( r.lhs )|| '_' || altern.alt_no || '(po_success OUT BOOLEAN);' || CHR(10));
        END LOOP;
    END LOOP;
    append_to_clob(l_body, CHR(10));

    -- 3. GENERATE SUBPROGRAMS (Type 1 and Type 2)
    FOR r IN c_rules LOOP
        -- Add Type 1 (LHS master rule) to Specification
        append_to_clob(l_spec, '  PROCEDURE ' || r.lhs_procname || '(po_success OUT BOOLEAN);' || CHR(10));
		IF r.seq  = 1 THEN 
			dbms_output.put_line ( $$plsql_unit||':'||$$plsql_line||' lhs:'||r.lhs||' tot:'||r.tot );
		END IF;
		IF mod( r.seq , 5 ) = 1 THEN 
			dbms_output.put_line ( $$plsql_unit||':'||$$plsql_line||' lhs:'||r.lhs||' spec len:'||dbms_lob.getlength( l_spec ) );
		END IF;

        -- Add Type 1 (LHS master rule) to Body
        append_to_clob(l_body, '  PROCEDURE ' || r.lhs_procname || '(po_success OUT BOOLEAN) IS' || CHR(10));
        append_to_clob(l_body, '    l_breadcrumb breadcrumb:=  breadcrumb();' || CHR(10));
        append_to_clob(l_body, '    l_entry_idx NUMBER := g_curr_token_ix;' || CHR(10));
        append_to_clob(l_body, '  BEGIN' || CHR(10));
        append_to_clob(l_body, '    dbms_output.put_line( $$plsql_unit||'':''||$$plsql_line ||''  g_curr_token_ix: ''||g_curr_token_ix||'' content: ''||g_tokens( g_curr_token_ix ).tok_type );' || CHR(10));
        append_to_clob(l_body, '    po_success := FALSE;' || CHR(10));
        
        -- Loop through alternatives inside Type 1
        FOR altern IN c_alternatives(r.lhs) LOOP
            append_to_clob(l_body, '    IF NOT po_success THEN' || CHR(10));
            append_to_clob(l_body, '      ' || r.lhs_procname || '_' || altern.alt_no || '(po_success);' || CHR(10));
            append_to_clob(l_body, '      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;' || CHR(10));
            append_to_clob(l_body, '    END IF;' || CHR(10));
        END LOOP;
		IF mod( r.seq , 5 ) = 1 THEN 
			dbms_output.put_line ( $$plsql_unit||':'||$$plsql_line||' lhs:'||r.lhs||' body len:'||dbms_lob.getlength( l_body ) );
		END IF;
        append_to_clob(l_body, '  END ' || r.lhs_procname || ';' || CHR(10) || CHR(10));

        -- Add Type 2 (Alternative rules) to Body
        FOR altern IN c_alternatives(r.lhs) LOOP
            append_to_clob(l_body, '  PROCEDURE ' || r.lhs_procname || '_' || altern.alt_no || '(po_success OUT BOOLEAN) IS' || CHR(10));
			append_to_clob(l_body, '    l_breadcrumb breadcrumb:=  breadcrumb();' || CHR(10));
            append_to_clob(l_body, '    l_entry_idx NUMBER := g_curr_token_ix;' || CHR(10));
            append_to_clob(l_body, '  BEGIN' || CHR(10));
			append_to_clob(l_body, '    dbms_output.put_line( $$plsql_unit||'':''||$$plsql_line ||''  g_curr_token_ix: ''||g_curr_token_ix||'' content: ''||g_tokens( g_curr_token_ix ).tok_type );' || CHR(10));
            append_to_clob(l_body, '    po_success := TRUE;' || CHR(10));
            
            -- Process sequence symbols inside Alternative
            FOR symb IN c_symbols(r.lhs, altern.alt_no) 
			LOOP
                append_to_clob(l_body, '    -- Position ' || symb.position || ': Symbol ' || symb.symbol || CHR(10));
                append_to_clob(l_body, '    IF po_success THEN' || CHR(10));
                
                -- Check if symbol is another LHS rule (Non-Terminal)
                SELECT COUNT(*) 
				INTO l_all_lhs 
				FROM (
					SELECT DISTINCT lhs FROM parser_alt_token )
					WHERE lhs = symb.symbol 
					;
                
                IF l_all_lhs > 0 THEN
                    -- Call sub-rule
                    append_to_clob(l_body, '      ' || fn_norm_as_proc_name( symb.symbol )|| '(po_success);' || CHR(10));
                ELSE
                    -- Terminal Token validation match
                    append_to_clob(l_body, '      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = ''' || symb.symbol || ''' THEN' || CHR(10));
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
            append_to_clob(l_body, '  END ' || fn_norm_as_proc_name( r.lhs )|| '_' || altern.alt_no || ';' || CHR(10) || CHR(10));
        END LOOP;
    END LOOP;

    -- 4. BONUS: DETERMINE TOP-LEVEL RULES & GENERATE MAIN SUBPROGRAM
    append_to_clob(l_spec, CHR(10) || '  -- Main entry point for top-level parsing rules' || CHR(10));
    append_to_clob(l_spec, '  PROCEDURE parse_main(p_token_stream IN parser_token_col, po_success OUT BOOLEAN);' || CHR(10));
    
    append_to_clob(l_body, '  PROCEDURE parse_main(p_token_stream IN parser_token_col, po_success OUT BOOLEAN) IS' || CHR(10));
    append_to_clob(l_body, '    l_breadcrumb breadcrumb:=  breadcrumb();' || CHR(10));
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
        append_to_clob(l_body, '      ' || fn_norm_as_proc_name( top_rule.lhs )|| '(po_success);' || CHR(10));
        append_to_clob(l_body, '    END IF;' || CHR(10));
    END LOOP;
    
    append_to_clob(l_body, '  END parse_main;' || CHR(10) || CHR(10));

    -- 5. CLOSE OUT STRINGS
    append_to_clob(l_spec, 'END ' || p_package_name || ';' || co_nl ||'/'|| co_nl );
    append_to_clob(l_body, 'END ' || p_package_name || ';' || co_nl ||'/'|| co_nl );

    -- Combine into final CLOB
	IF p_spec_body_mask IN ( 0 , 1 ) 
	THEN 
		DBMS_LOB.APPEND(l_clob, l_spec);
		DBMS_LOB.WRITEAPPEND(l_clob, 2, CHR(10) || CHR(10));
	END IF; 
	IF p_spec_body_mask IN ( 0 , 2 ) 
	THEN 
		DBMS_LOB.APPEND(l_clob, l_body);
	END IF;
	-- 
    RETURN l_clob;
END fn_get_parser_package_code;
--
--
END; -- package 
/
