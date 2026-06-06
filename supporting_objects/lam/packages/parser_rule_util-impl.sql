CREATE OR REPLACE PACKAGE BODY parser_rule_util
AS 
--
FUNCTION fn_1_ebnf_to_simple_upto_20260605 
(   p_lhs 		IN VARCHAR2
   ,p_rhs 		IN VARCHAR2
   ,p_source 	IN VARCHAR2
)
RETURN parser_grammar_rule_simple_col
-- transform a rule with square and curly brackets to simple subrules 
AS
	v_return parser_grammar_rule_simple_col := parser_grammar_rule_simple_col();
    -- Static counter to ensure dynamically created subrule names are distinct
	v_lhs_root 	VARCHAR2(100) := p_lhs ;
	v_recurs_dept   NUMBER := 0;
	-- 
    -- Helper function to slice a space-delimited string into an array of tokens
    FUNCTION tokenize(p_str IN VARCHAR2) RETURN simple_vc100_col IS
        v_tokens simple_vc100_col := simple_vc100_col();
    BEGIN
        SELECT regexp_substr(p_str, '[^ ]+', 1, LEVEL)
        BULK COLLECT INTO v_tokens
        FROM dual
        CONNECT BY regexp_substr(p_str, '[^ ]+', 1, LEVEL) IS NOT NULL;
        RETURN v_tokens;
    END tokenize;
	-- 
	PROCEDURE push_row 
	( p_row 	IN parser_grammar_rule_simple_rec 
	) 
	AS 
	BEGIN 
		v_return.extend;
		v_return( v_return.count ) := p_row;
	END push_row; 
	--
    -- Recursive processor acting on individual tokens
    PROCEDURE process_tokens
		(p_current_lhs IN VARCHAR2
		,p_tokens IN simple_vc100_col
		) IS
        v_out_tokens    simple_vc100_col := simple_vc100_col();
        v_inner_tokens  simple_vc100_col;
        
        v_pos           NUMBER := 1;
        v_bracket_count NUMBER;
        v_match_pos     NUMBER;
        
        v_sub_rule      VARCHAR2(100);
        v_final_rhs     VARCHAR2(4000) := '';
    BEGIN
		v_recurs_dept := v_recurs_dept + 1;
        WHILE v_pos <= p_tokens.COUNT LOOP
            
            -- CASE 1: Found Optional Square Bracket [ ... ]
            IF p_tokens(v_pos) = '[' THEN
                v_bracket_count := 1;
                v_match_pos     := v_pos + 1;
                v_inner_tokens  := simple_vc100_col();
                
                WHILE v_match_pos <= p_tokens.COUNT AND v_bracket_count > 0 LOOP
                    IF p_tokens(v_match_pos) = '[' THEN v_bracket_count := v_bracket_count + 1; END IF;
                    IF p_tokens(v_match_pos) = ']' THEN v_bracket_count := v_bracket_count - 1; END IF;
                    
                    IF v_bracket_count > 0 THEN
                        v_inner_tokens.EXTEND;
                        v_inner_tokens(v_inner_tokens.LAST) := p_tokens(v_match_pos);
                    END IF;
                    v_match_pos := v_match_pos + 1;
                END LOOP;
                
                -- Generate unique subrule ID
                --v_sub_rule := 'G_OPT_' || TO_CHAR(DBMS_RANDOM.VALUE(1000, 9999), 'FM9999');
                v_sub_rule := 'G_OPT_' || TO_CHAR( v_recurs_dept, 'FM9999');
                
                v_out_tokens.EXTEND;
                v_out_tokens(v_out_tokens.LAST) := v_sub_rule;
                
                -- Path A: Process the interior recursively 
                process_tokens(v_sub_rule, v_inner_tokens);
                -- Path B: The empty/null rule variation
                --INSERT INTO parser_grammar_rule_simple (lhs, lhs_root, rhs, subrule_no	, source ) 
				--	VALUES (v_sub_rule, v_lhs_root, 'null', 2,	p_source);
				push_row( parser_grammar_rule_simple_rec
					(lhs=> 			v_sub_rule
					,rhs=>			'null' 
					,lhs_root=>		v_lhs_root 
					,subrule_no=>	2 
					,source=>		p_source 
					) );
                v_pos := v_match_pos;

            -- CASE 2: Found Repetition Curly Brace { ... }*
            ELSIF p_tokens(v_pos) = '{' THEN
                v_bracket_count := 1;
                v_match_pos     := v_pos + 1;
                v_inner_tokens  := simple_vc100_col();
                
                WHILE v_match_pos <= p_tokens.COUNT AND v_bracket_count > 0 LOOP
                    IF p_tokens(v_match_pos) = '{' THEN v_bracket_count := v_bracket_count + 1; END IF;
                    IF p_tokens(v_match_pos) = '}' THEN v_bracket_count := v_bracket_count - 1; END IF;
                    
                    IF v_bracket_count > 0 THEN
                        v_inner_tokens.EXTEND;
                        v_inner_tokens(v_inner_tokens.LAST) := p_tokens(v_match_pos);
                    END IF;
                    v_match_pos := v_match_pos + 1;
                END LOOP;
                
                -- Consume the trailing Kleene star symbol if present
                IF v_match_pos <= p_tokens.COUNT AND p_tokens(v_match_pos) = '*' THEN
                    v_match_pos := v_match_pos + 1;
                END IF;
                
               -- v_sub_rule := 'G_LST_' || TO_CHAR(DBMS_RANDOM.VALUE(1000, 9999), 'FM9999');
                v_sub_rule := 'G_LST_' || TO_CHAR( v_recurs_dept, 'FM9999');
                
                v_out_tokens.EXTEND;
                v_out_tokens(v_out_tokens.LAST) := v_sub_rule;
                
                -- Add self-reference token to the array for recursive list extension: { X }* -> X G_LST
                v_inner_tokens.EXTEND;
                v_inner_tokens(v_inner_tokens.LAST) := v_sub_rule;
                
                -- Path A: Subrule points to its contents + loop
                process_tokens(v_sub_rule, v_inner_tokens);
                -- Path B: Subrule drops out to empty
                --INSERT INTO parser_grammar_rule_simple (lhs, lhs_root, rhs, subrule_no	, source ) 
				--		VALUES (	v_sub_rule, 	v_lhs_root, 'null', 2,		p_source);
				push_row ( parser_grammar_rule_simple_rec
					(lhs=> 			v_sub_rule
					,lhs_root =>	v_lhs_root 
					,rhs=>			'null' 
					,subrule_no=>	2 
					,source=>		p_source 
					) );
                --
                v_pos := v_match_pos;

            -- CASE 3: Standard Terminal/Non-terminal item
            ELSE
                v_out_tokens.EXTEND;
                v_out_tokens(v_out_tokens.LAST) := p_tokens(v_pos);
                v_pos := v_pos + 1;
            END IF;
        END LOOP;

        -- Reassemble tokens back into a flat string sequence separated by spaces
        IF v_out_tokens.COUNT > 0 THEN
            FOR i IN 1..v_out_tokens.COUNT LOOP
                v_final_rhs := v_final_rhs || v_out_tokens(i) || ' ';
            END LOOP;
            v_final_rhs := RTRIM(v_final_rhs);
            
            --INSERT INTO parser_grammar_rule_simple (lhs, lhs_root, rhs, subrule_no, 	source)
            --VALUES (p_current_lhs, v_lhs_root, v_final_rhs, 1,	p_source );
			push_row ( parser_grammar_rule_simple_rec
				(lhs=> 			p_current_lhs
				,rhs=>			v_final_rhs
				,lhs_root=>		v_lhs_root 
				,subrule_no=>	1 
				,source=>		p_source 
				) );
        END IF;
    END process_tokens;
