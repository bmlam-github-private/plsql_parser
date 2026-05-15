CREATE OR REPLACE PROCEDURE pr_parser_add_alt_tokens 
(    p_lhs    IN VARCHAR2
    ,p_rhs_tokens IN parser_rule_token_col 
    ,p_source VARCHAR2 
)
IS
    v_alt_no   NUMBER := 1;
    v_position NUMBER := 1;
BEGIN
    IF p_rhs_tokens IS NULL OR p_rhs_tokens.COUNT = 0 THEN
        RETURN;
    END IF;
    --
    IF f_token_is_present   ( p_rhs_tokens, '|' ) > 0 
     AND f_token_is_present ( p_rhs_tokens, '{')  > 0 
    THEN 
        raise_application_error ( 'rhs tokens can not have both alternative and repetition!');
    END IF ;
    IF   f_token_is_present ( p_rhs_tokens, '{')  > 0 
    THEN 
        pr_parser_add_tok_4_repeat_rule 
        (    p_lhs          => p_lhs 
            ,p_rhs_tokens   => p_rhs_tokens
            ,p_source       => p_source 
        ) ;
        -- 
        RETURN;
    END IF;
    --
    DELETE parser_alt_token t 
    where lower( trim( p_lhs) )     = t.lhs 
      AND lower( trim( p_source ) )  = t.source 
    ;

    FOR i IN 1 .. p_rhs_tokens.COUNT LOOP

        IF p_rhs_tokens(i).content = '|' THEN
            v_alt_no   := v_alt_no + 1;
            v_position := 1;

        ELSE
            INSERT INTO parser_alt_token (
                lhs,    source 
                ,alt_no
                ,position
                ,symbol
            )
            VALUES (
                lower(p_lhs),   lower( p_source )
                ,v_alt_no
                ,v_position
                ,lower( TRIM( p_rhs_tokens(i).content ) )
            );

            v_position := v_position + 1;
        END IF;

    END LOOP;
    COMMIT; 
END;
/
show errors