CREATE OR REPLACE PROCEDURE pr_parser_add_alt_tokens 
(    p_lhs    IN VARCHAR2
    ,p_tokens IN parser_rule_token_col 
    ,p_purge_old BOOLEAN DEFAULT FALSE
)
IS
    v_alt_no   NUMBER := 1;
    v_position NUMBER := 1;
BEGIN
    IF p_tokens IS NULL OR p_tokens.COUNT = 0 THEN
        RETURN;
    END IF;
    --
    IF p_purge_old THEN 
        DELETE parser_alt_token t 
        where UPPER( trim( p_lhs) ) = t.lhs 
        ;
    END if;

    FOR i IN 1 .. p_tokens.COUNT LOOP

        IF p_tokens(i).content = '|' THEN
            v_alt_no   := v_alt_no + 1;
            v_position := 1;

        ELSE
            INSERT INTO parser_alt_token (
                lhs,
                alt_no,
                position,
                symbol
            )
            VALUES (
                UPPER(p_lhs),
                v_alt_no,
                v_position,
                UPPER( TRIM( p_tokens(i).content ) )
            );

            v_position := v_position + 1;
        END IF;

    END LOOP;
    COMMIT; 
END;
/
show errors