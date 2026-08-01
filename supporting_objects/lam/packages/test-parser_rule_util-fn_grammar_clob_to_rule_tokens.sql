set serveroutput on 

DECLARE  
    x parser_alt_token_col;
    v_grammar CLOB := 
	q'{
<variable_declaration>  ::= <identifier> [ "CONSTANT" ] <data_type> [ ":=" <expression> ] ";"
<data_type>             ::= <identifier> [ "%TYPE" | "%ROWTYPE" ] 
                          | <identifier> "(" <number_literal> [ "," <number_literal> ] ")"
<index_by_type>              ::= "VARCHAR2" "(" <number_literal> ")"
                               | "PLS_INTEGER"
                               | "BINARY_INTEGER"
                               | "LONG"
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
    x := 
--	TABLE ( 
    parser_rule_util.fn_grammar_clob_to_rule_tokens
--		(   p_clob      => g.text 
		(   p_clob      => v_grammar  
		   ,p_source    => 'variable_declaration'
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
where upper( source ) = upper( 'variable_declaration' ) 
    ORDER BY lhs, alt_no, position 
;