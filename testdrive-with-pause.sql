VAR source_key	VARCHAR2 
VAR grammar 	VARCHAR2 






SET SERVEROUTPUT on 

BEGIN 
	:source_key := 'test_simple_expression'
	;
    DBMS_output.put_line( 'source_key: '||upper( :source_key ) );
	:grammar := q'[
# Main Expression Structure 
expression     ::= term { ( "+" | "-" ) term } ;

# Terms handle multiplication and division (higher precedence) 
term           ::= factor { ( "*" | "/" ) factor } ;

# Factors handle unary signs, parentheses, variables, and numbers (highest precedence) 
factor         ::= [ "+" | "-" ] ( number_literal | variable | "(" expression ")" ) ;
		
	]';
END;
/


SET SERVEROUTPUT off 
PROMPT converting grammar to rule atl_tokens 
BEGIN 
	pr_refresh_rat_of_grammar 
		( p_grammar 	=> :grammar 
		 ,p_source_key 	=> :source_key
		);
END;
/
PAUSE 		
	