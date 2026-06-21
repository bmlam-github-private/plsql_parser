CREATE OR REPLACE FUNCTION fn_split_by_whitespaces (
    p_string IN VARCHAR2
) RETURN apex_t_varchar2 PIPELINED 
IS
    l_token  VARCHAR2(4000);
    l_index  BINARY_INTEGER := 1;
BEGIN
    -- Return an empty collection immediately if the input string is null
    IF p_string IS NULL THEN
        RETURN;
    END IF;

    LOOP
        -- Extract the i-th token matching non-whitespace sequences (\S+)
        l_token := REGEXP_SUBSTR(p_string, '\S+', 1, l_index);
        
        -- Exit the loop when no more tokens are found
        EXIT WHEN l_token IS NULL;
        
        -- Pipe the token out to the consumer
        PIPE ROW (l_token);
        
        l_index := l_index + 1;
    END LOOP;
    
    RETURN;
END;
/