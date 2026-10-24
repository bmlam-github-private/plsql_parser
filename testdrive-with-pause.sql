VAR source_key	VARCHAR2 
VAR grammar 	VARCHAR2 
VAR package_name	VARCHAR2 
VAR test_code_1		VARCHAR2 






SET SERVEROUTPUT on 

BEGIN 
	:source_key := upper( trim ( 'test_simple_expression' ) )
	;
	:package_name :=  upper( 'pkg_'||:source_key );
    DBMS_output.put_line( 'source_key: '||upper( :source_key ) );
	:grammar := q'[
# Main Expression Structure 
expression     ::= term { ( "+" | "-" ) term } ;
# Terms handle multiplication and division (higher precedence) 
term           ::= factor { ( "*" | "/" ) factor } ;
# Factors handle unary signs, parentheses, variables, and numbers (highest precedence) 
factor         ::= [ "+" | "-" ] ( number_literal | variable | "(" expression ")" ) ;
	]';
	--
	:test_code_1 := 'a1 + b2 / (c - 3 * a1)';
END;
/

set linesize 200 
print :grammar 

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
	


PROMPT Generating code parser package 
DECLARE 	
	v_spec		CLOB; 
	v_body		CLOB; 
BEGIN 
	--
	v_spec := parser_grammar_gen. fn_get_parser_package_code ( 
        p_source => :source_key , p_package_name => :package_name 
        , p_spec_body_mask => 1
		, p_append_slash => 0 
        ) ;
    BEGIN 		
		EXECUTE IMMEDIATE v_spec; 
	EXCEPTION 
		WHEN OTHERS THEN 
			pck_std_log.info ( a_comp => 'TEST-DRIVE-WITH-PAUSE', a_text=> 'Exception on compiling SPEC code (code in next log entry): '||sqlerrm );
			pck_std_log.info_long ( a_comp => 'TEST-DRIVE-WITH-PAUSE', a_text=> v_spec);
			--
dbms_output.enable; 
DBMS_output.put_line ( 'v_spec: '||v_spec );
dbms_output.disable; 
			RAISE; 
	END ;
	--
	v_body := parser_grammar_gen. fn_get_parser_package_code ( 
        p_source => :source_key , p_package_name => :package_name 
        , p_spec_body_mask => 1
		, p_append_slash => 0 
        ) ;
    BEGIN 		
		EXECUTE IMMEDIATE v_body; 
	EXCEPTION 
		WHEN OTHERS THEN 
			pck_std_log.info ( a_comp => 'TEST-DRIVE-WITH-PAUSE', a_text=> 'Exception on compiling BODY code (code in next log entry): '||sqlerrm );
			pck_std_log.info_long ( a_comp => 'TEST-DRIVE-WITH-PAUSE', a_text=> v_spec);
			--
			RAISE; 
	END ;
	--
END; 
/

PROMPT If no exception, package has been created or replace 
PRINT :package_name 

PAUSE 

PROMPT Testing code parser package 

DECLARE 
	vtab_lexer_token lexer_toker_col;
BEGIN 
	vtab_lexer_token := plsql_lexer. code_to_lang_tokens
		( pi_code => :test_code_1
		 ,pi_grammar_source => :source_key 
		);
END;
/		