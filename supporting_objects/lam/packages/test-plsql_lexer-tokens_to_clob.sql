DECLARE 	
	v_tokens parser_token_col := parser_token_col ();
BEGIN 
	-- receive result of pipelined function into plsql collection variable 
	SELECT 
			parser_token_rec 
				(xx => r_tok.xx 
				,xx => r_tok.xx 
				)
		BULK COLLECT INTO v_tokens 
		FROM 	TABLE 	( 
		plsql_lexer.code_to_basic_tokens(
    'DECLARE
       v_msg VARCHAR2(100) := q''!It''s a "Q" string delimiter block!''; -- inline comment
       v_num NUMBER := 123.45;
     BEGIN
       /* Multi line block 
          evaluation check */
       IF v_num <> 0 THEN
          DBMS_OUTPUT.PUT_LINE(v_msg);
       END IF;
     END;'
     ||'/*'||rpad( '.', 5000, '.' )||'*/'
	) );
	-- reconstruct original plsql code 
	FOR r_tok IN ( 
		SELECT 
		FROM 
	) 	LOOP 
		dbms_output.put_line ( r_tok.xx );
	END LOOP; 
	;
END;
/