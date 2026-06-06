CREATE OR REPLACE PROCEDURE transform_and_insert_ebnf (
    p_lhs VARCHAR2,
    p_rhs VARCHAR2
) IS
    -- Collections for handling individual string tokens
    TYPE token_list IS TABLE OF VARCHAR2(1000) INDEX BY PLS_INTEGER;
    
    -- Record to hold intermediate rules during bracket parsing
    TYPE rule_rec IS RECORD (
        lhs VARCHAR2(1000),
        tokens token_list
    );
    TYPE rule_table IS TABLE OF rule_rec;
    
    v_working_rules  rule_table := rule_table();
    v_current_idx    NUMBER := 1;
    v_counter        NUMBER := 0;      -- Suffix counter for <opt_n> and <rep_n>
    v_rule_seq       NUMBER := 1;      -- Sequential rule identifier for the table
    
    v_initial_tokens token_list;

    -- Helper function to split a text string into an array of atomic tokens
    FUNCTION tokenize(p_str VARCHAR2) RETURN token_list IS
        v_tokens token_list;
        v_idx    NUMBER := 1;
        -- Match non-terminals, words/literals, or individual punctuation/bracket symbols
        v_pattern VARCHAR2(100) := '(<[^>]+>|"[^"]+"|[a-zA-Z0-9_]+|\[|\]|\{|\}|\*|\||[^[:space:]])';
        v_pos    NUMBER := 1;
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
    PROCEDURE process_token_brackets(p_tokens IN OUT token_list) IS
        v_open_idx       NUMBER := 0;
        v_close_idx      NUMBER := 0;
        v_bracket_type   VARCHAR2(1);
        v_level          NUMBER := 0;
        
        v_inner_tokens   token_list;
        v_new_rule_name  VARCHAR2(100);
        v_new_tokens     token_list;
        v_new_idx        NUMBER := 1;
        
        v_is_repetition  BOOLEAN := FALSE;
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
            -- Extract interior contents into a clean token block
            FOR i IN (v_open_idx + 1)..(v_close_idx - 1) LOOP
                v_inner_tokens(v_inner_tokens.COUNT + 1) := p_tokens(i);
            END LOOP;
            
            v_counter := v_counter + 1;

            IF v_bracket_type = '[' THEN
                v_new_rule_name := '<'|| f_trim_angle_brackes(p_lhs) ||'_opt_' || v_counter || '>';
                
                -- Queue the option rule sequence: content | ;
                v_working_rules.EXTEND;
                v_working_rules(v_working_rules.LAST).lhs := v_new_rule_name;
                
                -- Append standard content tokens
                FOR i IN 1..v_inner_tokens.COUNT LOOP
                    v_working_rules(v_working_rules.LAST).tokens(i) := v_inner_tokens(i);
                END LOOP;
                -- Append alternation pipeline
                v_working_rules(v_working_rules.LAST).tokens(v_inner_tokens.COUNT + 1) := '|';
                v_working_rules(v_working_rules.LAST).tokens(v_inner_tokens.COUNT + 2) := ';';
                
                v_skip_until := v_close_idx;
                
            ELSIF v_bracket_type = '{' THEN
                -- Safely check if the next active token is a repetition asterisk
                IF p_tokens.EXISTS(v_close_idx + 1) AND p_tokens(v_close_idx + 1) = '*' THEN
                    v_new_rule_name := '<'||f_trim_angle_brackes( p_lhs )||'_rep_' || v_counter || '>';
                    
                    -- Queue the repetition rule sequence: content <rep_n> | ;
                    v_working_rules.EXTEND;
                    v_working_rules(v_working_rules.LAST).lhs := v_new_rule_name;
                    
                    FOR i IN 1..v_inner_tokens.COUNT LOOP
                        v_working_rules(v_working_rules.LAST).tokens(i) := v_inner_tokens(i);
                    END LOOP;
                    v_working_rules(v_working_rules.LAST).tokens(v_inner_tokens.COUNT + 1) := v_new_rule_name;
                    v_working_rules(v_working_rules.LAST).tokens(v_inner_tokens.COUNT + 2) := '|';
                    v_working_rules(v_working_rules.LAST).tokens(v_inner_tokens.COUNT + 3) := ';';
                    
                    v_skip_until := v_close_idx + 1; -- Skip the closing bracket AND its asterisk token
                ELSE
                    -- Fallback: treats standard curly braces without an asterisk as plain structural items
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

BEGIN
    -- Tokenize the input expression 
    v_initial_tokens := tokenize(p_rhs);
    
    -- Initialize the primary transformation queue
    v_working_rules.EXTEND;
    v_working_rules(v_working_rules.LAST).lhs := TRIM(p_lhs);
    v_working_rules(v_working_rules.LAST).tokens := v_initial_tokens;
    
    -- 1. Unpack all token-based parenthetical expressions 
    WHILE v_current_idx <= v_working_rules.COUNT LOOP
        process_token_brackets(v_working_rules(v_current_idx).tokens);
        v_current_idx := v_current_idx + 1;
    END LOOP;
    
    -- 2. Traverse finalized token lists, split on pipe '|' markers, and write to table
    FOR i IN 1..v_working_rules.COUNT LOOP
        DECLARE
            v_final_lhs  VARCHAR2(1000) := v_working_rules(i).lhs;
            v_tok_array  token_list     := v_working_rules(i).tokens;
            v_buffer_rhs VARCHAR2(4000) := '';
        BEGIN
            FOR j IN 1..v_tok_array.COUNT LOOP
                IF v_tok_array(j) = '|' THEN
                    IF TRIM(v_buffer_rhs) IS NOT NULL THEN
                        INSERT INTO temp_bnf_rules (lhs, rule_number, rhs)
                        VALUES (v_final_lhs, v_rule_seq, TRIM(v_buffer_rhs));
                        v_rule_seq   := v_rule_seq + 1;
                        v_buffer_rhs := '';
                    END IF;
                ELSE
                    -- Safely rebuild space-delimited string out of finalized tokens
                    v_buffer_rhs := v_buffer_rhs || v_tok_array(j) || ' ';
                END IF;
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
 SELECT lhs, rule_number, rhs FROM temp_bnf_rules ORDER BY rule_number
;