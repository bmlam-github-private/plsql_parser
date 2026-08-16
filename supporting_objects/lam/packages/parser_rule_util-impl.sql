CREATE OR REPLACE PACKAGE BODY parser_rule_util
AS 
--
    c_epsilon   CONSTANT VARCHAR2( 10 ) := 'EPSILON';
	--
	g_max_nesting 			NUMBER := 599;
	g_nesting_dump_loop_max 	NUMBER := 5;
	g_curr_nesting_level 	NUMBER := 0;
	g_curr_lhs				VARCHAR2(100);
	g_curr_rhs				VARCHAR2(4000);
--
-- FORWARD DECLARATION 
--
PROCEDURE pr_log_json_result 
( p_grammar_name	IN VARCHAR2 
 ,p_grammar_text	IN CLOB 
 ,p_check_dupes    	IN BOOLEAN DEFAULT TRUE 
);
--
-- 
--
PROCEDURE push_row
    ( pi_row     IN parser_grammar_rule_simple_rec
     ,pio_rows   IN OUT NOCOPY parser_grammar_rule_simple_col 
    )
AS
BEGIN
    pio_rows.extend;
    pio_rows( pio_rows.last ) := pi_row;
END push_row;
-- 
FUNCTION fn_1_ebnf_to_simple
(   p_lhs       IN VARCHAR2
   ,p_rhs       IN VARCHAR2
   ,p_source    IN VARCHAR2
)
RETURN parser_grammar_rule_simple_col
-- 
AS
    v_return parser_grammar_rule_simple_col :=  parser_grammar_rule_simple_col();
    -- Token list collection types
    TYPE token_list IS TABLE OF VARCHAR2(1000) INDEX BY PLS_INTEGER;
    
    TYPE rule_rec IS RECORD (
        lhs VARCHAR2(1000),
        tokens token_list
    );
    TYPE rule_table IS TABLE OF rule_rec;
    
    v_working_rules  rule_table := rule_table();
    v_final_rules    rule_table := rule_table();
    
    v_current_idx    NUMBER := 1;
    v_suffix_ix      NUMBER := 0;      -- Suffix counter for <opt_n> and <rep_n>
    v_rule_seq       NUMBER := 1;      -- Sequential identifier for the table
    v_initial_tokens token_list;

    -- Helper function to split text into strict grammatical tokens
    FUNCTION tokenize(p_str VARCHAR2) RETURN token_list IS
        v_tokens token_list;
        v_idx    NUMBER := 1;
        -- Regex matches: <non-terminals>, "strings", words, brackets, pipes, or single symbols
        v_pattern VARCHAR2(100) := '(<[^>]+>|"[^"]+"|[a-zA-Z0-9_]+|\[|\]|\{|\}|\(|\)|\*|\||[^[:space:]])';
        v_match  VARCHAR2(1000);
    BEGIN
        LOOP
            v_match := REGEXP_SUBSTR(p_str, v_pattern, 1, v_idx);
            EXIT WHEN v_match IS NULL;
            v_tokens(v_idx) := v_match;
            v_idx := v_idx + 1;
        END LOOP;
        RETURN v_tokens;
    END tokenize;
    -- 
    FUNCTION f_trim_angle_brackes ( p_str VARCHAR2 )    -- BM.Lam
    RETURN VARCHAR2 
    AS 
    BEGIN   
        RETURN 
            CASE WHEN       substr( p_str, 1, 1) = '<' 
                        AND substr( p_str, -1)   = '>' 
            THEN    substr( p_str, 2, length( p_str ) - 2 ) 
            ELSE    p_str 
            END;
    END f_trim_angle_brackes;
    -- 
    -- Recursive procedure to parse bracket blocks out of token arrays

    -- PHASE 1: Recursive extraction of outermost [] and {}* brackets
    PROCEDURE process_token_brackets(p_tokens IN OUT token_list) IS
        v_open_idx       NUMBER := 0;
        v_close_idx      NUMBER := 0;
        v_bracket_type   VARCHAR2(1);
        v_level          NUMBER := 0;
        v_inner_tokens   token_list;
        v_new_rule_name  VARCHAR2(100);
        v_new_tokens     token_list;
        v_new_idx        NUMBER := 1;
        v_skip_until     NUMBER := 0;
		-- 
		PROCEDURE ipr_detect_infinite_loop
		AS 
		BEGIN 
			g_curr_nesting_level := 		g_curr_nesting_level + 1;
			IF g_curr_nesting_level >= g_max_nesting - g_nesting_dump_loop_max THEN 
				FOR i IN 1 .. g_nesting_dump_loop_max LOOP 
					dbms_output.put_line ( $$plsql_unit||':'||$$plsql_line
							||' nesting: '||g_curr_nesting_level 
							||' i: '||i 
							||' p_tokens(i):' || p_tokens(i)
							||' g_curr_lhs: '|| g_curr_lhs
							||' g_curr_rhs: '|| g_curr_rhs
						);
				END LOOP; 
				--
				IF g_curr_nesting_level = g_max_nesting THEN 
					RAISE_APPLICATION_ERROR( -20001 , 
							$$plsql_unit||':'||$$plsql_line
							||' MAX NESTING LEVEL REACHED: '||g_max_nesting 
							||' nesting: '||g_curr_nesting_level 
							||' g_curr_lhs: '|| g_curr_lhs
							||' g_curr_rhs: '|| g_curr_rhs
						);
				END IF;
			END IF;
		END ipr_detect_infinite_loop;
    BEGIN
			dbms_output.put_line ( $$plsql_unit||':'||$$plsql_line||' g_curr_nesting_level: '||g_curr_nesting_level||' p_tokens: '||p_tokens.count||' first: '|| p_tokens(1)||' last: '|| p_tokens(p_tokens.last)	);		
		-- 
        -- Scan tokens to find the first outermost opening bracket sequence
        FOR i IN 1..p_tokens.COUNT LOOP
            IF p_tokens(i) IN ('[', '{') AND v_level = 0 THEN
                v_open_idx := i;
                v_bracket_type := p_tokens(i);
                v_level := 1;
            ELSIF p_tokens(i) IN ('[', '{') THEN
                v_level := v_level + 1;
            ELSIF p_tokens(i) IN (']', '}') THEN
                v_level := v_level - 1;
                IF v_level = 0 AND p_tokens(i) = CASE v_bracket_type WHEN '[' THEN ']' WHEN '{' THEN '}' END THEN
                    v_close_idx := i;
                    EXIT;
                END IF;
            END IF;
        END LOOP;
		dbms_output.put_line ( $$plsql_unit||':'||$$plsql_line||' v_bracket_type: '|| v_bracket_type||' v_close_idx: '||v_close_idx	);

        -- If an outermost bracket pair was isolated
        IF v_open_idx > 0 THEN
            FOR i IN (v_open_idx + 1)..(v_close_idx - 1) LOOP
                v_inner_tokens(v_inner_tokens.COUNT + 1) := p_tokens(i);
            END LOOP;
            
			dbms_output.put_line ( $$plsql_unit||':'||$$plsql_line							||' nesting: '||g_curr_nesting_level 							||' v_bracket_type: '|| v_bracket_type						);
            v_suffix_ix := v_suffix_ix + 1;

            IF v_bracket_type = '[' THEN
                v_new_rule_name := '<'|| f_trim_angle_brackes(p_lhs) ||'_opt_' || v_suffix_ix || '>';
				dbms_output.put_line ( $$plsql_unit||':'||$$plsql_line
							||' nesting: '||g_curr_nesting_level 
							||' v_new_rule_name: '|| v_new_rule_name
							||' v_suffix_ix: '|| v_suffix_ix
						);
                
                v_working_rules.EXTEND;
                v_working_rules(v_working_rules.LAST).lhs := v_new_rule_name;
                
                -- Store inside parenthetical expression to force Phase 2 to resolve choices cleanly
                v_working_rules(v_working_rules.LAST).tokens(1) := '(';
                FOR i IN 1..v_inner_tokens.COUNT LOOP
                    v_working_rules(v_working_rules.LAST).tokens(i+1) := v_inner_tokens(i);
                END LOOP;
                v_working_rules(v_working_rules.LAST).tokens(v_inner_tokens.COUNT + 2) := '|';
                v_working_rules(v_working_rules.LAST).tokens(v_inner_tokens.COUNT + 3) := c_epsilon;
                v_working_rules(v_working_rules.LAST).tokens(v_inner_tokens.COUNT + 4) := ')';
                
                v_skip_until := v_close_idx;
                
            ELSIF v_bracket_type = '{' THEN
                IF p_tokens.EXISTS(v_close_idx + 1) AND p_tokens(v_close_idx + 1) = '*' THEN
                    v_new_rule_name := '<'||f_trim_angle_brackes( p_lhs )||'_rep_' || v_suffix_ix || '>';
                    
                    v_working_rules.EXTEND;
                    v_working_rules(v_working_rules.LAST).lhs := v_new_rule_name;
				dbms_output.put_line ( $$plsql_unit||':'||$$plsql_line
							||' nesting: '||g_curr_nesting_level 
							||' v_new_rule_name: '|| v_new_rule_name
							||' v_suffix_ix: '|| v_suffix_ix
						);
                    
                    -- Formulate structural base: ( inner_tokens <rep_n> | ; )
                    v_working_rules(v_working_rules.LAST).tokens(1) := '(';
                    
                    -- If the inner block contains nested alternatives like ( "-" | "+" ), 
                    -- we preserve them intact so Phase 2 can multiply them alongside the trailing <rep_n>
                    FOR i IN 1..v_inner_tokens.COUNT LOOP
                        v_working_rules(v_working_rules.LAST).tokens(i+1) := v_inner_tokens(i);
                    END LOOP;
                    
                    v_working_rules(v_working_rules.LAST).tokens(v_inner_tokens.COUNT + 2) := v_new_rule_name;
                    v_working_rules(v_working_rules.LAST).tokens(v_inner_tokens.COUNT + 3) := '|';
                    v_working_rules(v_working_rules.LAST).tokens(v_inner_tokens.COUNT + 4) := c_epsilon;
                    v_working_rules(v_working_rules.LAST).tokens(v_inner_tokens.COUNT + 5) := ')';
                    
                    v_skip_until := v_close_idx + 1;
                ELSE
                    v_skip_until := v_close_idx;
                    v_new_rule_name := '{'; 
                END IF;
            END IF;

            -- Re-stitch the parent rule tokens, injecting the new rule pointer tag
            FOR i IN 1..p_tokens.COUNT LOOP
                IF i < v_open_idx THEN
                    v_new_tokens(v_new_idx) := p_tokens(i);
                    v_new_idx := v_new_idx + 1;
                ELSIF i = v_open_idx THEN
                    v_new_tokens(v_new_idx) := v_new_rule_name;
                    v_new_idx := v_new_idx + 1;
                ELSIF i > v_skip_until THEN
                    v_new_tokens(v_new_idx) := p_tokens(i);
                    v_new_idx := v_new_idx + 1;
                END IF;
            END LOOP;
            
            p_tokens := v_new_tokens;
            
            -- Recurse to handle any other bracket definitions inside this array block
