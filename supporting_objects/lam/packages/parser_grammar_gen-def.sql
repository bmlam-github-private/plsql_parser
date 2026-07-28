CREATE OR REPLACE PACKAGE parser_grammar_gen IS
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
	FUNCTION fn_norm_as_proc_name 
		(p_input 	VARCHAR2 
	) RETURN VARCHAR2 
    ----------------------------------------------------------------------
    -- transform <abc> to pr_abc 
    ----------------------------------------------------------------------
;
--
FUNCTION fn_get_parser_package_code 
	(p_source			IN VARCHAR2 
	,p_package_name 	IN VARCHAR2 DEFAULT 'PKG_DYNAMIC_PARSER'
	,p_spec_body_mask 	IN INTEGER DEFAULT 2 -- 0 both, 1-spec only, 2-body only
	) RETURN CLOB 
	;
END;
/


