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
);
/


-- There was something in TYPBE BODY, but later it proved to be obsolete! 
--CREATE OR REPLACE TYPE BODY parser_alt_token_rec AS 
--END;
--/
DROP TYPE BODY parser_alt_token_rec
/

-- =========================================
-- COLLECTION TYPE
-- =========================================

CREATE OR REPLACE TYPE parser_alt_token_col AS TABLE OF parser_alt_token_rec;
/
