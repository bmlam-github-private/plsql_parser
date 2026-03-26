CREATE OR REPLACE FORCE TYPE parser_rule_token_rec 
AS OBJECT 
( content	VARCHAR2(30)
 ,type		VARCHAR2(30)
);
/ 
CREATE OR REPLACE FORCE TYPE parser_rule_token_col AS TABLE OF parser_rule_token_rec
;
/