ipr_detect_infinite_loop;			
            process_token_brackets(p_tokens);
        END IF;
    END process_token_brackets;

    -- PHASE 2: Recursively expand internal alternatives ( | ) and parenthesized groups ( )
    PROCEDURE flatten_alternatives(p_lhs VARCHAR2, p_tokens token_list) IS
        v_open_group  NUMBER := 0;
        v_close_group NUMBER := 0;
        v_level       NUMBER := 0;
        
        -- Collection types to split choice tracks
        TYPE choice_list IS TABLE OF token_list INDEX BY PLS_INTEGER;
        v_choices      choice_list;
        v_current_ch   NUMBER := 1;
        
        v_prefix       token_list;
        v_suffix       token_list;
        v_combined     token_list;
    BEGIN
        -- Find the first outermost parenthesized alternative group or structural unparenthesized pipe
        -- Strategy: Look for an explicit '(' block. If none exists, look for a top-level naked '|'
        FOR i IN 1..p_tokens.COUNT LOOP
            IF p_tokens(i) = '(' AND v_level = 0 THEN
                v_open_group := i;
                v_level := 1;
            ELSIF p_tokens(i) = '(' THEN
                v_level := v_level + 1;
            ELSIF p_tokens(i) = ')' THEN
                v_level := v_level - 1;
                IF v_level = 0 THEN
                    v_close_group := i;
                    EXIT;
                END IF;
            END IF;
        END LOOP;

        -- Scenario A: Explicit grouping found, e.g., ... ( "-" | "+" ) ...
        IF v_open_group > 0 THEN
            -- Isolate prefix and suffix segments around the group
            FOR i IN 1..(v_open_group - 1) LOOP
                v_prefix(v_prefix.COUNT + 1) := p_tokens(i);
            END LOOP;
            FOR i IN (v_close_group + 1)..p_tokens.COUNT LOOP
                v_suffix(v_suffix.COUNT + 1) := p_tokens(i);
            END LOOP;

            -- Segment internal items inside the group split by its primary internal pipes
            v_level := 0;
            v_choices(1) := token_list();
            FOR i IN (v_open_group + 1)..(v_close_group - 1) LOOP
                IF p_tokens(i) = '(' THEN v_level := v_level + 1; END IF;
                IF p_tokens(i) = ')' THEN v_level := v_level - 1; END IF;
                
                IF p_tokens(i) = '|' AND v_level = 0 THEN
                    v_current_ch := v_current_ch + 1;
                    v_choices(v_current_ch) := token_list();
                ELSE
                    v_choices(v_current_ch)(v_choices(v_current_ch).COUNT + 1) := p_tokens(i);
                END IF;
            END LOOP;

            -- Cross-multiply prefix + choice + suffix and recurse to verify deep nests
            FOR c IN 1..v_choices.COUNT LOOP
                v_combined := v_prefix;
                FOR m IN 1..v_choices(c).COUNT LOOP
                    v_combined(v_combined.COUNT + 1) := v_choices(c)(m);
                END LOOP;
                FOR s IN 1..v_suffix.COUNT LOOP
                    v_combined(v_combined.COUNT + 1) := v_suffix(s);
                END LOOP;
                
                flatten_alternatives(p_lhs, v_combined);
            END LOOP;
            RETURN;
        END IF;

        -- Scenario B: No explicit parenthesis groups, look for top level raw pipes: A | B
        v_current_ch := 1;
        v_choices.DELETE;
        v_choices(1) := token_list();
        FOR i IN 1..p_tokens.COUNT LOOP
            IF p_tokens(i) = '|' THEN
                v_current_ch := v_current_ch + 1;
                v_choices(v_current_ch) := token_list();
            ELSE
                v_choices(v_current_ch)(v_choices(v_current_ch).COUNT + 1) := p_tokens(i);
            END IF;
        END LOOP;

        -- If raw pipes exist, enqueue individual split branches
        IF v_choices.COUNT > 1 THEN
            FOR c IN 1..v_choices.COUNT LOOP
                flatten_alternatives(p_lhs, v_choices(c));
            END LOOP;
            RETURN;
        END IF;

        -- Scenario C: Pure, flattened simple rule structure. Append to final table stack.
        v_final_rules.EXTEND;
        v_final_rules(v_final_rules.LAST).lhs := p_lhs;
        v_final_rules(v_final_rules.LAST).tokens := p_tokens;
    END flatten_alternatives;

