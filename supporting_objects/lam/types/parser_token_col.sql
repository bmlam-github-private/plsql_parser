DROP TYPE parser_token_col
;








--CREATE OR REPLACE FORCE TYPE parser_token_rec 
--AS OBJECT 
--( tok_seq 	NUMBER 
-- ,tok_type	VARCHAR2(30)
-- ,tok_char_cnt		NUMBER
-- ,tok_text_normal 	VARCHAR2(4000 char)
-- ,tok_value 		VARCHAR2(4000 char)
-- ,tok_text_long 	CLOB
-- --
-- -- customer constructor 
-- ,CONSTRUCTOR FUNCTION parser_token_rec 
-- (tok_seq 	NUMBER 
-- ,tok_type	VARCHAR2
-- ,tok_char_cnt		NUMBER
-- ,tok_text_normal 	VARCHAR2
-- ,tok_text_long 	CLOB 
-- ) RETURN SELF AS RESULT 
--);
--/ 

CREATE OR REPLACE TYPE BODY parser_token_rec 
AS
 CONSTRUCTOR FUNCTION parser_token_rec 
 (tok_seq 	NUMBER 
 ,tok_type	VARCHAR2
 ,tok_char_cnt		NUMBER
 ,tok_text_normal 	VARCHAR2
 ,tok_text_long 	CLOB 
 ) RETURN SELF AS RESULT 
 AS 
 BEGIN
	self.tok_seq 	   	:=      tok_seq 	   	;
	self.tok_type	   	:=      tok_type	   	;
	self.tok_char_cnt	:=	    tok_char_cnt	;
	self.tok_text_normal:=	 	tok_text_normal;
	self.tok_value 		:=      tok_value 		;
	self.tok_text_long 	:=      tok_text_long 	;
	RETURN; 
END; 
END; 
/

CREATE OR REPLACE FORCE TYPE parser_token_col AS TABLE OF parser_token_rec
;
/