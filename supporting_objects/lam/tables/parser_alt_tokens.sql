CREATE TABLE parser_alt_token
( lhs		VARCHAR2(30)	NOT NULL 
, alt_no 	NUMBER(2)		NOT NULL 
, position	NUMBER(2)		NOT NULL
, symbol	VARCHAR2(30)	NOT NULL 
)
/

ALTER TABLE parser_alt_token 
	ADD constraint parser_alt_token_uk1 UNIQUE ( lhs, alt_no, position )
/

COMMENT ON TABLE parser_alt_token IS 'when the producion of a lhs contains alternatives, we want to 
have a unique number for each alternative. within each alternative, we order the symbols/token of the alternative '
/