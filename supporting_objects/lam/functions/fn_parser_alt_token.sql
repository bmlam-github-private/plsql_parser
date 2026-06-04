CREATE OR REPLACE FUNCTION fn_parser_alt_token
    RETURN parser_alt_token_col PIPELINED
AS
BEGIN

    FOR r IN (SELECT * FROM parser_alt_token) LOOP
        PIPE ROW (parser_alt_token_rec(
                r.lhs,
                r.alt_no,
                r.position,
                r.symbol,
                r.source
        ));
    END LOOP;

    RETURN;
END;
/
