 CREATE TABLE parser_grammar_rule_log ( 
  id		NUMBER GENERATED ALWAYS AS IDENTITY
, grammar_text  CLOB	NOT NULL 
, grammar_name  VARCHAR2(200) NOT NULL
, token_set_json CLOB	NOT NULL 
, time_stamp     TIMESTAMP	NOT NULL
)
/
	
ALTER TABLE parser_grammar_rule_log 
	MODIFY time_stamp DEFAULT SYSTIMESTAMP 
/

ALTER TABLE parser_grammar_rule_log 
	ADD grammar_text_checksum VARCHAR2(100) NOT NULL 
/

ALTER TABLE parser_grammar_rule_log 
	ADD token_json_checksum VARCHAR2(100) NOT NULL 
/

COMMENT ON TABLE parser_grammar_rule_log IS 'link the original grammar to the set of alternative tokens derived from the grammar
providing a history
'
/


