declare 
	v_text CLOB;
	v_remakrs VARCHAR2(100) := 'oracle-SELECT-grammar';
begin 
	SELECT content 
	INTO v_text
	FROM temp_clob
	WHERE remarks = v_remakrs
	;
	pr_convert_clob_to_rules( v_text, v_remakrs );
END;
/ 

	