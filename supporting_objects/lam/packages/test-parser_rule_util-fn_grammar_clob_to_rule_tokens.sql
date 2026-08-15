set serveroutput on 

DECLARE  
    x parser_alt_token_col;
    v_grammar CLOB := 
    -- if grammar is short enough . or insert into temp_clob first ! 
	q'{
<variable_declaration>  ::= <identifier> [ "CONSTANT" ] <data_type> [ ":=" <expression> ] ";"
<data_type>             ::= <identifier> "%" [ "TYPE" | "ROWTYPE" ] | <identifier> "(" <number_literal> [ "," <number_literal> ] ")"
<index_by_type>         ::= "VARCHAR2" "(" <number_literal> ")" | "PLS_INTEGER" | "BINARY_INTEGER" | "LONG"
<ref_cursor_type_definition> ::= "REF CURSOR" [ "RETURN" <data_type> ]
	}' ;
BEGIN 
--    WITH gram AS ( 
--        SELECT xxx 
--        AS text 
--        FROM dual 
--    )
--    SELECT t.*
--    FROM gram g 
--    CROSS JOIN  
    SELECT content  
    INTO v_grammar 
    FROM temp_clob 
    where remarks = 'PLSQL__DECLARATION_SECTION'
    ; 
    x := 
--	TABLE ( 
    parser_rule_util.fn_grammar_clob_to_rule_tokens
--		(   p_clob      => g.text 
		(   p_clob      => v_grammar  
		   ,p_source    => 'PLSQL__DECLARATION_SECTION'
		   ,p_persist   => true -- DEFAULT FALSE -- true forfeits usage in SELECT 
		   ,p_max_nesting 	=> 999
		)
--	) t 
--    ORDER BY lhs, alt_no, position 
	;
END;
/

SELECT *
--json_arrayagg ( json_object( *) returning clob ) foo 
from parser_alt_token 
where upper( source ) = upper( 'PLSQL__DECLARATION_SECTION' ) 
    ORDER BY lhs, alt_no, position 
;