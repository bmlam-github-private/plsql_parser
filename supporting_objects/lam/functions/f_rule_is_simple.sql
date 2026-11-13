CREATE OR REPLACE FUNCTION f_rule_is_simple 
( p_rule_tokens   IN sys.odciVarchar2List 
) RETURN VARCHAR2 
-- Returns 
-- SQUARE_BRK if of brackets only a pair of square brackets is present 
-- CURLY_BRK  if of brackets only a pair of CURLY brackets is present 
-- PIPES      if no brackets are present and only pipes (for alternatives) are present 
-- SIMPLE     if no brackets and no pipes (for alternatives) are present 
-- NOT_SIMPLE if none of the above condition is true 
/* Gemini added logic: 		WHICH I OBJECTED! 
Outer Boundary Verification: For SQUARE_BRK and CURLY_BRK, it checks that the opening and closing brackets 
cleanly wrap the rule (p_rule_tokens(1) and p_rule_tokens(COUNT)), which is standard 
for identifying simple optional or repetition rules in EBNF simplification.
*/ 
AS 
    v_round_open   PLS_INTEGER := 0;
    v_round_close  PLS_INTEGER := 0;
    v_curly_open   PLS_INTEGER := 0;
    v_curly_close  PLS_INTEGER := 0;
    v_square_open  PLS_INTEGER := 0;
    v_square_close PLS_INTEGER := 0;
    v_pipe_count   PLS_INTEGER := 0;
    v_token        VARCHAR2(4000);
BEGIN 
    IF p_rule_tokens IS NULL OR p_rule_tokens.COUNT = 0 THEN
        RETURN 'SIMPLE';
    END IF;

    -- Count occurrences of brackets and pipes
    FOR i IN 1..p_rule_tokens.COUNT LOOP
        v_token := p_rule_tokens(i);
        IF    v_token = '(' THEN v_round_open   := v_round_open 	+ 1;
        ELSIF v_token = ')' THEN v_round_close  := v_round_close	+ 1;
        ELSIF v_token = '{' THEN v_curly_open   := v_curly_open 	+ 1;
        ELSIF v_token = '}' THEN v_curly_close  := v_curly_close 	+ 1;
        ELSIF v_token = '[' THEN v_square_open  := v_square_open 	+ 1;
        ELSIF v_token = ']' THEN v_square_close := v_square_close 	+ 1;
        ELSIF v_token = '|' THEN v_pipe_count   := v_pipe_count 	+ 1;
        END IF;
    END LOOP;
	/*
dbms_output.put_line ( $$plsql_unit||':'$$plsql_line
		||' v_round_open: '||   v_round_open 
		||' v_round_close: '||  v_round_close
		||' v_curly_open: '||   v_curly_open 
		||' v_curly_close: '||  v_curly_close
		||' v_square_open: '||  v_square_open
		||' v_square_close: '|| v_square_close
		||' v_pipe_count: '||   v_pipe_count 
		);
*/
    -- 1. Check SQUARE_BRK: Exactly one pair of square brackets, no other brackets, and wraps the rule
    IF v_round_open = 0 AND v_round_close = 0 AND
       v_curly_open = 0 AND v_curly_close = 0 AND
       v_square_open = 1 AND v_square_close = 1 AND 
       v_pipe_count = 0 	THEN
	RETURN 'SQUARE_BRK';
    END IF;
    -- 2. Check CURLY_BRK: Exactly one pair of curly brackets, no other brackets, and wraps the rule
    IF v_round_open = 0 AND v_round_close = 0 AND
       v_square_open = 0 AND v_square_close = 0 AND
       v_curly_open = 1 AND v_curly_close = 1 AND 
       v_pipe_count = 0 	THEN
			RETURN 'CURLY_BRK';
    END IF;

    -- 3. Check PIPES: Zero brackets anywhere, but contains at least one alternative pipe
    IF v_round_open = 0 AND v_round_close = 0 AND
       v_curly_open = 0 AND v_curly_close = 0 AND
       v_square_open = 0 AND v_square_close = 0 AND
       v_pipe_count > 0 THEN
        RETURN 'PIPES';
    END IF;

    -- 4. No PIPES, Zero brackets 
    IF v_round_open = 0 AND v_round_close = 0 AND
       v_curly_open = 0 AND v_curly_close = 0 AND
       v_square_open = 0 AND v_square_close = 0 AND
       v_pipe_count = 0 THEN
        RETURN 'SIMPLE';
    END IF;

    -- 4. Default fallback
    RETURN 'NOT_SIMPLE';
END;
/ 

