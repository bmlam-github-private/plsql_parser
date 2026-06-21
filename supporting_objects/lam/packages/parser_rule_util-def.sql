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
-- 
FUNCTION fn_ebnf_clob_to_simple
(   p_clob      IN CLOB
   ,p_source    IN VARCHAR2
)
RETURN parser_grammar_rule_simple_col
;
--
FUNCTION fn_grammar_clob_to_rule_tokens
(   p_clob      IN CLOB
   ,p_source    IN VARCHAR2
   ,p_persist   IN BOOLEAN DEFAULT FALSE -- true forfeits usage in SELECT 
)
RETURN parser_alt_token_col
;
--
end;
/

