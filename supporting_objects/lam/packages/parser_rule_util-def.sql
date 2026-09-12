CREATE OR REPLACE PACKAGE parser_rule_util
AS 
--
PROCEDURE pr_set_global
(   p_key 		IN VARCHAR2
   ,p_value		IN VARCHAR2
)
;
-- 
-- function to show the result of get_tokens for debugging 
FUNCTION get_tokens_dbx(p_str VARCHAR2) 
RETURN sys.odcivarchar2List
;
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
   ,p_max_nesting 	IN NUMBER 
)
RETURN parser_alt_token_col
;
--
FUNCTION find_non_quoted_bracket 
( p_bracket     VARCHAR2
 ,p_string      VARCHAR2 
 ,p_scan_from   NUMBER DEFAULT 1 
) RETURN NUMBER  
/* In EBFN round/square/curly brackets have special meaning. But the same characters may be a literal, which must double-quoted. 
   This founction should ignore double-quotes bracket.
   Test cases: 
   p_bracket    p_string            return 
   round        a ( b )             3
   round open   a "(" b )           0 
   round close  a ( b ")"           0 
*/
;
--
FUNCTION find_non_quoted_bracket_in_list 
( p_bracket_list    VARCHAR2
 ,p_string          VARCHAR2 
 ,p_scan_from   NUMBER DEFAULT 1 
) RETURN NUMBER  
/* based on find_non_quoted_bracket, but input is a set of bracket characters
*/ 
;
--
end;
/