BEGIN
	dbms_output.put_line ( UTL_CALL_STACK.CONCATENATE_SUBPROGRAM(UTL_CALL_STACK.SUBPROGRAM(1))|| ' p_lhs: '||  p_lhs|| ' p_rhs: '||  p_rhs );
    -- Tokenize and initialize Phase 1
	g_curr_lhs := p_lhs;
	g_curr_rhs := p_rhs;
    v_initial_tokens := tokenize(p_rhs);
    v_working_rules.EXTEND;
    v_working_rules(v_working_rules.LAST).lhs := TRIM(p_lhs);
    v_working_rules(v_working_rules.LAST).tokens := v_initial_tokens;
    
    WHILE v_current_idx <= v_working_rules.COUNT LOOP
        process_token_brackets(v_working_rules(v_current_idx).tokens);
        v_current_idx := v_current_idx + 1;
    END LOOP;
    
    -- Execute Phase 2 across all rules discovered in Phase 1
    FOR i IN 1..v_working_rules.COUNT LOOP
        flatten_alternatives(v_working_rules(i).lhs, v_working_rules(i).tokens);
    END LOOP;
    
    -- Commit fully simplified rules out to the physical table destination
    FOR i IN 1..v_final_rules.COUNT LOOP
        DECLARE
            v_final_lhs  VARCHAR2(1000) := v_final_rules(i).lhs;
            v_tok_array  token_list     := v_final_rules(i).tokens;
            v_buffer_rhs VARCHAR2(4000) := '';
        BEGIN
            FOR j IN 1..v_tok_array.COUNT LOOP
                v_buffer_rhs := v_buffer_rhs || v_tok_array(j) || ' ';
            END LOOP;
            
            -- Catch residual string elements trailing past the last pipe, or if no pipe existed
            IF TRIM(v_buffer_rhs) IS NOT NULL THEN
                --INSERT INTO temp_bnf_rules (lhs, rule_number, rhs)
                --VALUES (v_final_lhs, v_rule_seq, TRIM(v_buffer_rhs) );
                push_row ( parser_grammar_rule_simple_rec
                            (lhs=>          v_final_lhs
                            ,rhs=>          TRIM(v_buffer_rhs) 
                            ,lhs_root=>     p_lhs  
                            ,subrule_no=>   v_rule_seq
                            ,source=>       p_source 
                            )
                            , pio_rows => v_return  
                        );

                v_rule_seq := v_rule_seq + 1;
            END IF;
        END;
    END LOOP;
    
    -- push self
    push_row ( parser_grammar_rule_simple_rec
                (lhs=>          p_lhs
                ,rhs=>          p_rhs
                ,lhs_root=>     p_lhs
                ,subrule_no=>   0
                ,source=>       p_source
                )
            , pio_rows => v_return 
            );
    --
    RETURN v_return;
