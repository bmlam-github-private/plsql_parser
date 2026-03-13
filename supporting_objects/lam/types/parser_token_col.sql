CREATE OR REPLACE FORCE TYPE parser_token_rec 
AS OBJECT 
( tok_seq 	NUMBER 
 ,tok_type	VARCHAR2(30)
 ,tok_char_cnt		NUMBER
 ,tok_text_normal 	VARCHAR2(4000 char)
 ,tok_text_long 	CLOB
);
/ 
CREATE OR REPLACE FORCE TYPE parser_token_col AS TABLE OF parser_token_rec
;
/