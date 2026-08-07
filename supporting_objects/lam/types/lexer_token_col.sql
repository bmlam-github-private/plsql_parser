DROP TYPE lexer_token_col
;






CREATE OR REPLACE FORCE TYPE lexer_token_rec 
AS OBJECT 
( tok_seq 			NUMBER 
 ,tok_type			VARCHAR2(30)
 ,tok_char_cnt		NUMBER
 ,tok_text_normal 	VARCHAR2(4000 char)
 ,tok_value 		VARCHAR2(4000 char)
 ,tok_text_long 	CLOB
 --
 -- customer constructor 
 ,CONSTRUCTOR FUNCTION lexer_token_rec 
 (tok_seq 	NUMBER 
 ,tok_type	VARCHAR2
 ,tok_char_cnt		NUMBER
 ,tok_text_normal 	VARCHAR2
 ,tok_text_long 	CLOB 
 ) RETURN SELF AS RESULT 
 -- Print Method Implementation
 ,MEMBER PROCEDURE print_details 
    --
 ,MEMBER FUNCTION compare_symbol 
        ( pi_symbol 	IN VARCHAR2 
		)
    RETURN BOOLEAN 
);
/ 

CREATE OR REPLACE TYPE BODY lexer_token_rec 
AS
 CONSTRUCTOR FUNCTION lexer_token_rec 
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
-- Print Method Implementation
MEMBER PROCEDURE print_details IS
BEGIN
        DBMS_OUTPUT.PUT_LINE('--- lexer_token_rec Details ---');
        DBMS_OUTPUT.PUT_LINE('tok_seq 			: ' || SELF.tok_seq );
        DBMS_OUTPUT.PUT_LINE('tok_type			: ' || SELF.tok_type);
        DBMS_OUTPUT.PUT_LINE('tok_char_cnt		: ' || SELF.tok_char_cnt		);
        DBMS_OUTPUT.PUT_LINE('tok_text_normal	: ' || SELF.tok_text_normal	);
        DBMS_OUTPUT.PUT_LINE('tok_value 		: ' || SELF.tok_value 		);
		IF self.tok_char_cnt > 4000 THEN 
			DBMS_OUTPUT.PUT_LINE('tok_text_long		: ' || dbms_lob.substr( SELF.tok_text_long, 40, 1)||'..' );
		END IF;
END print_details;
-- 
MEMBER FUNCTION compare_symbol 
( pi_symbol 	IN VARCHAR2 
)
RETURN BOOLEAN 
AS 
	v_return 	BOOLEAN := FALSE;
BEGIN 
	dbms_output.put_line( $$PLSQL_UNIT||' Matching symbol: '||pi_symbol );
	self.print_details;
	CASE 
	WHEN pi_symbol  		= '<identifier>'
		AND self.tok_type 	= '<identifier>'
	THEN 			
		v_return := TRUE;
	WHEN pi_symbol  = self.tok_value 
	THEN 			
		v_return := TRUE;
	WHEN pi_symbol  = 'EPSILON'
	THEN 			
		v_return := TRUE;
	ELSE 
		v_return := FALSE; 
	END CASE;
	-- 
	dbms_output.put_line( $$PLSQL_UNIT||' '||
		CASE v_return 
			WHEN TRUE 
			THEN '********* returning TRUE *****: '
			WHEN FALSE 
			THEN 'returning False'
			ELSE 'return NULL!'
		END 
		);
	RETURN v_return;
END compare_symbol;
--
END; 
/

CREATE OR REPLACE FORCE TYPE lexer_token_col AS TABLE OF lexer_token_rec
;
/