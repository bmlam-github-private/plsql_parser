CREATE TABLE parser_grammar_rules (
     rule_id        NUMBER   GENERATED ALWAYS AS IDENTITY
    ,lhs            VARCHAR2(100)    NOT NULL 
    ,rhs            VARCHAR2(4000)
    ,seq            NUMBER
    ,comments            VARCHAR2(4000)
)
/

ALTER TABLE parser_grammar_rules ADD PRIMARY KEY (rule_id)
/

ALTER TABLE parser_grammar_rules ADD UNIQUE (lhs)
/

ALTER TABLE parser_grammar_rules ADD CONSTRAINT parser_grammar_rules_lhs_ck CHECK ( lower( trim(lhs) ) = lhs )
/

