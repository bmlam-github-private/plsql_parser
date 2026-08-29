CREATE OR REPLACE procedure test_split_helper 
( p_string VARCHAR2 
 ,p_delim  VARCHAR2 
)
AS
	v_result mistral_ebnf_simplifier.table_of_vc4k;
BEGIN 
    DBMS_OUTPUT.PUT_LINE('p_string '||p_string);
    DBMS_OUTPUT.PUT_LINE('p_delim "'||p_delim||'"');
	v_result := mistral_ebnf_simplifier.split_by_delimiter( p_string , p_delim );
	dbms_output.put_line ( 'p_string:'||$$plsql_line||' v_result.count:'||v_result.count );
        FOR i IN 1..v_result.COUNT LOOP
            DBMS_OUTPUT.PUT_LINE(
                RPAD((i), 28) || ': ' || v_result(i)
            );
        END LOOP;
        DBMS_OUTPUT.PUT_LINE('');
END;
/ 
--
