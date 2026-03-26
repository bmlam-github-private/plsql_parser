CREATE OR REPLACE PACKAGE parser_grammar_gen IS
   --
   FUNCTION get_parser_code_v2 
   RETURN CLOB
   ;
--    
    FUNCTION tokenize_rhs(p_rhs VARCHAR2) RETURN SYS.ODCIVARCHAR2LIST 
    ----------------------------------------------------------------------
    -- Tokenize the RHS ignoring human-readable whitespace
    ----------------------------------------------------------------------
;
END;
/


