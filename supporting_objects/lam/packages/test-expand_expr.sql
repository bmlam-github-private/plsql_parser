CREATE OR REPLACE procedure test_expand_expr 
( p_string VARCHAR2 )
AS
	v_result mistral_ebnf_simplifier.table_of_vc4k;
	v_return sys.odcivarchar2List;
BEGIN 
	v_result := mistral_ebnf_simplifier.expand_expression( p_string , p_nesting => 0 );
	dbms_output.put_line ( 'p_string:'||$$plsql_line||' v_result.count:'||v_result.count );
        FOR i IN 1..v_return.COUNT LOOP
            DBMS_OUTPUT.PUT_LINE(
                RPAD((i), 28) || ': ' || v_return(i)
            );
        END LOOP;
        DBMS_OUTPUT.PUT_LINE('');
END;
/ 
--