-- 
BEGIN
	-- dummy implementation 
	IF false THEN 
		FOR r IN (
			SELECT * FROM parser_grammar_rule_simple
		) LOOP
			push_row ( parser_grammar_rule_simple_rec(
					r.lhs,
					r.rhs,
					r.lhs_root,
					r.subrule_no,
					r.source
			));
		END LOOP;
	END IF; 
    -- Kick off execution by tokenizing our string entry point
    process_tokens
		(p_current_lhs 	=> p_lhs 
		,p_tokens 		=> tokenize(p_rhs)
		);
	-- 
	-- push self 
	push_row ( parser_grammar_rule_simple_rec
				(lhs=> 			p_lhs
				,rhs=>			p_rhs
				,lhs_root=>		p_lhs  
				,subrule_no=>	0
				,source=>		p_source 
				) );
	-- 
    RETURN v_return;
END fn_1_ebnf_to_simple_upto_20260605;
--
FUNCTION fn_1_ebnf_to_simple
(   p_lhs 		IN VARCHAR2
   ,p_rhs 		IN VARCHAR2
   ,p_source 	IN VARCHAR2
)
RETURN parser_grammar_rule_simple_col
-- transform a rule with square or curly brackets or optionals to simple subrules 
AS
	v_return parser_grammar_rule_simple_col :=  parser_grammar_rule_simple_col();
    -- Types to handle the processing queue
    TYPE rule_rec IS RECORD (
        lhs VARCHAR2(1000),
        rhs VARCHAR2(4000)
    );
    TYPE rule_table IS TABLE OF rule_rec;
    
    v_working_rules  rule_table := rule_table();
    v_current_idx    NUMBER := 1;
    v_counter        NUMBER := 0;      -- Counter for unique non-terminal suffixes <opt_n>, <rep_n>
    v_rule_seq       NUMBER := 1;      -- Sequential generator for rule_number column
	-- 
	PROCEDURE push_row 
	( p_row 	IN parser_grammar_rule_simple_rec 
	) 
	AS 
	BEGIN 
		v_return.extend;
		v_return( v_return.count ) := p_row;
	END push_row; 
    
    -- Inner helper procedure to resolve nested brackets recursively
    PROCEDURE process_brackets(p_target_rhs IN OUT VARCHAR2) IS
        v_open_bracket  NUMBER := 0;
        v_close_bracket NUMBER := 0;
        v_bracket_type  VARCHAR2(1);
        v_inner_content VARCHAR2(4000);
        v_new_rule_name VARCHAR2(100);
        v_level         NUMBER := 0;
    BEGIN
        -- Find the first outermost opening bracket
        FOR i IN 1..LENGTH(p_target_rhs) LOOP
            IF SUBSTR(p_target_rhs, i, 1) IN ('[', '{') AND v_level = 0 THEN
                v_open_bracket := i;
                v_bracket_type := SUBSTR(p_target_rhs, i, 1);
                v_level := 1;
            ELSIF SUBSTR(p_target_rhs, i, 1) IN ('[', '{') THEN
                v_level := v_level + 1;
            ELSIF SUBSTR(p_target_rhs, i, 1) IN (']', '}') THEN
                v_level := v_level - 1;
                IF v_level = 0 AND SUBSTR(p_target_rhs, i, 1) = 
                   CASE v_bracket_type WHEN '[' THEN ']' WHEN '{' THEN '}' END THEN
                    v_close_bracket := i;
                    EXIT;
                END IF;
            END IF;
        END LOOP;

        -- If an outermost structure is caught, decouple it into a new sub-rule
        IF v_open_bracket > 0 THEN
            v_inner_content := SUBSTR(p_target_rhs, v_open_bracket + 1, v_close_bracket - v_open_bracket - 1);
            v_counter := v_counter + 1;
            
            IF v_bracket_type = '[' THEN
                v_new_rule_name := '<opt_' || v_counter || '>';
                
                -- Queue up the sub-rule: <opt_n> ::= inner_content | ;
                v_working_rules.EXTEND;
                v_working_rules(v_working_rules.LAST).lhs := v_new_rule_name;
                v_working_rules(v_working_rules.LAST).rhs := v_inner_content || ' | ;';
                
                -- Patch the parent rule to point to this sub-rule name
                p_target_rhs := SUBSTR(p_target_rhs, 1, v_open_bracket - 1) || v_new_rule_name || SUBSTR(p_target_rhs, v_close_bracket + 1);
                
            ELSIF v_bracket_type = '{' AND SUBSTR(p_target_rhs, v_close_bracket + 1, 1) = '*' THEN
                v_new_rule_name := '<rep_' || v_counter || '>';
                
                -- Queue up the sub-rule: <rep_n> ::= inner_content <rep_n> | ;
                v_working_rules.EXTEND;
                v_working_rules(v_working_rules.LAST).lhs := v_new_rule_name;
                v_working_rules(v_working_rules.LAST).rhs := v_inner_content || ' ' || v_new_rule_name || ' | ;';
                
                -- Patch the parent rule to point to this sub-rule name
                p_target_rhs := SUBSTR(p_target_rhs, 1, v_open_bracket - 1) || v_new_rule_name || SUBSTR(p_target_rhs, v_close_bracket + 2);
            END IF;
            
            -- Recurse in case there are subsequent brackets in the same text block
            process_brackets(p_target_rhs);
        END IF;
    END process_brackets;

