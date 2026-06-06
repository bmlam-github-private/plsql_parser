CREATE TABLE temp_bnf_rules (
    lhs         VARCHAR2(1000),
    rule_number NUMBER,
    rhs         VARCHAR2(4000)
);


CREATE OR REPLACE PROCEDURE transform_and_insert_ebnf (
    p_lhs VARCHAR2,
    p_rhs VARCHAR2
) IS
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
                    INSERT INTO temp_bnf_rules (lhs, rule_number, rhs)
                    VALUES (v_final_lhs, v_rule_seq, v_alt_text);
                    
                    v_rule_seq  := v_rule_seq + 1;
                    v_alt_start := j + 1;
                END IF;
            END LOOP;
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

-- Verify the result 
SELECT lhs, rule_number, rhs FROM temp_bnf_rules ORDER BY rule_number;
-- Query the table to verify your output results
SELECT lhs, rule_number, rhs FROM temp_bnf_rules ORDER BY rule_number;