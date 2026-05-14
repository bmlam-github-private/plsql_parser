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

ALTER TABLE parser_alt_token 
	ADD ( comments VARCHAR2 ( 200 CHAR ) )
/

COMMENT ON TABLE parser_alt_token IS 'when the producion of a lhs contains alternatives, we want to 
have a unique number for each alternative. within each alternative, we order the symbols/token of the alternative '
/

COMMENT ON COLUMN parser_alt_token.comments IS 'Can be used to indicate the source of the grammar rules. For example a rhs with repetition may haven been transform to alternates
Example: <a> ::= <b> {, <b> }  transformed to    <a> ::= <b> <a_tail>; <a_tail> ::= "," <b> | epsilon 
'
/


