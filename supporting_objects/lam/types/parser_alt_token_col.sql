-- =========================================
-- RECORD TYPE
-- =========================================

CREATE OR REPLACE FORCE TYPE parser_alt_token_rec AS OBJECT (
    lhs VARCHAR2(30),
    alt_no NUMBER(2,0),
    position NUMBER(2,0),
    symbol VARCHAR2(30),
    source VARCHAR2(800)
);
/

-- =========================================
-- COLLECTION TYPE
-- =========================================

CREATE OR REPLACE TYPE parser_alt_token_col AS TABLE OF parser_alt_token_rec;
/
