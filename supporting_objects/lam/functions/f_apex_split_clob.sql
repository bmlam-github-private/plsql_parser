CREATE OR REPLACE FUNCTION f_apex_split_clob
(	 p_clob			CLOB 
	,p_sep			VARCHAR2 DEFAULT chr(10)
) RETURN APEX_T_VARCHAR2 
AS 
	v_return	APEX_T_VARCHAR2;
BEGIN 
	IF p_sep IS NULL THEN 
		raise_application_error( -20001, 'No separator given!');
	END IF;
    v_return := apex_string.split ( p_str => p_clob , p_sep=> p_sep );
	-- 
	RETURN v_return;
EXCEPTION 
	WHEN OTHERS THEN  
		IF sqlcode = -6502 THEN 
			raise_application_error( -20001, 'CLOB probably has lines bigger thatn 32K!');
		ELSE 
			RAISE;
		END IF;
END;
/