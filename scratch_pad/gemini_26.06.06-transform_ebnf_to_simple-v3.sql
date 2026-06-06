CREATE OR REPLACE PROCEDURE transform_and_insert_ebnf (
    p_lhs VARCHAR2,
    p_rhs VARCHAR2
) IS
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
    v_counter        NUMBER := 0;      -- Suffix counter for <opt_n> and <rep_n>
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
	FUNCTION f_trim_angle_brackes ( p_str VARCHAR2 ) 	-- BM.Lam
	RETURN VARCHAR2 
	AS 
	BEGIN 	
		RETURN 
			CASE WHEN  		substr( p_str, 1, 1) = '<' 
						AND substr( p_str, -1)   = '>' 
			THEN 	substr( p_str, 2, length( p_str ) - 2 ) 
			ELSE 	p_str 
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
    BEGIN
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

        -- If an outermost bracket pair was isolated
        IF v_open_idx > 0 THEN
            FOR i IN (v_open_idx + 1)..(v_close_idx - 1) LOOP
                v_inner_tokens(v_inner_tokens.COUNT + 1) := p_tokens(i);
            END LOOP;
            
            v_counter := v_counter + 1;

            IF v_bracket_type = '[' THEN
                v_new_rule_name := '<'|| f_trim_angle_brackes(p_lhs) ||'_opt_' || v_counter || '>';
                
                v_working_rules.EXTEND;
                v_working_rules(v_working_rules.LAST).lhs := v_new_rule_name;
                
                -- Store inside parenthetical expression to force Phase 2 to resolve choices cleanly
                v_working_rules(v_working_rules.LAST).tokens(1) := '(';
                FOR i IN 1..v_inner_tokens.COUNT LOOP
                    v_working_rules(v_working_rules.LAST).tokens(i+1) := v_inner_tokens(i);
                END LOOP;
                v_working_rules(v_working_rules.LAST).tokens(v_inner_tokens.COUNT + 2) := '|';
                v_working_rules(v_working_rules.LAST).tokens(v_inner_tokens.COUNT + 3) := ';';
                v_working_rules(v_working_rules.LAST).tokens(v_inner_tokens.COUNT + 4) := ')';
                
                v_skip_until := v_close_idx;
                
            ELSIF v_bracket_type = '{' THEN
                IF p_tokens.EXISTS(v_close_idx + 1) AND p_tokens(v_close_idx + 1) = '*' THEN
                    v_new_rule_name := '<'||f_trim_angle_brackes( p_lhs )||'_rep_' || v_counter || '>';
                    
                    v_working_rules.EXTEND;
                    v_working_rules(v_working_rules.LAST).lhs := v_new_rule_name;
                    
                    -- Formulate structural base: ( inner_tokens <rep_n> | ; )
                    v_working_rules(v_working_rules.LAST).tokens(1) := '(';
                    
                    -- If the inner block contains nested alternatives like ( "-" | "+" ), 
                    -- we preserve them intact so Phase 2 can multiply them alongside the trailing <rep_n>
                    FOR i IN 1..v_inner_tokens.COUNT LOOP
                        v_working_rules(v_working_rules.LAST).tokens(i+1) := v_inner_tokens(i);
                    END LOOP;
                    
                    v_working_rules(v_working_rules.LAST).tokens(v_inner_tokens.COUNT + 2) := v_new_rule_name;
                    v_working_rules(v_working_rules.LAST).tokens(v_inner_tokens.COUNT + 3) := '|';
                    v_working_rules(v_working_rules.LAST).tokens(v_inner_tokens.COUNT + 4) := ';';
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
    -- Tokenize and initialize Phase 1
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
                INSERT INTO temp_bnf_rules (lhs, rule_number, rhs)
                VALUES (v_final_lhs, v_rule_seq, TRIM(v_buffer_rhs));
                v_rule_seq := v_rule_seq + 1;
            END IF;
        END;
    END LOOP;
    
    COMMIT;
END transform_and_insert_ebnf;
/
-- Clear old entries for clean viewing
TRUNCATE TABLE temp_bnf_rules;

BEGIN
    -- Rule 1: Expressions
    transform_and_insert_ebnf('<column_expression>', '<term> { ( "+" | "-" ) <term> }*');
    
    -- Rule 2: Terms
    transform_and_insert_ebnf('<term>', '<factor> { ( "*" | "/" ) <factor> }*');
    
    -- Rule 3: Factors
    transform_and_insert_ebnf('<factor>', 'identifier | literal | function_call | "(" <column_expression> ")"');
END;
/

-- Query the table to verify your output results
 SELECT lhs, rule_number, rhs FROM temp_bnf_rules ORDER BY lhs, rule_number
;