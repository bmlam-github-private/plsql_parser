-- =========================================
-- RECORD TYPE
-- =========================================

CREATE OR REPLACE FORCE TYPE parser_grammar_rule_ebnf_rec AS OBJECT (
    rule_id NUMBER,
    lhs VARCHAR2(100),
    rhs VARCHAR2(4000),
    seq NUMBER,
    source VARCHAR2(4000)
);
/

-- =========================================
-- COLLECTION TYPE
-- =========================================

CREATE OR REPLACE TYPE parser_grammar_rule_ebnf_col AS TABLE OF parser_grammar_rule_ebnf_rec;
/
