SET SERVEROUTPUT ON SIZE UNLIMITED;




column spool_file new_value spool_file 
SELECT '"c:\Users\Bon-Minh Lam\tmp\test-f_1_ebnf_to_simple_rules.lst"'  as spool_file
FROM dual;

spool &spool_file 
DECLARE
	v_results parser_grammar_rule_simple_col;
	
	PROCEDURE run_test 
	( p_test_name  VARCHAR2
	 ,p_lhs			VARCHAR2
	 ,p_rhs			VARCHAR2
	) IS
	BEGIN
		dbms_output.put_line('--------------------------------------------------');
		dbms_output.put_line('TEST CASE: ' || p_test_name);
		dbms_output.put_line('Input RHS : ' || p_rhs);
		dbms_output.put_line('--------------------------------------------------');
		
		v_results := f_1_ebnf_to_simple_rules(
						  p_lhs			=> p_lhs
						 ,p_source		=> 'TEST'
						 ,p_rhs       	=> p_rhs 
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
	-- Test Case 1: Integer with optional sign)
	run_test
		( p_test_name => '1: Integer with optional sign'
		 ,p_lhs		=> 'integer'
		 ,p_rhs		=> '[ "+" | "-" ] digit { digit }'
		);
END;
/
spool off 

prompt spool_file : &spool_file
