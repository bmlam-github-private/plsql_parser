CREATE OR REPLACE FUNCTION f_find_token (
	 p_tokens		sys.odciVarchar2List
	,p_tok_value 	VARCHAR2 
	,p_start_at     NUMBER DEFAULT 1 
) RETURN NUMBER 
AS
BEGIN 
	IF p_tokens IS NULL OR p_tokens.count < p_start_at 
	THEN 
		RETURN 0;
	END IF;
	-- 
	FOR i IN p_start_at .. p_tokens.count 
	LOOP 
		IF p_tokens (i) = p_tok_value 
			OR p_tokens(i) IS NULL AND p_tok_value IS NULL 
		THEN 
			RETURN i ;
		END IF; 
	END LOOP; 
	--
	RETURN 0;
END;	
/