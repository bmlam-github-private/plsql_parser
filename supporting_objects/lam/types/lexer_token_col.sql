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
 ( self IN lexer_token_rec 
 )
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
MEMBER PROCEDURE print_details 
( self IN lexer_token_rec )
IS
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
	print_details;
	-- print call stack BEGIN 
	DECLARE 
		v_current_level NUMBER;
		v_padding_level NUMBER;
		v_line 			NUMBER;
		v_subprogram	VARCHAR2( 100 CHAR);
	BEGIN  
				v_current_level := UTL_CALL_STACK.dynamic_depth();
				DBMS_OUTPUT.put_line('Current nesting level: ' || v_current_level);			  DBMS_OUTPUT.put_line('--- Call Stack ---');
			  -- it seems idx starts at 0, while for humans top level start at 1 ! 
			  FOR idx IN REVERSE 1 ..  v_current_level 
			  LOOP
				-- Concatenate unit and subprogram name for readability
				v_subprogram := UTL_CALL_STACK.concatenate_subprogram(
								  UTL_CALL_STACK.subprogram(idx)
								);
				v_line       := UTL_CALL_STACK.unit_line(idx);
				v_padding_level := v_current_level - idx + 1;
				DBMS_OUTPUT.put_line(
				  lpad('->',  v_padding_level*2, ' ') || 
				  ' Ln:'     || v_line || 
				  ' :'  || v_subprogram
				);
			  END LOOP;
	END print_call_stack ; 
	-- print call stack END  
	--
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
	WHEN upper(pi_symbol)  -- this cover the case when tok_type is NUM_LITERAL, STR_LITERAL and the input symbol is <NUM_LITERAL> respectively <STR_LITERAL> 
		IN ( 'impossible dummy symbol'
			 ,'<NUMBER_LITERAL>'
		   )
	  AND regexp_replace( upper(pi_symbol), '^(<)(.*)(>)$', '\2' )  =  self.tok_type 
	THEN 			
		v_return := TRUE;
	WHEN self.tok_type 
		IN ( 'impossible dummy type'
	  		,'SPECIAL_CHAR' 
	  		,'SPECIAL_CHAR_DBL' 
			)
	  AND '"'||self.tok_value||'"' = pi_symbol 
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