CREATE OR REPLACE PACKAGE mistral_ebnf_simplifier 
AS 
-- 
TYPE table_of_vc4k 	IS TABLE OF VARCHAR2(4000);
-- 
FUNCTION split_by_delimiter(
    p_string IN VARCHAR2,
    p_delim  IN VARCHAR2
) RETURN table_of_vc4k 
;
-- 
FUNCTION expand_expression
	( p_expr IN VARCHAR2
	 ,p_nesting	IN NUMBER 
	) 
RETURN table_of_vc4k 
;
-- 
FUNCTION expand_ebnf_rule
	( p_rule IN VARCHAR2
	) 
RETURN table_of_vc4k 
;
FUNCTION get_object_col 
	( p_loc_typ_col 	table_of_vc4k 
	)
RETURN sys.odciVarchar2List 
;
-- 	
PROCEDURE set_nesting_lev ( p_number NUMBER )
;
-- 
END;
/