END fn_1_ebnf_to_simple;
--  
FUNCTION fn_ebnf_clob_to_simple
(   p_clob      IN CLOB
   ,p_source    IN VARCHAR2
)
RETURN parser_grammar_rule_simple_col
--
AS 
	v_return 		parser_grammar_rule_simple_col := 		parser_grammar_rule_simple_col();
    v_lines         APEX_T_VARCHAR2;
    v_line          VARCHAR2(32000 	CHAR);
	v_source_normed parser_grammar_rule_simple.source%TYPE;
BEGIN 
	v_source_normed := trim( upper ( p_source ) );
    v_lines := f_apex_split_clob ( p_clob => p_clob , p_sep=> chr(10) );
	g_curr_nesting_level := 0;
    --
	--dbms_output.put_line ( 'Ln'||$$plsql_line|| ' xx: '||  xx );
	dbms_output.put_line ( UTL_CALL_STACK.CONCATENATE_SUBPROGRAM(UTL_CALL_STACK.SUBPROGRAM(1))|| ' v_lines.count: '||  v_lines.count );
	FOR ln_ix IN 1 .. v_lines.count 
	LOOP 
		v_line := v_lines( ln_ix );
        -- Skip empty lines
        IF v_line IS NULL 
			OR instr( ltrim( v_line ), '#' ) = 1 		-- line is a comment;
		THEN
            CONTINUE;
        END IF;

        -- Parse LHS and RHS
        DECLARE
			v_return_temp 	parser_grammar_rule_simple_col;
            v_lhs_rhs_sep_pos PLS_INTEGER;
			v_lhs 			parser_grammar_rule_simple.lhs%TYPE;
			v_rhs 			parser_grammar_rule_simple.rhs%TYPE;
        BEGIN
            v_lhs_rhs_sep_pos := INSTR(v_line, '::=');
