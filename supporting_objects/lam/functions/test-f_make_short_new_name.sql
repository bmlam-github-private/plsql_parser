SET SERVEROUTPUT ON SIZE UNLIMITED;

DECLARE
    PROCEDURE test_name (
        p_test_desc VARCHAR2,
        p_prefix    VARCHAR2,
        p_tokens    sys.odciVarchar2List
    ) IS
		v_tokens VARCHAR2(1000);
    BEGIN
		SELECT listagg( column_value, ', ' ) WITHIN GROUP ( ORDER BY rownum )
		INTO v_tokens 
		FROM TABLE ( p_tokens )
		;
        dbms_output.put_line(p_test_desc );
        dbms_output.put_line( 'prfix: ' || p_prefix|| ' tokens: ' || v_tokens|| ' -> Result: ' || f_make_short_new_name(p_prefix, p_tokens));
    END;
BEGIN
    -- Test 1: Short string (<= 4 chars) with non-letters suppressed
    test_name(
        'Test 1 (Short string <= 4 with symbols)',
        'COL_',
        sys.odciVarchar2List('ab#1')
    );

    -- Test 2: Bracket present as first token (should be ignored, using next token)
    test_name(
        'Test 2 (Bracket ignored, short string)',
        'TBL_',
        sys.odciVarchar2List('(', 'declare_section', 'begin_block' ) -- length <= 4 after ignoring bracket
    );

    -- Test 3: Long string (> 4 chars) split by underscore (Consonants from 1st, 1st letter from rest)
    -- 'customer_order_date' -> cstmr (consonants) + o (from order) + d (from date) = cstmrod
    test_name(
        'Test 3 (Long string with underscores)',
        'IDX_',
        sys.odciVarchar2List('{', 'customer_order_date', 'foo' )
    );

    -- Test 4: Bracket present + long string (> 4 chars)
    test_name(
        'Test 4 (Bracket ignored + long string)',
        'VW_',
        sys.odciVarchar2List('[', 'employee_sal_det')
    );
END;
/