BEGIN
    -- Initialize the process directly with the passed arguments
    v_working_rules.EXTEND;
    v_working_rules(v_working_rules.LAST).lhs := TRIM(p_lhs);
    v_working_rules(v_working_rules.LAST).rhs := TRIM(p_rhs);
    
    -- 1. Flatten all brackets down sequentially
    WHILE v_current_idx <= v_working_rules.COUNT LOOP
        process_brackets(v_working_rules(v_current_idx).rhs);
        v_current_idx := v_current_idx + 1;
    END LOOP;
    
    -- 2. Break remaining choices apart at '|' boundaries and INSERT directly into the destination table
    FOR i IN 1..v_working_rules.COUNT LOOP
        DECLARE
            v_final_lhs VARCHAR2(1000) := v_working_rules(i).lhs;
            v_final_rhs VARCHAR2(4000) := v_working_rules(i).rhs;
            v_alt_start NUMBER := 1;
            v_alt_text  VARCHAR2(4000);
        BEGIN
            FOR j IN 1..LENGTH(v_final_rhs) + 1 LOOP
                IF j > LENGTH(v_final_rhs) OR SUBSTR(v_final_rhs, j, 1) = '|' THEN
                    v_alt_text := TRIM(SUBSTR(v_final_rhs, v_alt_start, j - v_alt_start));
                    -- Clean up any consecutive whitespace strings
                    v_alt_text := REGEXP_REPLACE(v_alt_text, '\s+', ' ');
                    
                    -- Database insertion target
                    --INSERT INTO temp_bnf_rules (lhs, rule_number, rhs)
                    --VALUES (v_final_lhs, v_rule_seq, v_alt_text);
					push_row( parser_grammar_rule_simple_rec
						(lhs=> 			v_final_lhs
						,rhs=>			v_alt_text
						,lhs_root=>		p_lhs 
						,subrule_no=>	v_rule_seq 
						,source=>		p_source 
						) );
					--
                    v_rule_seq  := v_rule_seq + 1;
                    v_alt_start := j + 1;
                END IF;
            END LOOP;
        END;
    END LOOP;
	push_row( parser_grammar_rule_simple_rec
		(lhs=> 			p_lhs 
		,rhs=>			p_rhs 
		,lhs_root=>		p_lhs 
		,subrule_no=>	0
		,source=>		p_source 
		) );
	--
	RETURN v_return;
END fn_1_ebnf_to_simple;
--
END;	-- package 
/