--dbms_output.put_line ( 'Ln'||$$plsql_line|| ' v_lhs_rhs_sep_pos: '||  v_lhs_rhs_sep_pos );
--dbms_output.put_line ( 'Ln'||$$plsql_line||' v_sep_pos:'||v_sep_pos );

			IF v_lhs_rhs_sep_pos > 0 THEN
                v_lhs := TRIM(SUBSTR(v_line, 1, v_lhs_rhs_sep_pos - 1));
                v_rhs := TRIM(SUBSTR(v_line, v_lhs_rhs_sep_pos + 3));
                --  transform one ebnf rule 
				v_return_temp := fn_1_ebnf_to_simple
					( p_lhs=> v_lhs
					, p_rhs=> v_rhs
					, p_source=> v_source_normed 
					);
--	dbms_output.put_line ( 'Ln'||$$plsql_line|| ' v_return_temp.count: '||  v_return_temp.count );
            END IF;
			-- 
	dbms_output.put_line ( 'Ln'||$$plsql_line||' v_return_temp.count:'||v_return_temp.count );			
	IF v_return_temp IS NOT NULL THEN 
				v_return := v_return MULTISET UNION ALL v_return_temp;
			END IF;
        END;
    END LOOP;
	--
	dbms_output.put_line ( 'Ln'||$$plsql_line||' v_return.count:'||v_return.count );			
	RETURN v_return; 
