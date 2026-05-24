CREATE TABLE parser_grammar_rule_simple (
     lhs        VARCHAR2(100)	NOT NULL 
	,rhs        VARCHAR2(4000)	NOT NULL
	,lhs_root 	VARCHAR2(100 ) 	NOT NULL 
	,subrule_no NUMBER(3) 			
	,source 	VARCHAR2(100 ) 	NOT NULL 
);

ALTER TABLE parser_grammar_rule_simple ADD CONSTRAINT parser_grammar_rule_simple_uk1 unique ( 
	lhs, 	  rhs, subrule_no, source 
);

COMMENT ON TABLE parser_grammar_rule_simple IS 
'to be used as the source table for computing first set tokens 
'
/


