-- ================================================================================
-- RECORD TYPE
-- lhs and rhs of a grammar rule with line and column position backtraceable to
-- the source grammar.
-- Used to temporarily store the rules consisting of lhs and rhs from a CLOB.
-- start_at_line and start_at_col points to where the lhs is found.
-- =========================================

CREATE OR REPLACE FORCE TYPE parser_rule_from_grammar_rec AS OBJECT 
(	lhs VARCHAR2(100)
   ,rhs VARCHAR2(4000)
   ,start_at_line INTEGER 
   ,start_at_COL  INTEGER 
);
/

-- =========================================
-- COLLECTION TYPE
-- =========================================

CREATE OR REPLACE TYPE parser_rule_from_grammar_col AS TABLE OF parser_rule_from_grammar_rec;
/
