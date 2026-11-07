SET SERVEROUTPUT ON SIZE UNLIMITED;

DECLARE
    -- Helper procedure to run and display test results
    PROCEDURE run_test (
        p_test_name  IN VARCHAR2,
        p_tokens     IN sys.odciVarchar2List
    ) IS
        v_type       VARCHAR2(20);
        v_open_idx   NUMBER;
        v_close_idx  NUMBER;
        v_token_str  VARCHAR2(4000) := '';
    BEGIN
        -- Build a readable string of the input tokens
        IF p_tokens IS NOT NULL AND p_tokens.COUNT > 0 THEN
            FOR i IN 1..p_tokens.COUNT LOOP
                v_token_str := v_token_str || '''' || p_tokens(i) || ''' ';
            END LOOP;
        ELSE
            v_token_str := '[EMPTY OR NULL]';
        END IF;

        -- Call the target procedure
        pr_locate_first_bracket_pair(
            p_input_tokens => p_tokens,
            po_type        => v_type,
            po_open_idx    => v_open_idx,
            po_close_idx   => v_close_idx
        );

        -- Print the test summary
        DBMS_OUTPUT.PUT_LINE('--------------------------------------------------');
        DBMS_OUTPUT.PUT_LINE('Test Case : ' || p_test_name);
        DBMS_OUTPUT.PUT_LINE('Inputs    : (' || TRIM(v_token_str) || ')');
        DBMS_OUTPUT.PUT_LINE('Outputs   : po_type = ' || NVL(v_type, 'NULL') || 
                             ' | po_open_idx = ' || NVL(TO_CHAR(v_open_idx), 'NULL') || 
                             ' | po_close_idx = ' || NVL(TO_CHAR(v_close_idx), 'NULL'));
    END run_test;

BEGIN
    DBMS_OUTPUT.PUT_LINE('=== STARTING BRACKET PAIR TESTS ===');

    -- Test 1: Simple Round Brackets
    run_test(
        'Simple Round Brackets',
        sys.odciVarchar2List('SELECT', '(', 'id', ',', 'name', ')', 'FROM', 'users')
    );

    -- Test 2: Nested/Mixed Brackets (First *completed* pair should match inner square brackets)
    run_test(
        'Nested and Mixed Brackets',
        sys.odciVarchar2List('{', 'a', '[', 'b', '(', 'c', ')', ']', '}')
    );

    -- Test 3: Square Brackets Appearing First
    run_test(
        'Square Brackets First',
        sys.odciVarchar2List('arr', '[', '0', ']', '(', '1', ')')
    );

    -- Test 4: Curly Brackets Only
    run_test(
        'Curly Brackets Only',
        sys.odciVarchar2List('BEGIN', '{', 'x', ':=', '1', ';', '}', 'END')
    );

    -- Test 5: 
    run_test(
        'Curly Brackets Only with comma',
		sys.odciVarchar2List('{', '","', 'expression', '}')
    );
/*
    -- Test 15: Mismatched Brackets (Should return NULL)
    run_test(
        'Mismatched Brackets',
        sys.odciVarchar2List('(', ']', '(', ')')
    );

    -- Test 16: Unclosed Brackets (Should return NULL)
    run_test(
        'Unclosed Brackets',
        sys.odciVarchar2List('(', 'a', '+', 'b')
    );

    -- Test 17: Empty Token List
    run_test(
        'Empty Token List',
        sys.odciVarchar2List()
    );
*/ 
    DBMS_OUTPUT.PUT_LINE('=== TESTS COMPLETED ===');
END;
/