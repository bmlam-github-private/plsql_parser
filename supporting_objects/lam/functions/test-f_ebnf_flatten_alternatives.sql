SET SERVEROUTPUT ON SIZE UNLIMITED;

DECLARE
    v_results parser_grammar_rule_simple_col;
    
    PROCEDURE run_test 
    ( p_test_name  VARCHAR2
     ,p_lhs        VARCHAR2
     ,p_lhs_root   VARCHAR2
     ,p_tokens     sys.odciVarchar2List
    ) IS
		v_input_rhs Varchar2( 4000 );
    BEGIN
		SELECT listagg( column_value, ' ' ) WITHIN GROUP ( ORDER BY rownum )
		INTO v_input_rhs 
		FROM TABLE ( p_tokens )
		;
        dbms_output.put_line('--------------------------------------------------');
        dbms_output.put_line('TEST CASE: ' || p_test_name);
        dbms_output.put_line('Input RHS : ' || v_input_rhs);
        dbms_output.put_line('--------------------------------------------------');
        
        v_results := f_ebnf_flatten_alternatives(
                          p_lhs        => p_lhs
                         ,p_lhs_root   => p_lhs_root
                         ,p_rhs_tokens => p_tokens
                     );
                     
        IF v_results.COUNT = 0 THEN
            dbms_output.put_line('Result: (No rows returned)');
        ELSE
            FOR i IN 1..v_results.COUNT LOOP
                dbms_output.put_line(
                    'Row ' || i || ': ' ||
                    'LHS=' || v_results(i).lhs || ' | ' ||
                    'RHS=' || v_results(i).rhs || ' | ' ||
                    --'Root=' || v_results(i).lhs_root || ' | ' ||
                    'Subrule=' || v_results(i).subrule_no
                );
            END LOOP;
        END IF;
        dbms_output.put_line(CHR(10));
    END;
BEGIN
/*
    -- Test Case 1: Simple binary alternative (A | B)
    run_test(
        p_test_name => '1. Binary Alternative (A | B)',
        p_lhs       => 'expression',
        p_lhs_root  => 'expr_root',
        p_tokens    => sys.odciVarchar2List('term_a', '|', 'term_b')
    );
*/ 

    -- Test Case 2: Multiple chained alternatives (A | B | C)
    run_test(
        p_test_name => '2. Multiple Alternatives (A | B | C)',
        p_lhs       => 'statement',
        p_lhs_root  => 'stmt_root',
        p_tokens    => sys.odciVarchar2List('if_stmt', '|', 'while_stmt', '|', 'assignment')
    );
/*	
    -- Test Case 3: No alternatives (Plain sequence: A B C)
    run_test(
        p_test_name => '3. No Alternatives (Plain Sequence)',
        p_lhs       => 'assignment',
        p_lhs_root  => 'assign_root',
        p_tokens    => sys.odciVarchar2List('identifier', ':=', 'expression')
    );

    -- Test Case 4: Single token
    run_test(
        p_test_name => '4. Single Token',
        p_lhs       => 'factor',
        p_lhs_root  => 'factor_root',
        p_tokens    => sys.odciVarchar2List('number')
    );
	*/ 
END;
/