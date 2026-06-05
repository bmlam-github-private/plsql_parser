CREATE OR REPLACE PACKAGE parser_rule_util
AS 
--
FUNCTION fn_1_ebnf_to_simple 
(   p_lhs 		IN VARCHAR2
   ,p_rhs 		IN VARCHAR2
   ,p_source 	IN VARCHAR2
)
RETURN parser_grammar_rule_simple_col
;
end parser_rule_util;
/

