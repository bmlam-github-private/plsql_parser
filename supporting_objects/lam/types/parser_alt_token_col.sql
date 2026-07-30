-- =========================================
-- RECORD TYPE
-- =========================================
DROP TYPE parser_alt_token_col
/





CREATE OR REPLACE FORCE TYPE parser_alt_token_rec AS OBJECT (
    lhs VARCHAR2(50),
    alt_no NUMBER(2,0),
    position NUMBER(2,0),
    symbol VARCHAR2(50),
    source VARCHAR2(800)
    --
	,MEMBER FUNCTION compare_symbol 
        ( pi_symbol 	IN VARCHAR2 
		)
    RETURN BOOLEAN 
);
/







CREATE OR REPLACE TYPE BODY parser_alt_token_rec AS 
    MEMBER FUNCTION compare_symbol 
	( pi_symbol 	IN VARCHAR2 
	)
    RETURN BOOLEAN 
	AS 
		v_return 	BOOLEAN := FALSE;
	BEGIN 
		RETURN v_return;
	END compare_symbol
;
/
-- =========================================
-- COLLECTION TYPE
-- =========================================

CREATE OR REPLACE TYPE parser_alt_token_col AS TABLE OF parser_alt_token_rec;
/
