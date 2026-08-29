CREATE OR REPLACE FUNCTION test_mistral
( p_string VARCHAR2 )
RETURN sys.odcivarchar2List
AS
	v_result mistral_ebnf_simplifier.table_of_vc4k;
	v_return sys.odcivarchar2List;
BEGIN 
	v_result := mistral_ebnf_simplifier.expand_expression( p_string , p_nesting => 0 );
	dbms_output.put_line ( $$PLSQL_UNIT||':'||$$plsql_line||' v_result.count:'||v_result.count );
	v_RETURN := mistral_ebnf_simplifier.get_object_col( v_result );
	v_return.extend;
	v_return( v_return.last ) := 'buuh';
	return v_return;
END;
/ 
--
