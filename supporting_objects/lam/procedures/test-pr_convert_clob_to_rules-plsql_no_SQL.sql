declare 
	v_text CLOB;
	v_comments VARCHAR2( 200 ) := 'plsql_excluding_SQL';
begin 
	SELECT content 
	INTO v_text
	FROM temp_clob
	WHERE remarks = v_comments
	;
	pr_convert_clob_to_rules( v_text, v_comments );
END;
/ 

	