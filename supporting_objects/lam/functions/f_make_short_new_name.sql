CREATE OR REPLACE FUNCTION  f_make_short_new_name 
( p_prefix		VARCHAR2 
 ,p_tokens		sys.odciVarchar2List
) RETURN VARCHAR2 
/* p_tokens contains string elements, while the first element may be a square, curly or round bracket.
  In this case, it should be ignore and the next element is used.
  From the used string, we retain all letters if the string is not longer than 4 characters. Any not 
  letter characters are suppressed.
  If the string is longer, we split it into elements separated by underscore. 
	From the first element we retain only consonants
	  If the first element yields NULL we try to map the element to a word 
	From all further elements, we retain only the first letter regardless of consonant or vowel.
*/ 
AS 
    v_start_idx  NUMBER := 1;
    v_str        VARCHAR2(4000);
    v_short      VARCHAR2(4000) := '';
    v_remaining  VARCHAR2(4000);
    v_pos        NUMBER;
    v_part       VARCHAR2(4000);
    v_part_idx   NUMBER := 0;
    v_clean_part VARCHAR2(4000);
    v_cons_part  VARCHAR2(4000);
BEGIN 
    -- 1. Handle empty token collections
    IF p_tokens IS NULL OR p_tokens.COUNT = 0 THEN
        RETURN p_prefix;
    END IF;

    -- 2. Check if the first element is a bracket; if so, skip it
    IF p_tokens(1) IN ('(', ')', '[', ']', '{', '}') THEN
        v_start_idx := 2;
    END IF;

    -- 3. Retrieve the target string element
    IF p_tokens.COUNT >= v_start_idx THEN
        v_str := p_tokens(v_start_idx);
    ELSE
        RETURN p_prefix;
    END IF;

    -- 4. Process based on string length
    IF LENGTH(v_str) <= 4 THEN
        -- Rule: Retain all letters, suppress non-letters
        v_short := REGEXP_REPLACE(v_str, '[^A-Za-z]', '');
		IF v_short IS NULL THEN 
			DECLARE 
				v_1st_elem_normed VARCHAR2(100);
			BEGIN 
				v_1st_elem_normed := REGEXP_REPLACE( p_tokens(v_start_idx), '"', '' ) ;
				v_short := 
					CASE substr( v_1st_elem_normed , 1 , 1 ) 
					WHEN '+' THEN 'sign'
					WHEN '-' THEN 'sign'
					WHEN '*' THEN 'star'
					ELSE 'qm'
					END;
			END;
		END IF;
    ELSE
        -- Rule: Split into elements separated by underscore
        v_remaining := v_str;
        WHILE v_remaining IS NOT NULL LOOP
            v_pos := INSTR(v_remaining, '_');
            IF v_pos > 0 THEN
                v_part := SUBSTR(v_remaining, 1, v_pos - 1);
                v_remaining := SUBSTR(v_remaining, v_pos + 1);
            ELSE
                v_part := v_remaining;
                v_remaining := NULL;
            END IF;

            v_part_idx := v_part_idx + 1;

            IF v_part_idx = 1 THEN
                -- First element: retain only consonants (letters excluding A, E, I, O, U)
                v_clean_part := REGEXP_REPLACE(v_part, '[^A-Za-z]', '');
                v_cons_part := '';
                FOR i IN 1..LENGTH(v_clean_part) LOOP
                    IF NOT REGEXP_LIKE(SUBSTR(v_clean_part, i, 1), '^[AEIOUaeiou]$') THEN
                        v_cons_part := v_cons_part || SUBSTR(v_clean_part, i, 1);
                    END IF;
                END LOOP;
                v_short := v_short || v_cons_part;
            ELSE
                -- All further elements: retain only the first letter
                v_clean_part := REGEXP_REPLACE(v_part, '[^A-Za-z]', '');
                IF LENGTH(v_clean_part) > 0 THEN
                    v_short := v_short || SUBSTR(v_clean_part, 1, 1);
                END IF;
            END IF;
        END LOOP;
    END IF;

    -- Return prefix combined with the generated short name
    RETURN p_prefix || '_'||v_short;
END;
/
