declare 
	v_text CLOB;
begin 
	SELECT content 
	INTO v_text
	FROM temp_clob
	WHERE remarks = 'oracle-SELECT-grammar'
	;
	pr_convert_clob_to_rules( v_text );
END;
/ 

	