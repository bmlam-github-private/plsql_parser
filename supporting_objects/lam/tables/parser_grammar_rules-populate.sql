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

 ::= 
' )
;
INSERT INTO parser_grammar_rules
( lhs,			rhs ) VALUES 
( '<declaration>', '<variable_declaration>
                | <cursor_declaration>
                | <exception_declaration>
                | <type_declaration>
                | <subprogram_declaration>' )
;

<variable_declaration> ::= <identifier> ["," <identifier>]* <datatype> ["NOT NULL"] [":=" <expression>] ";"

<datatype> ::= <scalar_type> | <composite_type> | <ref_cursor_type> | <user_defined_type>

<scalar_type> ::= "NUMBER" | "VARCHAR2" | "CHAR" | "DATE" | "BOOLEAN" | "BINARY_INTEGER" | "PLS_INTEGER" | ...

<composite_type> ::= "RECORD" | "TABLE OF" <datatype> | "VARRAY" | ...

<cursor_declaration> ::= "CURSOR" <identifier> ["IS" <select_statement>];

<exception_declaration> ::= "EXCEPTION" <identifier> ";"

<type_declaration> ::= "TYPE" <identifier> "IS" <datatype> ";"

<subprogram_declaration> ::= <procedure_spec> ";"
                           | <function_spec> ";"

<procedure_spec> ::= "PROCEDURE" <identifier> ["(" <parameter_list> ")"]
<function_spec> ::= "FUNCTION" <identifier> ["(" <parameter_list> ")"] "RETURN" <datatype>

<parameter_list> ::= <parameter> {"," <parameter>}*
<parameter> ::= <identifier> <in_out_mode> <datatype>
<in_out_mode> ::= "IN" | "OUT" | "IN OUT"

<procedure_body> ::= <procedure_spec> "IS" <declaration_section> "BEGIN" <executable_section> ["EXCEPTION" <exception_section>] "END" <identifier> ";"
<function_body> ::= <function_spec> "IS" <declaration_section> "BEGIN" <executable_section> ["EXCEPTION" <exception_section>] "END" <identifier> ";"

<package_spec> ::= "PACKAGE" <identifier> "IS" {<package_element>}* "END" <identifier> ";"
<package_body> ::= "PACKAGE BODY" <identifier> "IS" {<package_body_element>}* "END" <identifier> ";"

<package_element> ::= <procedure_spec> ";"
                    | <function_spec> ";"
                    | <type_declaration>
                    | <variable_declaration>
                    | <cursor_declaration>

<package_body_element> ::= <procedure_body>
                         | <function_body>
                         | <type_declaration>
                         | <variable_declaration>
                         | <cursor_declaration>

<executable_section> ::= <statement> {<statement>}*
<statement> ::= <assignment_statement>
              | <procedure_call>
              | <if_statement>
              | <loop_statement>
              | <while_statement>
              | <for_statement>
              | <exit_statement>
              | <raise_statement>
              | <null_statement>
              | <block>  -- nested blocks
              | <dynamic_sql_statement>
              | <other_sql_statement>  -- placeholder for SELECT/DML

<assignment_statement> ::= <variable_reference> ":=" <expression> ";"

<procedure_call> ::= <identifier> ["(" <expression_list> ")"] ";"

<if_statement> ::= "IF" <condition> "THEN" <executable_section>
                   { "ELSIF" <condition> "THEN" <executable_section> }*
                   ["ELSE" <executable_section>]
                   "END IF" ";"

<loop_statement> ::= "LOOP" <executable_section> "END LOOP" ";"

<while_statement> ::= "WHILE" <condition> "LOOP" <executable_section> "END LOOP" ";"

<for_statement> ::= "FOR" <identifier> "IN" <range> "LOOP" <executable_section> "END LOOP" ";"

<exit_statement> ::= "EXIT" ["WHEN" <condition>] ";"

<raise_statement> ::= "RAISE" [<exception_name>] ";"

<null_statement> ::= "NULL" ";"

<condition> ::= <expression>  -- evaluates to BOOLEAN

<range> ::= <expression> ".." <expression>

<expression_list> ::= <expression> {"," <expression>}*

<expression> ::= <literal>
               | <variable_reference>
               | <function_call>
               | <expression> <operator> <expression>
               | "(" <expression> ")"

<variable_reference> ::= <identifier> ["." <field_name>]

<literal> ::= <number> | <string> | "TRUE" | "FALSE" | "NULL"

<operator> ::= "+" | "-" | "*" | "/" | "=" | "<>" | "<" | "<=" | ">" | ">=" | "AND" | "OR" | "NOT"

<exception_section> ::= <exception_handler> {<exception_handler>}*
<exception_handler> ::= "WHEN" <exception_name> "THEN" <executable_section>

<trigger> ::= "CREATE" "OR" "REPLACE" "TRIGGER" <identifier> <trigger_time_event> <trigger_body> "END" <identifier> ";"

<trigger_time_event> ::= ...  -- not expanded here

<trigger_body> ::= <declaration_section> "BEGIN" <executable_section> ["EXCEPTION" <exception_section>]

<dynamic_sql_statement> ::= "EXECUTE IMMEDIATE" <string_literal> ["INTO" <variable_reference>];

<other_sql_statement> ::= placeholder for SELECT / INSERT / UPDATE / DELETE / MERGE

