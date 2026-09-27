CREATE OR REPLACE FUNCTION f_extract_ebnf_tokens (
	p_rhs VARCHAR2			-- this function is designed to handle only the rhs !
) RETURN sys.odcivarchar2List 
IS
/* extract tokens of an EBNF rhs. Notably double-quoted brackets are recognized as symbols.
   Unquoted brackets ( round, square, curly ) are treated as building part of EBNF rule 
*/ 
    v_return sys.odcivarchar2List :=sys.odcivarchar2List();
    -- Regex matches: <non-terminals>, "strings", words, brackets, pipes, or single symbols
    v_pattern VARCHAR2(100) := '(<[^>]+>|"[^"]+"|[a-zA-Z0-9_]+|\[|\]|\{|\}|\(|\)|\*|\||[^[:space:]])';
    v_match  VARCHAR2(1000);
BEGIN
    LOOP
        v_match := REGEXP_SUBSTR(p_rhs, v_pattern, 1, v_return.count + 1 );
        EXIT WHEN v_match IS NULL;
		v_return.extend();
        v_return( v_return.count ) := v_match;
    END LOOP;
    RETURN v_return;
END;
/

/*
SELECT * FROM TABLE ( f_extract_ebnf_tokens ( 
	q'[  ( "A" "B" | "(" "{" "C" ")" "}" ) expr_d 	[ "expendable" ] "|" { "," column } 
	]'
	) )
;
*/