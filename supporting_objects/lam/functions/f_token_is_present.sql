CREATE OR REPLACE FUNCTION f_token_is_present  
(	 p_tab_token	parser_rule_token_col 
	,p_token  		VARCHAR2
) RETURN NUMBER 
AS 
	v_return	NUMBER := 0;
BEGIN 
	IF p_tab_token IS NULL  
	THEN 
		RETURN v_return;
	END IF;
	--
	FOR i IN 1 .. p_tab_token.count 
	LOOP 
		IF lower ( p_token ) = lower ( p_tab_token(i).content )
		THEN 
			v_return := i;
			EXIT;
		END IF; 
	END LOOP	;
	-- 
	RETURN v_return;
END;
/