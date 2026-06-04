-- =========================================
-- RECORD TYPE
-- =========================================

CREATE OR REPLACE FORCE TYPE parser_grammar_rule_simple_rec AS OBJECT (
    lhs VARCHAR2(100),
    rhs VARCHAR2(4000),
    lhs_root VARCHAR2(100),
    subrule_no NUMBER(3,0),
    source VARCHAR2(100)
);
/

-- =========================================
-- COLLECTION TYPE
-- =========================================

CREATE OR REPLACE TYPE parser_grammar_rule_simple_col AS TABLE OF parser_grammar_rule_simple_rec;
/
