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
        
        v_results :=  f_ebnf_flatten_repetition 
				( p_lhs			=> p_lhs 
				 ,p_lhs_root	=> p_lhs_root 
				 ,p_rhs_tokens	=> p_tokens 
				 ,p_open_idx	=> NULL 
				 ,p_close_idx	=> NULL 
				 --,p_source  VARCHAR2 DEFAULT 'DUMMY'
				) ;
                     
        IF v_results.COUNT = 0 THEN
            dbms_output.put_line('Result: (No rows returned)');
        ELSE
            FOR i IN 1..v_results.COUNT LOOP
                dbms_output.put_line(
                    'Row ' || i || ': ' || ' Subrule=' || v_results(i).subrule_no ||chr(10)
                    ||'  LHS=' || v_results(i).lhs ||chr(10)
                    ||'  RHS=' || v_results(i).rhs ||chr(10)
                    --'Root=' || v_results(i).lhs_root || ' | ' ||
                );
            END LOOP;
        END IF;
        dbms_output.put_line(CHR(10));
    END run_test;
BEGIN
    -- Test Case 1a: simple argument_list 
    run_test(
        p_test_name => '1a: simple argument_list',
        p_lhs       => 'arg_list',
        p_lhs_root  => 'arg_list',
        p_tokens    => sys.odciVarchar2List('{', '","', 'expression', '}')
    );
    -- Test Case 1b: simple argument_list 
    run_test(
        p_test_name => '1b: simple argument_list',
        p_lhs       => 'arg_list',
        p_lhs_root  => 'arg_list',
        p_tokens    => sys.odciVarchar2List('expression', '{', '","', 'expression', '}')
    );
	--
    -- Test Case 2: basic_select_stmt 
    run_test(
        p_test_name => '2: basic_select_stmt',
        p_lhs       => 'basic_select_stmt',
        p_lhs_root  => 'SELECT_rule',
        p_tokens    => sys.odciVarchar2List('"SELECT"', 'column_expr', '{', '","', 'column_expr', '}', 'from_tail')
    );
END;
/