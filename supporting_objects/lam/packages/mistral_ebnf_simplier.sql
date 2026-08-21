CREATE OR REPLACE PACKAGE mistral_ebnf_simplifier 
AS 
-- 
TYPE table_of_vc4k 	IS TABLE OF VARCHAR2(4000);
-- 
FUNCTION expand_expression
	( p_expr IN VARCHAR2
	) 
RETURN sys.odcivarchar2list 
;
-- 
FUNCTION expand_ebnf_rule
	( p_rule IN VARCHAR2
	) 
RETURN sys.odcivarchar2list 
;
END;
/


















































































CREATE OR REPLACE PACKAGE BODY mistral_ebnf_simplifier 
AS 
-- 
FUNCTION loc_typ_col_2_object_col 
	( p_loc_typ_col 	table_of_vc4k 
	)
RETURN sys.odcivarchar2list 
AS 
	v_return	sys.odcivarchar2list := sys.odcivarchar2list();
BEGIN 
	FOR i IN 1 .. p_loc_typ_col.count 
	LOOP
		v_return.extend;
		v_return( v_return.count ) := p_loc_typ_col(i);
	END LOOP ;
	--
	RETURN v_return; 
END loc_typ_col_2_object_col
;	
-- Helper: Split a string by a delimiter, respecting quotes and brackets
FUNCTION split_by_delimiter(
    p_string IN VARCHAR2,
    p_delim  IN VARCHAR2
) RETURN table_of_vc4k IS
    v_result_local_type table_of_vc4k := table_of_vc4k();
    v_start NUMBER := 1;
    v_end NUMBER;
    v_in_quotes BOOLEAN := FALSE;
    v_in_brackets NUMBER := 0;
    v_in_parens NUMBER := 0;
    v_char CHAR(1);
