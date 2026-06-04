CREATE OR REPLACE FUNCTION fn_parser_grammar_rule_simple
    RETURN parser_grammar_rule_simple_col PIPELINED
AS
BEGIN

    FOR r IN (SELECT * FROM parser_grammar_rule_simple) LOOP
        PIPE ROW (parser_grammar_rule_simple_rec(
                r.lhs,
                r.rhs,
                r.lhs_root,
                r.subrule_no,
                r.source
        ));
    END LOOP;

    RETURN;
END;
/
