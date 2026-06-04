CREATE OR REPLACE FUNCTION fn_parser_grammar_rule_ebnf
    RETURN parser_grammar_rule_ebnf_col PIPELINED
AS
BEGIN

    FOR r IN (SELECT * FROM parser_grammar_rule_ebnf) LOOP
        PIPE ROW (parser_grammar_rule_ebnf_rec(
                r.rule_id,
                r.lhs,
                r.rhs,
                r.seq,
                r.source
        ));
    END LOOP;

    RETURN;
END;
/