END fn_ebnf_clob_to_simple;
--
FUNCTION fn_grammar_clob_to_rule_tokens
(   p_clob      IN CLOB
   ,p_source    IN VARCHAR2
   ,p_persist   IN BOOLEAN DEFAULT FALSE -- true forfeits usage in SELECT 
   ,p_max_nesting 	IN NUMBER 
)
RETURN parser_alt_token_col
AS 
	v_return parser_alt_token_col :=  parser_alt_token_col ();
	v_rule_col parser_grammar_rule_simple_col;
BEGIN 
	g_max_nesting := p_max_nesting;
	v_rule_col := fn_ebnf_clob_to_simple 
		( p_clob 	=> p_clob 
		 ,p_source 	=> p_source 
		 -- ,p_persist => FALSE 
		 );
	IF p_persist 
	THEN 	
		DELETE parser_alt_token  
		WHERE source = p_source 
		;
	END IF; -- end init for persist 
	-- 
	FOR r_rule IN  	( 
		SELECT * 
		FROM TABLE( v_rule_col ) 
	) LOOP 
		FOR r_tok IN (
			SELECT t.column_value	AS symbol 
				,rownum 			AS seq 
			FROM TABLE ( fn_split_by_whitespaces ( r_rule.rhs ) ) t
		) LOOP 
			IF p_persist 
			THEN 
				INSERT INTO parser_alt_token  
				( LHS,			ALT_NO,				POSITION,	SYMBOL,			SOURCE   
				) VALUES 
				( r_rule.lhs,	r_rule.subrule_no,	r_tok.seq,  r_tok.symbol,	p_source 
				);
			ELSE 
				v_return.extend ;
				v_return( v_return.last ) := parser_alt_token_rec 
					( lhs => r_rule.lhs 
					 ,alt_no => r_rule.subrule_no 
					 ,position => r_tok.seq 
					 ,symbol => r_tok.symbol 
					 ,source => p_source 
					 ); 
			END IF; 
		END LOOP; -- over sequenced tokens of RHS 
	END LOOP; -- over simple rules 
	--
	IF p_persist 
	THEN -- indicate to user data is not for view as return value 
		pr_log_json_result 
		( p_grammar_name=> p_source 
		 ,p_grammar_text=> p_clob 
		);
		COMMIT;
		-- 
		v_return.extend;
		v_return( v_return.last ) :=parser_alt_token_rec 
			( lhs => null 
			 ,alt_no => 0
			 ,position => null 
			 ,symbol => 'persisted to table'
			 ,source => p_source 
			 );
	END IF;	-- end finalize for persist 
	--
	RETURN v_return;
