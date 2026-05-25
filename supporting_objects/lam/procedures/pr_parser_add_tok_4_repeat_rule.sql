REM this procedure is rendered obsolete by pr_transform_ebnf_to_simple.sql
/*
CREATE OR REPLACE PROCEDURE pr_parser_add_tok_4_repeat_rule 
(    p_lhs          IN VARCHAR2
    ,p_rhs_tokens   IN parser_rule_token_col
    ,p_source       IN VARCHAR2 
) IS
    v_tail_name  VARCHAR2(60);
    
    -- Arrays to hold split tokens
    v_base_tokens parser_rule_token_col := parser_rule_token_col();
    v_loop_tokens parser_rule_token_col := parser_rule_token_col();
    
    -- State tracker
    v_inside_loop BOOLEAN := FALSE;
    v_pos         NUMBER := 1;
BEGIN
    DELETE parser_alt_token 
    WHERE lower( p_source )   = source 
      AND lower ( p_lhs )     = lhs 
      ;
    -- 1. Derive the tail rule name dynamically (e.g., <a> -> <a_tail>)
    v_tail_name := REPLACE(p_lhs, '>', '_tail>');

    -- 2. Categorize tokens based on whether they sit inside curly braces
    FOR i IN 1 .. p_rhs_tokens.COUNT LOOP
        IF p_rhs_tokens(i).content = '{' THEN
            v_inside_loop := TRUE;
        ELSIF p_rhs_tokens(i).content = '}' THEN
            v_inside_loop := FALSE;
        ELSE
            -- Distribute tokens into respective bins
            IF NOT v_inside_loop THEN
                v_base_tokens.EXTEND;
                v_base_tokens(v_base_tokens.COUNT) := p_rhs_tokens(i);
            ELSE
                v_loop_tokens.EXTEND;
                v_loop_tokens(v_loop_tokens.COUNT) := p_rhs_tokens(i);
            END IF;
        END IF;
    END LOOP;

    -------------------------------------------------------------------
    -- STEP 3: Populate Table X for the Base Rule (<a> ::= <b> <a_tail>)
    -------------------------------------------------------------------
    v_pos := 1;
    FOR i IN 1 .. v_base_tokens.COUNT LOOP
        INSERT INTO parser_alt_token (lhs, alt_no, position, symbol,    source)
        VALUES (p_lhs, 1, v_pos, v_base_tokens(i).content,  p_source);
        v_pos := v_pos + 1;
    END LOOP;
    
    -- Append the pointer to the virtual tail rule at the end of the base sequence
    INSERT INTO parser_alt_token (lhs, alt_no, position, symbol,    source )
    VALUES (p_lhs, 1, v_pos, v_tail_name,   p_source );


    -------------------------------------------------------------------
    -- STEP 4: Populate Table X for Tail Alt 1 (<a_tail> ::= , <b> <a_tail>)
    -------------------------------------------------------------------
    v_pos := 1;
    FOR i IN 1 .. v_loop_tokens.COUNT LOOP
        INSERT INTO parser_alt_token (lhs, alt_no, position, symbol, source)
        VALUES (v_tail_name, 1, v_pos, v_loop_tokens(i).content,    p_source);
        v_pos := v_pos + 1;
    END LOOP;
    
    -- Append the self-recursive tail pointer
    INSERT INTO parser_alt_token (lhs, alt_no, position, symbol,    source)
    VALUES (v_tail_name, 1, v_pos, v_tail_name, p_source);


    -------------------------------------------------------------------
    -- STEP 5: Populate Table X for Tail Alt 2 (<a_tail> ::= epsilon)
    -------------------------------------------------------------------
    INSERT INTO parser_alt_token (lhs, alt_no, position, symbol,    source)
    VALUES (v_tail_name, 2, 1, 'epsilon',       p_source );

END;
/

*/ 