BEGIN
    FOR i IN 1..LENGTH(p_string) LOOP
        v_char := SUBSTR(p_string, i, 1);
        -- Toggle quote state
        IF v_char = '"' AND (i = 1 OR SUBSTR(p_string, i-1, 1) <> '\') -- counter_quote' 
			THEN
            v_in_quotes := NOT v_in_quotes;
        -- Track brackets
        ELSIF v_char = '[' AND NOT v_in_quotes THEN
            v_in_brackets := v_in_brackets + 1;
        ELSIF v_char = ']' AND NOT v_in_quotes THEN
            v_in_brackets := v_in_brackets - 1;
        -- Track parentheses
        ELSIF v_char = '(' AND NOT v_in_quotes THEN
            v_in_parens := v_in_parens + 1;
        ELSIF v_char = ')' AND NOT v_in_quotes THEN
            v_in_parens := v_in_parens - 1;
        -- Split only if not in quotes, brackets, or parentheses
        ELSIF v_char = p_delim AND NOT v_in_quotes AND v_in_brackets = 0 AND v_in_parens = 0 THEN
            v_result_local_type.EXTEND;
            v_result_local_type(v_result_local_type.COUNT) := SUBSTR(p_string, v_start, i - v_start);
            v_start := i + 1;
        END IF;
    END LOOP;
    -- Add the last part
    v_result_local_type.EXTEND;
    v_result_local_type(v_result_local_type.COUNT) := SUBSTR(p_string, v_start);
    RETURN v_result_local_type;
END split_by_delimiter;

-- Helper: Trim whitespace
FUNCTION trim_whitespace(p_string IN VARCHAR2) RETURN VARCHAR2 IS
BEGIN
    RETURN REGEXP_REPLACE(TRIM(p_string), '[[:space:]]+', ' ');
END trim_whitespace;

-- Helper: Check if a string is a terminal (quoted)
FUNCTION is_terminal(p_string IN VARCHAR2) RETURN BOOLEAN IS
BEGIN
    RETURN SUBSTR(p_string, 1, 1) = '"' AND SUBSTR(p_string, -1, 1) = '"';
END is_terminal;

-- Helper: Remove quotes from a terminal
FUNCTION unquote
	( p_string IN VARCHAR2
	) 
RETURN VARCHAR2 
IS
BEGIN
    IF is_terminal(p_string) THEN
        RETURN SUBSTR(p_string, 2, LENGTH(p_string) - 2);
    ELSE
        RETURN p_string;
    END IF;
END unquote;

-- Helper: Expand a single EBNF expression (alternatives, optionals, repetitions, groupings)
FUNCTION expand_expression
	( p_expr IN VARCHAR2
	) 
RETURN sys.odcivarchar2list 
IS
    v_result_local_type table_of_vc4k := table_of_vc4k();
    v_parts table_of_vc4k;
    v_part VARCHAR2(4000);
    v_alternatives table_of_vc4k;
    v_expanded table_of_vc4k;
    v_temp table_of_vc4k;
    v_i NUMBER;
    v_j NUMBER;
    v_k NUMBER;
    v_char CHAR(1);
    v_in_brackets NUMBER := 0;
    v_in_parens NUMBER := 0;
    v_in_quotes BOOLEAN := FALSE;
    v_start NUMBER;
    v_end NUMBER;
    v_inner VARCHAR2(4000);
BEGIN
    -- Base case: empty string
    IF p_expr IS NULL OR LENGTH(TRIM(p_expr)) = 0 THEN
        v_result_local_type.EXTEND;
        v_result_local_type(v_result_local_type.COUNT) := '';
        RETURN loc_typ_col_2_object_col ( v_result_local_type );
    END IF;

    -- Check for parentheses (grouping)
    IF SUBSTR(p_expr, 1, 1) = '(' AND SUBSTR(p_expr, -1, 1) = ')' THEN
        v_inner := SUBSTR(p_expr, 2, LENGTH(p_expr) - 2);
        RETURN  expand_expression(v_inner) ;
    END IF;

    -- Check for optionals: [expr]
    IF SUBSTR(p_expr, 1, 1) = '[' AND SUBSTR(p_expr, -1, 1) = ']' THEN
        v_inner := SUBSTR(p_expr, 2, LENGTH(p_expr) - 2);
        -- Expand the inner expression
        v_expanded := expand_expression(v_inner);
        -- For each expanded inner, add both with and without
        FOR i IN 1..v_expanded.COUNT LOOP
            v_result_local_type.EXTEND;
            v_result_local_type(v_result_local_type.COUNT) := ''; -- Without
            v_result_local_type.EXTEND;
            v_result_local_type(v_result_local_type.COUNT) := v_expanded(i); -- With
        END LOOP;
        RETURN v_result_local_type;
    END IF;

    -- Check for repetitions: expr* or expr+
    IF SUBSTR(p_expr, -1, 1) = '*' THEN
        v_inner := SUBSTR(p_expr, 1, LENGTH(p_expr) - 1);
        v_expanded := expand_expression(v_inner);
        -- For *, allow 0 or more repetitions (limit to 2 for simplicity)
        FOR i IN 1..v_expanded.COUNT LOOP
            -- 0 times
            v_result_local_type.EXTEND;
            v_result_local_type(v_result_local_type.COUNT) := '';
            -- 1 time
            v_result_local_type.EXTEND;
            v_result_local_type(v_result_local_type.COUNT) := v_expanded(i);
            -- 2 times
            v_result_local_type.EXTEND;
            v_result_local_type(v_result_local_type.COUNT) := v_expanded(i) || ' ' || v_expanded(i);
        END LOOP;
        RETURN v_result_local_type;
    ELSIF SUBSTR(p_expr, -1, 1) = '+' THEN
        v_inner := SUBSTR(p_expr, 1, LENGTH(p_expr) - 1);
        v_expanded := expand_expression(v_inner);
        -- For +, allow 1 or more repetitions (limit to 2 for simplicity)
        FOR i IN 1..v_expanded.COUNT LOOP
            -- 1 time
            v_result_local_type.EXTEND;
            v_result_local_type(v_result_local_type.COUNT) := v_expanded(i);
            -- 2 times
            v_result_local_type.EXTEND;
            v_result_local_type(v_result_local_type.COUNT) := v_expanded(i) || ' ' || v_expanded(i);
        END LOOP;
        RETURN v_result_local_type;
    END IF;

    -- Check for alternatives: expr1 | expr2
    v_parts := split_by_delimiter(p_expr, '|');
    IF v_parts.COUNT > 1 THEN
        FOR i IN 1..v_parts.COUNT LOOP
            v_temp := expand_expression(trim_whitespace(v_parts(i)));
            FOR j IN 1..v_temp.COUNT LOOP
                v_result_local_type.EXTEND;
                v_result_local_type(v_result_local_type.COUNT) := v_temp(j);
            END LOOP;
        END LOOP;
        RETURN v_result_local_type;
    END IF;

    -- Check for sequences: expr1 expr2
    v_parts := split_by_delimiter(p_expr, ' ');
    IF v_parts.COUNT > 1 THEN
        -- Split into tokens (terminals, non-terminals, or sub-expressions)
        v_temp := table_of_vc4k();
        v_temp.EXTEND;
        v_temp(v_temp.COUNT) := '';
        FOR i IN 1..v_parts.COUNT LOOP
            v_part := trim_whitespace(v_parts(i));
            IF LENGTH(v_part) > 0 THEN
                v_expanded := expand_expression(v_part);
                -- Cartesian product with previous results
                v_i := v_temp.COUNT;
                FOR j IN 1..v_expanded.COUNT LOOP
                    FOR k IN 1..v_i LOOP
                        v_temp.EXTEND;
                        v_temp(v_temp.COUNT) := v_temp(k) || ' ' || v_expanded(j);
                    END LOOP;
                END LOOP;
                -- Remove old entries
                FOR k IN 1..v_i LOOP
                    v_temp.DELETE(1);
                END LOOP;
            END IF;
        END LOOP;
        RETURN v_temp;
    END IF;

    -- Default: return as-is
    v_result_local_type.EXTEND;
    v_result_local_type(v_result_local_type.COUNT) := p_expr;
    RETURN loc_typ_col_2_object_col( v_result_local_type );
END expand_expression;

FUNCTION expand_ebnf_rule
	( p_rule IN VARCHAR2
	) 
RETURN sys.odcivarchar2list 
AS 
	v_result_local_type table_of_vc4k ;
    v_lhs VARCHAR2(100);
    v_rhs VARCHAR2(4000);
    v_equals_pos NUMBER;
    v_expanded table_of_vc4k;
    v_i NUMBER;
BEGIN
    -- Split into LHS and RHS
    v_equals_pos := INSTR(p_rule, '=');
    v_lhs := TRIM(SUBSTR(p_rule, 1, v_equals_pos - 1));
    v_rhs := TRIM(SUBSTR(p_rule, v_equals_pos + 1));

    -- Expand the RHS
    v_expanded := expand_expression(v_rhs);

    -- Generate rules
    FOR i IN 1..v_expanded.COUNT LOOP
        v_result_local_type.EXTEND;
        v_result_local_type(v_result_local_type.COUNT) :=
            v_lhs || ' = ' || v_expanded(i) || ';';
    END LOOP;
	--
    RETURN loc_typ_col_2_object_col( v_result_local_type );
END expand_ebnf_rule;

END; -- Package body 
/




