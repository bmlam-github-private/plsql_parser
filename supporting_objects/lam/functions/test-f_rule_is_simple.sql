
SET SERVEROUTPUT ON SIZE UNLIMITED;

DECLARE
    -- Helper procedure to run a test case and print the result
    PROCEDURE run_test (
        p_test_name  IN VARCHAR2,
        p_tokens     IN sys.odciVarchar2List
    ) IS
        v_result     VARCHAR2(100);
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

        -- Call the function
        v_result := f_rule_is_simple(p_tokens);

        -- Print the test summary
        DBMS_OUTPUT.PUT_LINE('--------------------------------------------------');
        DBMS_OUTPUT.PUT_LINE('Test Case : ' || p_test_name);
        DBMS_OUTPUT.PUT_LINE('Inputs    : (' || TRIM(v_token_str) || ')');
        DBMS_OUTPUT.PUT_LINE('Result    : ' || v_result);
    END run_test;

BEGIN
    DBMS_OUTPUT.PUT_LINE('=== STARTING f_rule_is_simple TESTS ===');
if false then 
    -- Test 1: Simple Square Brackets (Wrapping entire rule)
    run_test(
        'Simple Square Brackets (Valid)',
        sys.odciVarchar2List('[', 'identifier', ']')
    );

    -- Test 2: Simple Curly Brackets (Wrapping entire rule)
    run_test(
        'Simple Curly Brackets (Valid)',
        sys.odciVarchar2List('{', 'expression', '}')
    );

    -- Test 3: Pipes Only (No brackets, contains alternative pipe)
    run_test(
        'Pipes Only (Valid alternatives)',
        sys.odciVarchar2List('term1', '|', 'term2', '|', 'term3')
    );

    -- Test 4: Not Simple - Brackets do not wrap the entire rule
    run_test(
        'Brackets Inside (Not wrapping ends)',
        sys.odciVarchar2List('SELECT', '[', 'column', ']', 'FROM', 't')
    );

    -- Test 5: Not Simple - Multiple pairs of brackets
    run_test(
        'Multiple Pairs of Brackets',
        sys.odciVarchar2List('[', 'a', ']', '[', 'b', ']')
    );

    -- Test 6: Not Simple - Mixed bracket types
    run_test(
        'Mixed Bracket Types',
        sys.odciVarchar2List('[', '{', 'a', '}', ']')
    );
end if;
    -- Test 7: Simple - Plain text (No brackets, no pipes)
    run_test(
        'Plain Tokens (No brackets/pipes)',
        sys.odciVarchar2List('SELECT', '*', 'FROM', 'dual')
    );

    -- Test 8: Empty Token List
    run_test(
        'Empty Token List',
        sys.odciVarchar2List()
    );

    -- Test 9: Pipes bracketed by squares
    run_test(
        'Pipes bracketed by squares',
        sys.odciVarchar2List( '[', '"+"' , '|' , '"-"' , ']' )
    );

    DBMS_OUTPUT.PUT_LINE('=== TESTS COMPLETED ===');
END;
/