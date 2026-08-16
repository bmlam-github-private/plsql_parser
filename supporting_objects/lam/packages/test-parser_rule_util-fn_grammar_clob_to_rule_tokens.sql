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
# added later 
#  Top-level rule
<expression>           ::= <logical_and_expr> { "OR" <logical_and_expr> }
<logical_and_expr>     ::= <logical_not_expr> { "AND" <logical_not_expr> }
<logical_not_expr>     ::= [ "NOT" ] <relational_expr>
# Relational operations now consume scalar expressions instead of top-level <expression> 
<relational_expr>      ::= <additive_expr> [ <relational_op> <additive_expr> | <is_null_op> | <between_op> | <in_op> | <like_op> ]
# IN list uses scalar/additive expression instead of full <expression> 
<in_op>                ::= [ "NOT" ] "IN" "(" ( <additive_expr> { "," <additive_expr> } | <subquery> ) ")"
# Function arguments use scalar/additive expressions or explicitly parenthesized expressions 
<variable_or_function> ::= <identifier> [ "(" [ <additive_expr> { "," <additive_expr> } ] ")" ]	}' ;
BEGIN 
--    SELECT content  
--    INTO v_grammar 
--    FROM temp_clob 
--    where remarks = 'variable_declaration'
--    ; 
    x := 
--	TABLE ( 
    parser_rule_util.fn_grammar_clob_to_rule_tokens
--		(   p_clob      => g.text 
		(   p_clob      => v_grammar  
		   ,p_source    => upper( 'variable_declaration' )
		   ,p_persist   => true -- DEFAULT FALSE -- true forfeits usage in SELECT 
		   ,p_max_nesting 	=> 999
		)
--	) t 
--    ORDER BY lhs, alt_no, position 
	;
END;
/

declare
    v_cnt number;
begin 
  parser_rule_util.pr_set_global
    (   p_key 		=> 'MAX_NESTING'
       ,p_value		=> 99
    );
-- trasient result of fn_grammar_clob_to_rule_tokens
    SELECT count(1) 
    into v_cnt 
    FROM TABLE( parser_rule_util. FN_EBNF_CLOB_TO_SIMPLE (	q'{
#  Top-level rule
<expression>           ::= <logical_and_expr> { "OR" <logical_and_expr> }
        }' 
        , p_source => upper( 'variable_declartion' )
        ) )
    ;
END;
/

SELECT *
--json_arrayagg ( json_object( *) returning clob ) foo 
from parser_alt_token 
where upper( source ) = upper( 'PLSQL__DECLARATION_SECTION' ) 
    ORDER BY lhs, alt_no, position 
;