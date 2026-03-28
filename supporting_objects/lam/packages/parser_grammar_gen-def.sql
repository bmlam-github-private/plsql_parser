CREATE OR REPLACE PACKAGE parser_grammar_gen IS
   --
   FUNCTION get_parser_code_v2
   RETURN CLOB
   ;
--    
    FUNCTION tokenize_rhs_raw (p_rhs VARCHAR2) 
    RETURN SYS.ODCIVARCHAR2LIST 
    ----------------------------------------------------------------------
    -- Tokenize the RHS ignoring human-readable whitespace
    ----------------------------------------------------------------------
;
--    
    FUNCTION tokenize_rhs_refined (p_rhs VARCHAR2) 
    RETURN parser_rule_token_col 
    ----------------------------------------------------------------------
    -- Tokenize the RHS in cleansed format adding type 
    ----------------------------------------------------------------------
;
--
FUNCTION get_parser_package_code (
    p_package_name  IN  VARCHAR2 
)
RETURN CLOB 
;
END;
/


