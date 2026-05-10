INSERT INTO parser_grammar_rules
( lhs,			rhs ) VALUES 
( '<plsql_program_unit>', '<block>
                        | <procedure_spec> <procedure_body>
                        | <function_spec> <function_body>
                        | <package_spec> <package_body>
                        | <trigger>' )
;
INSERT INTO parser_grammar_rules
( lhs,			rhs ) VALUES 
( '<block>', '"DECLARE" <declaration_section> "BEGIN" <executable_section> ["EXCEPTION" <exception_section>] "END" [<identifier>] ";"
          | "BEGIN" <executable_section> ["EXCEPTION" <exception_section>] "END" [<identifier>] ";"' )
;
INSERT INTO parser_grammar_rules
( lhs,			rhs ) VALUES 
( '<declaration_section>', '<declaration> {<declaration>}*'
);

INSERT INTO parser_grammar_rules
( lhs,			rhs ) VALUES 
( '<variable_declaration>', '<identifier> ["," <identifier>]* <datatype> ["NOT NULL"] [":=" <expression>] ";"'  -- comma is wrong !? should be dot as qualifier operator! 
);
INSERT INTO parser_grammar_rules
( lhs,			rhs ) VALUES 
( '<declaration>', '<variable_declaration>
                | <cursor_declaration>
                | <exception_declaration>
                | <type_declaration>
                | <subprogram_declaration>' )
;
INSERT INTO parser_grammar_rules
( lhs,			rhs ) VALUES 
( '<datatype>', '<scalar_type> | <composite_type> | <ref_cursor_type> | <user_defined_type>'
);

INSERT INTO parser_grammar_rules
( lhs,			rhs ) VALUES 
( '<scalar_type>', '"NUMBER" | "VARCHAR2" | "CHAR" | "DATE" | "BOOLEAN" | "BINARY_INTEGER" | "PLS_INTEGER" | ...'
);

INSERT INTO parser_grammar_rules
( lhs,			rhs ) VALUES 
( '<composite_type>', '"RECORD" | "TABLE OF" <datatype> | "VARRAY" | ...'
);
INSERT INTO parser_grammar_rules
( lhs,			rhs ) VALUES 
( '<cursor_declaration>', '"CURSOR" <identifier> ["IS" <select_statement>];'   --   cursor parameter list is MISSING 
);
INSERT INTO parser_grammar_rules
( lhs,			rhs ) VALUES 
( '<exception_declaration>', '"EXCEPTION" <identifier> ";"'
);

-- 

INSERT INTO parser_grammar_rules
( lhs,			rhs ) VALUES 
( '<type_declaration>', '"TYPE" <identifier> "IS" <datatype> ";"'
);
INSERT INTO parser_grammar_rules
( lhs,			rhs ) VALUES 
( '<subprogram_declaration>', '<procedure_spec> ";"
                           | <function_spec> ";"'
);
INSERT INTO parser_grammar_rules
( lhs,			rhs ) VALUES 
( '<procedure_spec>', '"PROCEDURE" <identifier> ["(" <parameter_list> ")"]
<function_spec> ::= "FUNCTION" <identifier> ["(" <parameter_list> ")"] "RETURN" <datatype>'
);
INSERT INTO parser_grammar_rules
( lhs,			rhs ) VALUES 
( '<parameter_list>', '<parameter> {"," <parameter>}*'
);
INSERT INTO parser_grammar_rules
( lhs,			rhs ) VALUES 
( '<parameter>', '<identifier> <in_out_mode> <datatype>'
);
INSERT INTO parser_grammar_rules
( lhs,			rhs ) VALUES 
( '<in_out_mode>', '"IN" | "OUT" | "IN OUT"'
);

INSERT INTO parser_grammar_rules
( lhs,			rhs ) VALUES 
( 'xx', 'xx'
);

/*
*/ 


COMMIT;