END fn_grammar_clob_to_rule_tokens;
--
PROCEDURE pr_set_global
(   p_key 		IN VARCHAR2
   ,p_value		IN VARCHAR2
) AS 
BEGIN 
	CASE upper( trim ( p_key ) ) 
	WHEN 'MAX_NESTING'			THEN 		g_max_nesting := trunc( to_number( p_value ) );
	WHEN 'NESTING_DUMP_LOOP'	THEN 		g_nesting_dump_loop_max := trunc( to_number( p_value ) );
	ELSE 
		RAISE_APPLICATION_ERROR( -20001, 'Unknown key for global: '||p_key );
	END CASE;
END pr_set_global 
;
-- 
PROCEDURE pr_log_json_result 
( p_grammar_name	IN VARCHAR2 
 ,p_grammar_text	IN CLOB 
 ,p_check_dupes    	IN BOOLEAN DEFAULT TRUE 
) AS
	v_json_result CLOB;
	v_token_json_checksum    parser_grammar_rule_log.token_json_checksum%TYPE;
	v_grammar_text_checksum    parser_grammar_rule_log.grammar_text_checksum%TYPE;
	v_dupe_cnt    NUMBER;
BEGIN 
	SELECT json_arrayagg( json_object( t.* ) 
        RETURNING CLOB 
        ) foo 
	INTO v_json_result 
	FROM parser_alt_token t  
	WHERE source = p_grammar_name 
	ORDER BY lhs, alt_no, position, symbol 
	;
	IF p_check_dupes 
	THEN 
		v_grammar_text_checksum := f_get_clob_checksum( p_grammar_text );
		v_token_json_checksum 	:= f_get_clob_checksum( v_json_result );
		SELECT count(1) 
		INTO v_dupe_cnt 
		FROM parser_grammar_rule_log l 
		WHERE 1=1
		  AND l.grammar_text_checksum 	= v_grammar_text_checksum 
		  AND l.token_json_checksum 	= v_token_json_checksum
		  ;
		IF v_dupe_cnt > 0 THEN 
			RAISE_APPLICATION_ERROR( -20001, 'Dupe(s) exist in PARSER_GRAMMAR_RULE_LOG. Grammar checksum: '||v_grammar_text_checksum||' json checksum: '||v_token_json_checksum );
		END IF;
	END IF;
	INSERT INTO parser_grammar_rule_log 
	( grammar_name,		grammar_text,	token_set_json 
		, grammar_text_checksum		, token_json_checksum
	) VALUES 
	( p_grammar_name,   p_grammar_text, v_json_result
		, v_grammar_text_checksum	, v_token_json_checksum
	);
	-- 
END pr_log_json_result;
-- 
END;	-- package 
/

