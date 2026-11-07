CREATE OR REPLACE PROCEDURE pr_locate_first_bracket_pair 
(	p_input_tokens   	sys.odciVarchar2List
   ,po_type			OUT VARCHAR2 
   ,po_open_idx 	OUT NUMBER 
   ,po_close_idx 	OUT NUMBER 
) 
AS 
/* locate the position of the first pair of brackets in p_input_tokens, be they round, curly or square
	but open and close bracket must match in type.
	po_type is set to 
	* SQUARE_BRK  	if square brackets are first found 
	* ROUND_BRK  	if ROUND brackets are first found 
	* CURLY_BRK  	if CURLY brackets are first found 
	* NULL          if no pair is found 
	po_open_idx is the position of the open bracket 
	po_close_idx is the position of the close bracket 
*/
    v_token      VARCHAR2(4000);
    l_target_type VARCHAR2(20) := NULL;
    l_depth      PLS_INTEGER := 0;
BEGIN 
    -- Initialize output parameters
    po_type      := NULL;
    po_open_idx  := NULL;
    po_close_idx := NULL;

    IF p_input_tokens IS NULL OR p_input_tokens.COUNT = 0 THEN
        RETURN;
    END IF;

    -- Step 1: Scan left-to-right to find the VERY FIRST opening bracket
    FOR i IN 1..p_input_tokens.COUNT LOOP
        v_token := p_input_tokens(i);
        
        IF v_token IN ('(', '{', '[') THEN
            po_open_idx := i;
            IF v_token = '(' THEN
                po_type := 'ROUND_BRK';
            ELSIF v_token = '{' THEN
                po_type := 'CURLY_BRK';
            ELSE
                po_type := 'SQUARE_BRK';
            END IF;
            l_target_type := po_type;
            EXIT; -- Found our outermost opener
        END IF;
    END LOOP;
--dbms_output.put_line ( $$plsql_unit||':'||$$plsql_line||' xx: '||xx );
--dbms_output.put_line ( $$plsql_unit||':'||$$plsql_line||' po_type: '||po_type ||' po_open_idx: '||po_open_idx );
    -- If no opening bracket was found at all, exit
    IF po_open_idx IS NULL THEN
        RETURN;
    END IF;

    -- Step 2: From the opening index onwards, track depth to find its matching closer
    l_depth := 0;
    FOR i IN po_open_idx..p_input_tokens.COUNT LOOP
        v_token := p_input_tokens(i);
 --dbms_output.put_line ( $$plsql_unit||':'||$$plsql_line||' v_token: '||v_token||' l_depth: '||l_depth );
       
        -- Check opening of the SAME type
        IF (l_target_type = 'ROUND_BRK' AND v_token = '(') OR
           (l_target_type = 'CURLY_BRK'  AND v_token = '{') OR
           (l_target_type = 'SQUARE_BRK' AND v_token = '[') THEN
            l_depth := l_depth + 1;
            
        -- Check closing of the SAME type
        ELSIF (l_target_type = 'ROUND_BRK' AND v_token = ')') OR
              (l_target_type = 'CURLY_BRK'  AND v_token = '}') OR
              (l_target_type = 'SQUARE_BRK' AND v_token = ']') THEN
            l_depth := l_depth - 1;
            
            -- When depth drops back to 0, we found the matching outermost closer
            IF l_depth = 0 THEN
                po_close_idx := i;
                RETURN;
            END IF;
        END IF;
    END LOOP;

    -- If we loop through and never hit depth 0, the bracket was unclosed
    -- Reset outputs to indicate no valid complete pair was found
    po_type      := NULL;
    po_open_idx  := NULL;
    po_close_idx := NULL;
END;
/   
