CREATE TABLE parser_grammar_rules (
     rule_id        NUMBER   GENERATED ALWAYS AS IDENTITY
    ,lhs            VARCHAR2(100)	NOT NULL 
    ,rhs            VARCHAR2(4000)	NOT NULL  
    ,seq            NUMBER
    ,comments       VARCHAR2(4000)	NOT NULL 
)
/

ALTER TABLE parser_grammar_rules ADD PRIMARY KEY (rule_id)
/

ALTER TABLE parser_grammar_rules ADD UNIQUE ( lhs, rhs )
/

ALTER TABLE parser_grammar_rules ADD CONSTRAINT parser_grammar_rules_lhs_ck CHECK ( lower( trim(lhs) ) = lhs )
/

COMMENT ON TABLE parser_grammar_rules IS 
'Populated based on BNF rules . 
'
/

COMMENT ON COLUMN parser_grammar_rules.comments IS 
'Possibly sources or major node and children nodes of a PLSQL construct 
'
/

