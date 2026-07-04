CREATE OR REPLACE VIEW v_parser_alt_token 
AS 
SELECT 
	lhs, alt_no, position, symbol, source
	,CASE 
		WHEN symbol LIKE '%]' 	THEN substr( symbol, 1, length( symbol ) -1 ) 
		WHEN symbol LIKE '[%' 	THEN substr( symbol, 2 ) 
		WHEN symbol LIKE '[%]' 	THEN substr( symbol, 2, length( symbol ) -2 ) 
		ELSE symbol 
		END 	AS symbol_cleansed 
FROM 	parser_alt_token pat 
/

	