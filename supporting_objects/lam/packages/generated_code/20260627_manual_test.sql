-- invocation: parser_grammar_gen.fn_get_parser_package_code( p_source => 'MANUAL_TEST' ) 
CREATE OR REPLACE PACKAGE PKG_DYNAMIC_PARSER AS
  -- Global collection type for tokens
  TYPE t_token_list IS TABLE OF parser_token_rec;

  g_tokens         t_token_list;
  g_curr_token_ix  NUMBER := 1;

  PROCEDURE <assignment_statement>(po_success OUT BOOLEAN);
  PROCEDURE <block>(po_success OUT BOOLEAN);
  PROCEDURE <block_opt_1>(po_success OUT BOOLEAN);
  PROCEDURE <block_opt_2>(po_success OUT BOOLEAN);
  PROCEDURE <condition>(po_success OUT BOOLEAN);
  PROCEDURE <dynamic_sql_statement>(po_success OUT BOOLEAN);
  PROCEDURE <dynamic_sql_statement_opt_1>(po_success OUT BOOLEAN);
  PROCEDURE <exception_handler>(po_success OUT BOOLEAN);
  PROCEDURE <exception_section>(po_success OUT BOOLEAN);
  PROCEDURE <exception_section_rep_1>(po_success OUT BOOLEAN);
  PROCEDURE <executable_section>(po_success OUT BOOLEAN);
  PROCEDURE <executable_section_rep_1>(po_success OUT BOOLEAN);
  PROCEDURE <exit_statement>(po_success OUT BOOLEAN);
  PROCEDURE <exit_statement_opt_1>(po_success OUT BOOLEAN);
  PROCEDURE <expression>(po_success OUT BOOLEAN);
  PROCEDURE <expression_list>(po_success OUT BOOLEAN);
  PROCEDURE <expression_list_rep_1>(po_success OUT BOOLEAN);
  PROCEDURE <expression_tail>(po_success OUT BOOLEAN);
  PROCEDURE <for_statement>(po_success OUT BOOLEAN);
  PROCEDURE <function_body>(po_success OUT BOOLEAN);
  PROCEDURE <function_body_opt_1>(po_success OUT BOOLEAN);
  PROCEDURE <if_statement>(po_success OUT BOOLEAN);
  PROCEDURE <literal>(po_success OUT BOOLEAN);
  PROCEDURE <loop_statement>(po_success OUT BOOLEAN);
  PROCEDURE <null_statement>(po_success OUT BOOLEAN);
  PROCEDURE <operator>(po_success OUT BOOLEAN);
  PROCEDURE <package_body>(po_success OUT BOOLEAN);
  PROCEDURE <package_body_element>(po_success OUT BOOLEAN);
  PROCEDURE <package_body_rep_1>(po_success OUT BOOLEAN);
  PROCEDURE <package_element>(po_success OUT BOOLEAN);
  PROCEDURE <package_spec>(po_success OUT BOOLEAN);
  PROCEDURE <package_spec_rep_1>(po_success OUT BOOLEAN);
  PROCEDURE <procedure_body>(po_success OUT BOOLEAN);
  PROCEDURE <procedure_body_opt_1>(po_success OUT BOOLEAN);
  PROCEDURE <procedure_call>(po_success OUT BOOLEAN);
  PROCEDURE <procedure_call_opt_1>(po_success OUT BOOLEAN);
  PROCEDURE <raise_statement>(po_success OUT BOOLEAN);
  PROCEDURE <raise_statement_opt_1>(po_success OUT BOOLEAN);
  PROCEDURE <range>(po_success OUT BOOLEAN);
  PROCEDURE <statement>(po_success OUT BOOLEAN);
  PROCEDURE <term>(po_success OUT BOOLEAN);
  PROCEDURE <trigger>(po_success OUT BOOLEAN);
  PROCEDURE <trigger_body>(po_success OUT BOOLEAN);
  PROCEDURE <trigger_body_opt_1>(po_success OUT BOOLEAN);
  PROCEDURE <variable_reference>(po_success OUT BOOLEAN);
  PROCEDURE <variable_reference_opt_1>(po_success OUT BOOLEAN);
  PROCEDURE <while_statement>(po_success OUT BOOLEAN);

  -- Main entry point for top-level parsing rules
  PROCEDURE parse_main(p_token_stream IN t_token_list, po_success OUT BOOLEAN);
END PKG_DYNAMIC_PARSER;

CREATE OR REPLACE PACKAGE BODY PKG_DYNAMIC_PARSER AS

  PROCEDURE <assignment_statement>_0(po_success OUT BOOLEAN);
  PROCEDURE <assignment_statement>_1(po_success OUT BOOLEAN);
  PROCEDURE <block>_0(po_success OUT BOOLEAN);
  PROCEDURE <block>_1(po_success OUT BOOLEAN);
  PROCEDURE <block_opt_1>_2(po_success OUT BOOLEAN);
  PROCEDURE <block_opt_1>_3(po_success OUT BOOLEAN);
  PROCEDURE <block_opt_2>_4(po_success OUT BOOLEAN);
  PROCEDURE <block_opt_2>_5(po_success OUT BOOLEAN);
  PROCEDURE <condition>_0(po_success OUT BOOLEAN);
  PROCEDURE <condition>_1(po_success OUT BOOLEAN);
  PROCEDURE <dynamic_sql_statement>_0(po_success OUT BOOLEAN);
  PROCEDURE <dynamic_sql_statement>_1(po_success OUT BOOLEAN);
  PROCEDURE <dynamic_sql_statement_opt_1>_2(po_success OUT BOOLEAN);
  PROCEDURE <dynamic_sql_statement_opt_1>_3(po_success OUT BOOLEAN);
  PROCEDURE <exception_handler>_0(po_success OUT BOOLEAN);
  PROCEDURE <exception_handler>_1(po_success OUT BOOLEAN);
  PROCEDURE <exception_section>_0(po_success OUT BOOLEAN);
  PROCEDURE <exception_section>_1(po_success OUT BOOLEAN);
  PROCEDURE <exception_section_rep_1>_2(po_success OUT BOOLEAN);
  PROCEDURE <exception_section_rep_1>_3(po_success OUT BOOLEAN);
  PROCEDURE <executable_section>_0(po_success OUT BOOLEAN);
  PROCEDURE <executable_section>_1(po_success OUT BOOLEAN);
  PROCEDURE <executable_section_rep_1>_2(po_success OUT BOOLEAN);
  PROCEDURE <executable_section_rep_1>_3(po_success OUT BOOLEAN);
  PROCEDURE <exit_statement>_0(po_success OUT BOOLEAN);
  PROCEDURE <exit_statement>_1(po_success OUT BOOLEAN);
  PROCEDURE <exit_statement_opt_1>_2(po_success OUT BOOLEAN);
  PROCEDURE <exit_statement_opt_1>_3(po_success OUT BOOLEAN);
  PROCEDURE <expression>_0(po_success OUT BOOLEAN);
  PROCEDURE <expression>_1(po_success OUT BOOLEAN);
  PROCEDURE <expression_list>_0(po_success OUT BOOLEAN);
  PROCEDURE <expression_list>_1(po_success OUT BOOLEAN);
  PROCEDURE <expression_list_rep_1>_2(po_success OUT BOOLEAN);
  PROCEDURE <expression_list_rep_1>_3(po_success OUT BOOLEAN);
  PROCEDURE <expression_tail>_0(po_success OUT BOOLEAN);
  PROCEDURE <expression_tail>_1(po_success OUT BOOLEAN);
  PROCEDURE <for_statement>_0(po_success OUT BOOLEAN);
  PROCEDURE <for_statement>_1(po_success OUT BOOLEAN);
  PROCEDURE <function_body>_0(po_success OUT BOOLEAN);
  PROCEDURE <function_body>_1(po_success OUT BOOLEAN);
  PROCEDURE <function_body_opt_1>_2(po_success OUT BOOLEAN);
  PROCEDURE <function_body_opt_1>_3(po_success OUT BOOLEAN);
  PROCEDURE <if_statement>_0(po_success OUT BOOLEAN);
  PROCEDURE <if_statement>_1(po_success OUT BOOLEAN);
  PROCEDURE <literal>_0(po_success OUT BOOLEAN);
  PROCEDURE <literal>_1(po_success OUT BOOLEAN);
  PROCEDURE <literal>_2(po_success OUT BOOLEAN);
  PROCEDURE <literal>_3(po_success OUT BOOLEAN);
  PROCEDURE <literal>_4(po_success OUT BOOLEAN);
  PROCEDURE <literal>_5(po_success OUT BOOLEAN);
  PROCEDURE <loop_statement>_0(po_success OUT BOOLEAN);
  PROCEDURE <loop_statement>_1(po_success OUT BOOLEAN);
  PROCEDURE <null_statement>_0(po_success OUT BOOLEAN);
  PROCEDURE <null_statement>_1(po_success OUT BOOLEAN);
  PROCEDURE <operator>_0(po_success OUT BOOLEAN);
  PROCEDURE <operator>_1(po_success OUT BOOLEAN);
  PROCEDURE <operator>_2(po_success OUT BOOLEAN);
  PROCEDURE <operator>_3(po_success OUT BOOLEAN);
  PROCEDURE <operator>_4(po_success OUT BOOLEAN);
  PROCEDURE <operator>_5(po_success OUT BOOLEAN);
  PROCEDURE <operator>_6(po_success OUT BOOLEAN);
  PROCEDURE <operator>_7(po_success OUT BOOLEAN);
  PROCEDURE <operator>_8(po_success OUT BOOLEAN);
  PROCEDURE <operator>_9(po_success OUT BOOLEAN);
  PROCEDURE <operator>_10(po_success OUT BOOLEAN);
  PROCEDURE <operator>_11(po_success OUT BOOLEAN);
  PROCEDURE <operator>_12(po_success OUT BOOLEAN);
  PROCEDURE <operator>_13(po_success OUT BOOLEAN);
  PROCEDURE <package_body>_0(po_success OUT BOOLEAN);
  PROCEDURE <package_body>_1(po_success OUT BOOLEAN);
  PROCEDURE <package_body_element>_0(po_success OUT BOOLEAN);
  PROCEDURE <package_body_element>_1(po_success OUT BOOLEAN);
  PROCEDURE <package_body_rep_1>_2(po_success OUT BOOLEAN);
  PROCEDURE <package_body_rep_1>_3(po_success OUT BOOLEAN);
  PROCEDURE <package_element>_0(po_success OUT BOOLEAN);
  PROCEDURE <package_element>_1(po_success OUT BOOLEAN);
  PROCEDURE <package_spec>_0(po_success OUT BOOLEAN);
  PROCEDURE <package_spec>_1(po_success OUT BOOLEAN);
  PROCEDURE <package_spec_rep_1>_2(po_success OUT BOOLEAN);
  PROCEDURE <package_spec_rep_1>_3(po_success OUT BOOLEAN);
  PROCEDURE <procedure_body>_0(po_success OUT BOOLEAN);
  PROCEDURE <procedure_body>_1(po_success OUT BOOLEAN);
  PROCEDURE <procedure_body_opt_1>_2(po_success OUT BOOLEAN);
  PROCEDURE <procedure_body_opt_1>_3(po_success OUT BOOLEAN);
  PROCEDURE <procedure_call>_0(po_success OUT BOOLEAN);
  PROCEDURE <procedure_call>_1(po_success OUT BOOLEAN);
  PROCEDURE <procedure_call_opt_1>_2(po_success OUT BOOLEAN);
  PROCEDURE <procedure_call_opt_1>_3(po_success OUT BOOLEAN);
  PROCEDURE <raise_statement>_0(po_success OUT BOOLEAN);
  PROCEDURE <raise_statement>_1(po_success OUT BOOLEAN);
  PROCEDURE <raise_statement_opt_1>_2(po_success OUT BOOLEAN);
  PROCEDURE <raise_statement_opt_1>_3(po_success OUT BOOLEAN);
  PROCEDURE <range>_0(po_success OUT BOOLEAN);
  PROCEDURE <range>_1(po_success OUT BOOLEAN);
  PROCEDURE <statement>_0(po_success OUT BOOLEAN);
  PROCEDURE <statement>_1(po_success OUT BOOLEAN);
  PROCEDURE <term>_0(po_success OUT BOOLEAN);
  PROCEDURE <term>_1(po_success OUT BOOLEAN);
  PROCEDURE <trigger>_0(po_success OUT BOOLEAN);
  PROCEDURE <trigger>_1(po_success OUT BOOLEAN);
  PROCEDURE <trigger_body>_0(po_success OUT BOOLEAN);
  PROCEDURE <trigger_body>_1(po_success OUT BOOLEAN);
  PROCEDURE <trigger_body_opt_1>_2(po_success OUT BOOLEAN);
  PROCEDURE <trigger_body_opt_1>_3(po_success OUT BOOLEAN);
  PROCEDURE <variable_reference>_0(po_success OUT BOOLEAN);
  PROCEDURE <variable_reference>_1(po_success OUT BOOLEAN);
  PROCEDURE <variable_reference_opt_1>_2(po_success OUT BOOLEAN);
  PROCEDURE <variable_reference_opt_1>_3(po_success OUT BOOLEAN);
  PROCEDURE <while_statement>_0(po_success OUT BOOLEAN);
  PROCEDURE <while_statement>_1(po_success OUT BOOLEAN);

  PROCEDURE <assignment_statement>(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := FALSE;
    IF NOT po_success THEN
      <assignment_statement>_0(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      <assignment_statement>_1(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END <assignment_statement>;

  PROCEDURE <assignment_statement>_0(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := TRUE;
    -- Position 1: Symbol <variable_reference>
    IF po_success THEN
      <variable_reference>(po_success);
    END IF;
    -- Position 2: Symbol ":="
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '":="' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 3: Symbol <expression>
    IF po_success THEN
      <expression>(po_success);
    END IF;
    -- Position 4: Symbol ";"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '";"' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END <assignment_statement>_0;

  PROCEDURE <assignment_statement>_1(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := TRUE;
    -- Position 1: Symbol <variable_reference>
    IF po_success THEN
      <variable_reference>(po_success);
    END IF;
    -- Position 2: Symbol ":="
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '":="' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 3: Symbol <expression>
    IF po_success THEN
      <expression>(po_success);
    END IF;
    -- Position 4: Symbol ";"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '";"' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END <assignment_statement>_1;

  PROCEDURE <block>(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := FALSE;
    IF NOT po_success THEN
      <block>_0(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      <block>_1(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END <block>;

  PROCEDURE <block>_0(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := TRUE;
    -- Position 1: Symbol ["DECLARE"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '["DECLARE"' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 2: Symbol <declaration_section>]
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '<declaration_section>]' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 3: Symbol "BEGIN"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '"BEGIN"' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 4: Symbol <executable_section>
    IF po_success THEN
      <executable_section>(po_success);
    END IF;
    -- Position 5: Symbol ["EXCEPTION"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '["EXCEPTION"' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 6: Symbol <exception_section>]
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '<exception_section>]' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 7: Symbol "END"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '"END"' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 8: Symbol ";"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '";"' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END <block>_0;

  PROCEDURE <block>_1(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := TRUE;
    -- Position 1: Symbol <block_opt_1>
    IF po_success THEN
      <block_opt_1>(po_success);
    END IF;
    -- Position 2: Symbol "BEGIN"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '"BEGIN"' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 3: Symbol <executable_section>
    IF po_success THEN
      <executable_section>(po_success);
    END IF;
    -- Position 4: Symbol <block_opt_2>
    IF po_success THEN
      <block_opt_2>(po_success);
    END IF;
    -- Position 5: Symbol "END"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '"END"' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 6: Symbol ";"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '";"' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END <block>_1;

  PROCEDURE <block_opt_1>(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := FALSE;
    IF NOT po_success THEN
      <block_opt_1>_2(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      <block_opt_1>_3(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END <block_opt_1>;

  PROCEDURE <block_opt_1>_2(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := TRUE;
    -- Position 1: Symbol "DECLARE"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '"DECLARE"' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 2: Symbol <declaration_section>
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '<declaration_section>' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END <block_opt_1>_2;

  PROCEDURE <block_opt_1>_3(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := TRUE;
    -- Position 1: Symbol EPSILON
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = 'EPSILON' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END <block_opt_1>_3;

  PROCEDURE <block_opt_2>(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := FALSE;
    IF NOT po_success THEN
      <block_opt_2>_4(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      <block_opt_2>_5(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END <block_opt_2>;

  PROCEDURE <block_opt_2>_4(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := TRUE;
    -- Position 1: Symbol "EXCEPTION"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '"EXCEPTION"' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 2: Symbol <exception_section>
    IF po_success THEN
      <exception_section>(po_success);
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END <block_opt_2>_4;

  PROCEDURE <block_opt_2>_5(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := TRUE;
    -- Position 1: Symbol EPSILON
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = 'EPSILON' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END <block_opt_2>_5;

  PROCEDURE <condition>(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := FALSE;
    IF NOT po_success THEN
      <condition>_0(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      <condition>_1(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END <condition>;

  PROCEDURE <condition>_0(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := TRUE;
    -- Position 1: Symbol <expression>
    IF po_success THEN
      <expression>(po_success);
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END <condition>_0;

  PROCEDURE <condition>_1(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := TRUE;
    -- Position 1: Symbol <expression>
    IF po_success THEN
      <expression>(po_success);
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END <condition>_1;

  PROCEDURE <dynamic_sql_statement>(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := FALSE;
    IF NOT po_success THEN
      <dynamic_sql_statement>_0(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      <dynamic_sql_statement>_1(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END <dynamic_sql_statement>;

  PROCEDURE <dynamic_sql_statement>_0(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := TRUE;
    -- Position 1: Symbol "EXECUTE
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '"EXECUTE' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 2: Symbol IMMEDIATE"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = 'IMMEDIATE"' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 3: Symbol <string_literal>
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '<string_literal>' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 4: Symbol ["INTO"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '["INTO"' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 5: Symbol <variable_reference>];
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '<variable_reference>];' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END <dynamic_sql_statement>_0;

  PROCEDURE <dynamic_sql_statement>_1(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := TRUE;
    -- Position 1: Symbol "EXECUTE
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '"EXECUTE' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 2: Symbol IMMEDIATE"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = 'IMMEDIATE"' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 3: Symbol <string_literal>
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '<string_literal>' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 4: Symbol <dynamic_sql_statement_opt_1>
    IF po_success THEN
      <dynamic_sql_statement_opt_1>(po_success);
    END IF;
    -- Position 5: Symbol ;
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = ';' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END <dynamic_sql_statement>_1;

  PROCEDURE <dynamic_sql_statement_opt_1>(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := FALSE;
    IF NOT po_success THEN
      <dynamic_sql_statement_opt_1>_2(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      <dynamic_sql_statement_opt_1>_3(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END <dynamic_sql_statement_opt_1>;

  PROCEDURE <dynamic_sql_statement_opt_1>_2(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := TRUE;
    -- Position 1: Symbol "INTO"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '"INTO"' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 2: Symbol <variable_reference>
    IF po_success THEN
      <variable_reference>(po_success);
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END <dynamic_sql_statement_opt_1>_2;

  PROCEDURE <dynamic_sql_statement_opt_1>_3(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := TRUE;
    -- Position 1: Symbol EPSILON
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = 'EPSILON' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END <dynamic_sql_statement_opt_1>_3;

  PROCEDURE <exception_handler>(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := FALSE;
    IF NOT po_success THEN
      <exception_handler>_0(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      <exception_handler>_1(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END <exception_handler>;

  PROCEDURE <exception_handler>_0(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := TRUE;
    -- Position 1: Symbol "WHEN"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '"WHEN"' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 2: Symbol <exception_name>
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '<exception_name>' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 3: Symbol "THEN"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '"THEN"' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 4: Symbol <executable_section>
    IF po_success THEN
      <executable_section>(po_success);
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END <exception_handler>_0;

  PROCEDURE <exception_handler>_1(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := TRUE;
    -- Position 1: Symbol "WHEN"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '"WHEN"' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 2: Symbol <exception_name>
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '<exception_name>' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 3: Symbol "THEN"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '"THEN"' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 4: Symbol <executable_section>
    IF po_success THEN
      <executable_section>(po_success);
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END <exception_handler>_1;

  PROCEDURE <exception_section>(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := FALSE;
    IF NOT po_success THEN
      <exception_section>_0(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      <exception_section>_1(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END <exception_section>;

  PROCEDURE <exception_section>_0(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := TRUE;
    -- Position 1: Symbol <exception_handler>
    IF po_success THEN
      <exception_handler>(po_success);
    END IF;
    -- Position 2: Symbol {<exception_handler>}*
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '{<exception_handler>}*' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END <exception_section>_0;

  PROCEDURE <exception_section>_1(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := TRUE;
    -- Position 1: Symbol <exception_handler>
    IF po_success THEN
      <exception_handler>(po_success);
    END IF;
    -- Position 2: Symbol <exception_section_rep_1>
    IF po_success THEN
      <exception_section_rep_1>(po_success);
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END <exception_section>_1;

  PROCEDURE <exception_section_rep_1>(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := FALSE;
    IF NOT po_success THEN
      <exception_section_rep_1>_2(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      <exception_section_rep_1>_3(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END <exception_section_rep_1>;

  PROCEDURE <exception_section_rep_1>_2(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := TRUE;
    -- Position 1: Symbol <exception_handler>
    IF po_success THEN
      <exception_handler>(po_success);
    END IF;
    -- Position 2: Symbol <exception_section_rep_1>
    IF po_success THEN
      <exception_section_rep_1>(po_success);
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END <exception_section_rep_1>_2;

  PROCEDURE <exception_section_rep_1>_3(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := TRUE;
    -- Position 1: Symbol EPSILON
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = 'EPSILON' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END <exception_section_rep_1>_3;

  PROCEDURE <executable_section>(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := FALSE;
    IF NOT po_success THEN
      <executable_section>_0(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      <executable_section>_1(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END <executable_section>;

  PROCEDURE <executable_section>_0(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := TRUE;
    -- Position 1: Symbol <statement>
    IF po_success THEN
      <statement>(po_success);
    END IF;
    -- Position 2: Symbol {<statement>}*
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '{<statement>}*' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END <executable_section>_0;

  PROCEDURE <executable_section>_1(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := TRUE;
    -- Position 1: Symbol <statement>
    IF po_success THEN
      <statement>(po_success);
    END IF;
    -- Position 2: Symbol <executable_section_rep_1>
    IF po_success THEN
      <executable_section_rep_1>(po_success);
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END <executable_section>_1;

  PROCEDURE <executable_section_rep_1>(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := FALSE;
    IF NOT po_success THEN
      <executable_section_rep_1>_2(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      <executable_section_rep_1>_3(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END <executable_section_rep_1>;

  PROCEDURE <executable_section_rep_1>_2(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := TRUE;
    -- Position 1: Symbol <statement>
    IF po_success THEN
      <statement>(po_success);
    END IF;
    -- Position 2: Symbol <executable_section_rep_1>
    IF po_success THEN
      <executable_section_rep_1>(po_success);
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END <executable_section_rep_1>_2;

  PROCEDURE <executable_section_rep_1>_3(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := TRUE;
    -- Position 1: Symbol EPSILON
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = 'EPSILON' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END <executable_section_rep_1>_3;

  PROCEDURE <exit_statement>(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := FALSE;
    IF NOT po_success THEN
      <exit_statement>_0(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      <exit_statement>_1(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END <exit_statement>;

  PROCEDURE <exit_statement>_0(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := TRUE;
    -- Position 1: Symbol "EXIT"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '"EXIT"' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 2: Symbol ["WHEN"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '["WHEN"' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 3: Symbol <condition>]
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '<condition>]' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 4: Symbol ";"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '";"' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END <exit_statement>_0;

  PROCEDURE <exit_statement>_1(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := TRUE;
    -- Position 1: Symbol "EXIT"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '"EXIT"' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 2: Symbol <exit_statement_opt_1>
    IF po_success THEN
      <exit_statement_opt_1>(po_success);
    END IF;
    -- Position 3: Symbol ";"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '";"' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END <exit_statement>_1;

  PROCEDURE <exit_statement_opt_1>(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := FALSE;
    IF NOT po_success THEN
      <exit_statement_opt_1>_2(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      <exit_statement_opt_1>_3(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END <exit_statement_opt_1>;

  PROCEDURE <exit_statement_opt_1>_2(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := TRUE;
    -- Position 1: Symbol "WHEN"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '"WHEN"' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 2: Symbol <condition>
    IF po_success THEN
      <condition>(po_success);
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END <exit_statement_opt_1>_2;

  PROCEDURE <exit_statement_opt_1>_3(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := TRUE;
    -- Position 1: Symbol EPSILON
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = 'EPSILON' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END <exit_statement_opt_1>_3;

  PROCEDURE <expression>(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := FALSE;
    IF NOT po_success THEN
      <expression>_0(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      <expression>_1(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END <expression>;

  PROCEDURE <expression>_0(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := TRUE;
    -- Position 1: Symbol <term>
    IF po_success THEN
      <term>(po_success);
    END IF;
    -- Position 2: Symbol <expression_tail>
    IF po_success THEN
      <expression_tail>(po_success);
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END <expression>_0;

  PROCEDURE <expression>_1(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := TRUE;
    -- Position 1: Symbol <term>
    IF po_success THEN
      <term>(po_success);
    END IF;
    -- Position 2: Symbol <expression_tail>
    IF po_success THEN
      <expression_tail>(po_success);
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END <expression>_1;

  PROCEDURE <expression_list>(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := FALSE;
    IF NOT po_success THEN
      <expression_list>_0(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      <expression_list>_1(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END <expression_list>;

  PROCEDURE <expression_list>_0(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := TRUE;
    -- Position 1: Symbol <expression>
    IF po_success THEN
      <expression>(po_success);
    END IF;
    -- Position 2: Symbol {","
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '{","' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 3: Symbol <expression>}*
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '<expression>}*' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END <expression_list>_0;

  PROCEDURE <expression_list>_1(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := TRUE;
    -- Position 1: Symbol <expression>
    IF po_success THEN
      <expression>(po_success);
    END IF;
    -- Position 2: Symbol <expression_list_rep_1>
    IF po_success THEN
      <expression_list_rep_1>(po_success);
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END <expression_list>_1;

  PROCEDURE <expression_list_rep_1>(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := FALSE;
    IF NOT po_success THEN
      <expression_list_rep_1>_2(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      <expression_list_rep_1>_3(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END <expression_list_rep_1>;

  PROCEDURE <expression_list_rep_1>_2(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := TRUE;
    -- Position 1: Symbol ","
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '","' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 2: Symbol <expression>
    IF po_success THEN
      <expression>(po_success);
    END IF;
    -- Position 3: Symbol <expression_list_rep_1>
    IF po_success THEN
      <expression_list_rep_1>(po_success);
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END <expression_list_rep_1>_2;

  PROCEDURE <expression_list_rep_1>_3(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := TRUE;
    -- Position 1: Symbol EPSILON
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = 'EPSILON' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END <expression_list_rep_1>_3;

  PROCEDURE <expression_tail>(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := FALSE;
    IF NOT po_success THEN
      <expression_tail>_0(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      <expression_tail>_1(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END <expression_tail>;

  PROCEDURE <expression_tail>_0(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := TRUE;
    -- Position 1: Symbol <operator>
    IF po_success THEN
      <operator>(po_success);
    END IF;
    -- Position 2: Symbol <term>
    IF po_success THEN
      <term>(po_success);
    END IF;
    -- Position 3: Symbol <expression_tail>
    IF po_success THEN
      <expression_tail>(po_success);
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END <expression_tail>_0;

  PROCEDURE <expression_tail>_1(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := TRUE;
    -- Position 1: Symbol <operator>
    IF po_success THEN
      <operator>(po_success);
    END IF;
    -- Position 2: Symbol <term>
    IF po_success THEN
      <term>(po_success);
    END IF;
    -- Position 3: Symbol <expression_tail>
    IF po_success THEN
      <expression_tail>(po_success);
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END <expression_tail>_1;

  PROCEDURE <for_statement>(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := FALSE;
    IF NOT po_success THEN
      <for_statement>_0(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      <for_statement>_1(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END <for_statement>;

  PROCEDURE <for_statement>_0(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := TRUE;
    -- Position 1: Symbol "FOR"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '"FOR"' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 2: Symbol <identifier>
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '<identifier>' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 3: Symbol "IN"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '"IN"' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 4: Symbol <range>
    IF po_success THEN
      <range>(po_success);
    END IF;
    -- Position 5: Symbol "LOOP"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '"LOOP"' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 6: Symbol <executable_section>
    IF po_success THEN
      <executable_section>(po_success);
    END IF;
    -- Position 7: Symbol "END
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '"END' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 8: Symbol LOOP"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = 'LOOP"' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 9: Symbol ";"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '";"' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END <for_statement>_0;

  PROCEDURE <for_statement>_1(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := TRUE;
    -- Position 1: Symbol "FOR"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '"FOR"' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 2: Symbol <identifier>
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '<identifier>' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 3: Symbol "IN"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '"IN"' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 4: Symbol <range>
    IF po_success THEN
      <range>(po_success);
    END IF;
    -- Position 5: Symbol "LOOP"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '"LOOP"' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 6: Symbol <executable_section>
    IF po_success THEN
      <executable_section>(po_success);
    END IF;
    -- Position 7: Symbol "END
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '"END' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 8: Symbol LOOP"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = 'LOOP"' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 9: Symbol ";"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '";"' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END <for_statement>_1;

  PROCEDURE <function_body>(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := FALSE;
    IF NOT po_success THEN
      <function_body>_0(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      <function_body>_1(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END <function_body>;

  PROCEDURE <function_body>_0(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := TRUE;
    -- Position 1: Symbol <function_spec>
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '<function_spec>' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 2: Symbol "IS"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '"IS"' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 3: Symbol <declaration_section>
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '<declaration_section>' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 4: Symbol "BEGIN"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '"BEGIN"' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 5: Symbol <executable_section>
    IF po_success THEN
      <executable_section>(po_success);
    END IF;
    -- Position 6: Symbol ["EXCEPTION"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '["EXCEPTION"' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 7: Symbol <exception_section>]
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '<exception_section>]' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 8: Symbol "END"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '"END"' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 9: Symbol <identifier>
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '<identifier>' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 10: Symbol ";"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '";"' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END <function_body>_0;

  PROCEDURE <function_body>_1(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := TRUE;
    -- Position 1: Symbol <function_spec>
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '<function_spec>' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 2: Symbol "IS"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '"IS"' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 3: Symbol <declaration_section>
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '<declaration_section>' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 4: Symbol "BEGIN"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '"BEGIN"' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 5: Symbol <executable_section>
    IF po_success THEN
      <executable_section>(po_success);
    END IF;
    -- Position 6: Symbol <function_body_opt_1>
    IF po_success THEN
      <function_body_opt_1>(po_success);
    END IF;
    -- Position 7: Symbol "END"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '"END"' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 8: Symbol <identifier>
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '<identifier>' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 9: Symbol ";"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '";"' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END <function_body>_1;

  PROCEDURE <function_body_opt_1>(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := FALSE;
    IF NOT po_success THEN
      <function_body_opt_1>_2(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      <function_body_opt_1>_3(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END <function_body_opt_1>;

  PROCEDURE <function_body_opt_1>_2(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := TRUE;
    -- Position 1: Symbol "EXCEPTION"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '"EXCEPTION"' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 2: Symbol <exception_section>
    IF po_success THEN
      <exception_section>(po_success);
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END <function_body_opt_1>_2;

  PROCEDURE <function_body_opt_1>_3(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := TRUE;
    -- Position 1: Symbol EPSILON
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = 'EPSILON' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END <function_body_opt_1>_3;

  PROCEDURE <if_statement>(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := FALSE;
    IF NOT po_success THEN
      <if_statement>_0(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      <if_statement>_1(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END <if_statement>;

  PROCEDURE <if_statement>_0(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := TRUE;
    -- Position 1: Symbol "IF"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '"IF"' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 2: Symbol <condition>
    IF po_success THEN
      <condition>(po_success);
    END IF;
    -- Position 3: Symbol "THEN"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '"THEN"' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 4: Symbol <executable_section>
    IF po_success THEN
      <executable_section>(po_success);
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END <if_statement>_0;

  PROCEDURE <if_statement>_1(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := TRUE;
    -- Position 1: Symbol "IF"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '"IF"' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 2: Symbol <condition>
    IF po_success THEN
      <condition>(po_success);
    END IF;
    -- Position 3: Symbol "THEN"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '"THEN"' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 4: Symbol <executable_section>
    IF po_success THEN
      <executable_section>(po_success);
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END <if_statement>_1;

  PROCEDURE <literal>(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := FALSE;
    IF NOT po_success THEN
      <literal>_0(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      <literal>_1(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      <literal>_2(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      <literal>_3(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      <literal>_4(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      <literal>_5(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END <literal>;

  PROCEDURE <literal>_0(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := TRUE;
    -- Position 1: Symbol <number>
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '<number>' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 2: Symbol |
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '|' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 3: Symbol <string>
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '<string>' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 4: Symbol |
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '|' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 5: Symbol "TRUE"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '"TRUE"' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 6: Symbol |
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '|' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 7: Symbol "FALSE"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '"FALSE"' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 8: Symbol |
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '|' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 9: Symbol "NULL"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '"NULL"' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END <literal>_0;

  PROCEDURE <literal>_1(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := TRUE;
    -- Position 1: Symbol <number>
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '<number>' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END <literal>_1;

  PROCEDURE <literal>_2(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := TRUE;
    -- Position 1: Symbol <string>
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '<string>' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END <literal>_2;

  PROCEDURE <literal>_3(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := TRUE;
    -- Position 1: Symbol "TRUE"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '"TRUE"' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END <literal>_3;

  PROCEDURE <literal>_4(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := TRUE;
    -- Position 1: Symbol "FALSE"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '"FALSE"' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END <literal>_4;

  PROCEDURE <literal>_5(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := TRUE;
    -- Position 1: Symbol "NULL"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '"NULL"' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END <literal>_5;

  PROCEDURE <loop_statement>(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := FALSE;
    IF NOT po_success THEN
      <loop_statement>_0(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      <loop_statement>_1(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END <loop_statement>;

  PROCEDURE <loop_statement>_0(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := TRUE;
    -- Position 1: Symbol "LOOP"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '"LOOP"' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 2: Symbol <executable_section>
    IF po_success THEN
      <executable_section>(po_success);
    END IF;
    -- Position 3: Symbol "END
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '"END' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 4: Symbol LOOP"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = 'LOOP"' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 5: Symbol ";"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '";"' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END <loop_statement>_0;

  PROCEDURE <loop_statement>_1(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := TRUE;
    -- Position 1: Symbol "LOOP"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '"LOOP"' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 2: Symbol <executable_section>
    IF po_success THEN
      <executable_section>(po_success);
    END IF;
    -- Position 3: Symbol "END
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '"END' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 4: Symbol LOOP"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = 'LOOP"' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 5: Symbol ";"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '";"' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END <loop_statement>_1;

  PROCEDURE <null_statement>(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := FALSE;
    IF NOT po_success THEN
      <null_statement>_0(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      <null_statement>_1(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END <null_statement>;

  PROCEDURE <null_statement>_0(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := TRUE;
    -- Position 1: Symbol "NULL"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '"NULL"' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 2: Symbol ";"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '";"' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END <null_statement>_0;

  PROCEDURE <null_statement>_1(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := TRUE;
    -- Position 1: Symbol "NULL"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '"NULL"' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 2: Symbol ";"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '";"' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END <null_statement>_1;

  PROCEDURE <operator>(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := FALSE;
    IF NOT po_success THEN
      <operator>_0(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      <operator>_1(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      <operator>_2(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      <operator>_3(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      <operator>_4(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      <operator>_5(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      <operator>_6(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      <operator>_7(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      <operator>_8(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      <operator>_9(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      <operator>_10(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      <operator>_11(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      <operator>_12(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      <operator>_13(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END <operator>;

  PROCEDURE <operator>_0(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := TRUE;
    -- Position 1: Symbol "+"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '"+"' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 2: Symbol |
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '|' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 3: Symbol "-"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '"-"' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 4: Symbol |
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '|' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 5: Symbol "*"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '"*"' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 6: Symbol |
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '|' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 7: Symbol "/"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '"/"' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 8: Symbol |
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '|' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 9: Symbol "="
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '"="' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 10: Symbol |
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '|' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 11: Symbol "<>"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '"<>"' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 12: Symbol |
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '|' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 13: Symbol "<"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '"<"' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 14: Symbol |
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '|' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 15: Symbol "<="
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '"<="' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 16: Symbol |
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '|' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 17: Symbol ">"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '">"' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 18: Symbol |
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '|' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 19: Symbol ">="
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '">="' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 20: Symbol |
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '|' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 21: Symbol "AND"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '"AND"' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 22: Symbol |
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '|' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 23: Symbol "OR"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '"OR"' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 24: Symbol |
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '|' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 25: Symbol "NOT"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '"NOT"' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END <operator>_0;

  PROCEDURE <operator>_1(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := TRUE;
    -- Position 1: Symbol "+"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '"+"' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END <operator>_1;

  PROCEDURE <operator>_2(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := TRUE;
    -- Position 1: Symbol "-"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '"-"' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END <operator>_2;

  PROCEDURE <operator>_3(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := TRUE;
    -- Position 1: Symbol "*"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '"*"' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END <operator>_3;

  PROCEDURE <operator>_4(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := TRUE;
    -- Position 1: Symbol "/"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '"/"' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END <operator>_4;

  PROCEDURE <operator>_5(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := TRUE;
    -- Position 1: Symbol "="
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '"="' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END <operator>_5;

  PROCEDURE <operator>_6(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := TRUE;
    -- Position 1: Symbol "<>"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '"<>"' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END <operator>_6;

  PROCEDURE <operator>_7(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := TRUE;
    -- Position 1: Symbol "<"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '"<"' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END <operator>_7;

  PROCEDURE <operator>_8(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := TRUE;
    -- Position 1: Symbol "<="
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '"<="' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END <operator>_8;

  PROCEDURE <operator>_9(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := TRUE;
    -- Position 1: Symbol ">"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '">"' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END <operator>_9;

  PROCEDURE <operator>_10(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := TRUE;
    -- Position 1: Symbol ">="
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '">="' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END <operator>_10;

  PROCEDURE <operator>_11(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := TRUE;
    -- Position 1: Symbol "AND"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '"AND"' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END <operator>_11;

  PROCEDURE <operator>_12(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := TRUE;
    -- Position 1: Symbol "OR"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '"OR"' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END <operator>_12;

  PROCEDURE <operator>_13(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := TRUE;
    -- Position 1: Symbol "NOT"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '"NOT"' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END <operator>_13;

  PROCEDURE <package_body>(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := FALSE;
    IF NOT po_success THEN
      <package_body>_0(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      <package_body>_1(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END <package_body>;

  PROCEDURE <package_body>_0(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := TRUE;
    -- Position 1: Symbol "PACKAGE
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '"PACKAGE' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 2: Symbol BODY"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = 'BODY"' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 3: Symbol <identifier>
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '<identifier>' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 4: Symbol "IS"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '"IS"' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 5: Symbol {<package_body_element>}*
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '{<package_body_element>}*' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 6: Symbol "END"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '"END"' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 7: Symbol <identifier>
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '<identifier>' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 8: Symbol ";"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '";"' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END <package_body>_0;

  PROCEDURE <package_body>_1(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := TRUE;
    -- Position 1: Symbol "PACKAGE
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '"PACKAGE' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 2: Symbol BODY"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = 'BODY"' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 3: Symbol <identifier>
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '<identifier>' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 4: Symbol "IS"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '"IS"' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 5: Symbol <package_body_rep_1>
    IF po_success THEN
      <package_body_rep_1>(po_success);
    END IF;
    -- Position 6: Symbol "END"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '"END"' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 7: Symbol <identifier>
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '<identifier>' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 8: Symbol ";"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '";"' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END <package_body>_1;

  PROCEDURE <package_body_element>(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := FALSE;
    IF NOT po_success THEN
      <package_body_element>_0(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      <package_body_element>_1(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END <package_body_element>;

  PROCEDURE <package_body_element>_0(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := TRUE;
    -- Position 1: Symbol <procedure_body>
    IF po_success THEN
      <procedure_body>(po_success);
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END <package_body_element>_0;

  PROCEDURE <package_body_element>_1(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := TRUE;
    -- Position 1: Symbol <procedure_body>
    IF po_success THEN
      <procedure_body>(po_success);
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END <package_body_element>_1;

  PROCEDURE <package_body_rep_1>(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := FALSE;
    IF NOT po_success THEN
      <package_body_rep_1>_2(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      <package_body_rep_1>_3(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END <package_body_rep_1>;

  PROCEDURE <package_body_rep_1>_2(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := TRUE;
    -- Position 1: Symbol <package_body_element>
    IF po_success THEN
      <package_body_element>(po_success);
    END IF;
    -- Position 2: Symbol <package_body_rep_1>
    IF po_success THEN
      <package_body_rep_1>(po_success);
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END <package_body_rep_1>_2;

  PROCEDURE <package_body_rep_1>_3(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := TRUE;
    -- Position 1: Symbol EPSILON
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = 'EPSILON' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END <package_body_rep_1>_3;

  PROCEDURE <package_element>(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := FALSE;
    IF NOT po_success THEN
      <package_element>_0(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      <package_element>_1(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END <package_element>;

  PROCEDURE <package_element>_0(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := TRUE;
    -- Position 1: Symbol <procedure_spec>
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '<procedure_spec>' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 2: Symbol ";"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '";"' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END <package_element>_0;

  PROCEDURE <package_element>_1(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := TRUE;
    -- Position 1: Symbol <procedure_spec>
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '<procedure_spec>' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 2: Symbol ";"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '";"' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END <package_element>_1;

  PROCEDURE <package_spec>(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := FALSE;
    IF NOT po_success THEN
      <package_spec>_0(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      <package_spec>_1(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END <package_spec>;

  PROCEDURE <package_spec>_0(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := TRUE;
    -- Position 1: Symbol "PACKAGE"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '"PACKAGE"' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 2: Symbol <identifier>
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '<identifier>' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 3: Symbol "IS"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '"IS"' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 4: Symbol {<package_element>}*
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '{<package_element>}*' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 5: Symbol "END"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '"END"' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 6: Symbol <identifier>
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '<identifier>' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 7: Symbol ";"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '";"' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END <package_spec>_0;

  PROCEDURE <package_spec>_1(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := TRUE;
    -- Position 1: Symbol "PACKAGE"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '"PACKAGE"' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 2: Symbol <identifier>
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '<identifier>' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 3: Symbol "IS"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '"IS"' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 4: Symbol <package_spec_rep_1>
    IF po_success THEN
      <package_spec_rep_1>(po_success);
    END IF;
    -- Position 5: Symbol "END"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '"END"' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 6: Symbol <identifier>
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '<identifier>' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 7: Symbol ";"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '";"' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END <package_spec>_1;

  PROCEDURE <package_spec_rep_1>(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := FALSE;
    IF NOT po_success THEN
      <package_spec_rep_1>_2(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      <package_spec_rep_1>_3(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END <package_spec_rep_1>;

  PROCEDURE <package_spec_rep_1>_2(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := TRUE;
    -- Position 1: Symbol <package_element>
    IF po_success THEN
      <package_element>(po_success);
    END IF;
    -- Position 2: Symbol <package_spec_rep_1>
    IF po_success THEN
      <package_spec_rep_1>(po_success);
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END <package_spec_rep_1>_2;

  PROCEDURE <package_spec_rep_1>_3(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := TRUE;
    -- Position 1: Symbol EPSILON
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = 'EPSILON' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END <package_spec_rep_1>_3;

  PROCEDURE <procedure_body>(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := FALSE;
    IF NOT po_success THEN
      <procedure_body>_0(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      <procedure_body>_1(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END <procedure_body>;

  PROCEDURE <procedure_body>_0(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := TRUE;
    -- Position 1: Symbol <procedure_spec>
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '<procedure_spec>' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 2: Symbol "IS"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '"IS"' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 3: Symbol <declaration_section>
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '<declaration_section>' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 4: Symbol "BEGIN"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '"BEGIN"' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 5: Symbol <executable_section>
    IF po_success THEN
      <executable_section>(po_success);
    END IF;
    -- Position 6: Symbol ["EXCEPTION"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '["EXCEPTION"' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 7: Symbol <exception_section>]
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '<exception_section>]' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 8: Symbol "END"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '"END"' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 9: Symbol <identifier>
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '<identifier>' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 10: Symbol ";"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '";"' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END <procedure_body>_0;

  PROCEDURE <procedure_body>_1(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := TRUE;
    -- Position 1: Symbol <procedure_spec>
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '<procedure_spec>' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 2: Symbol "IS"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '"IS"' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 3: Symbol <declaration_section>
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '<declaration_section>' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 4: Symbol "BEGIN"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '"BEGIN"' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 5: Symbol <executable_section>
    IF po_success THEN
      <executable_section>(po_success);
    END IF;
    -- Position 6: Symbol <procedure_body_opt_1>
    IF po_success THEN
      <procedure_body_opt_1>(po_success);
    END IF;
    -- Position 7: Symbol "END"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '"END"' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 8: Symbol <identifier>
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '<identifier>' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 9: Symbol ";"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '";"' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END <procedure_body>_1;

  PROCEDURE <procedure_body_opt_1>(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := FALSE;
    IF NOT po_success THEN
      <procedure_body_opt_1>_2(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      <procedure_body_opt_1>_3(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END <procedure_body_opt_1>;

  PROCEDURE <procedure_body_opt_1>_2(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := TRUE;
    -- Position 1: Symbol "EXCEPTION"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '"EXCEPTION"' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 2: Symbol <exception_section>
    IF po_success THEN
      <exception_section>(po_success);
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END <procedure_body_opt_1>_2;

  PROCEDURE <procedure_body_opt_1>_3(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := TRUE;
    -- Position 1: Symbol EPSILON
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = 'EPSILON' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END <procedure_body_opt_1>_3;

  PROCEDURE <procedure_call>(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := FALSE;
    IF NOT po_success THEN
      <procedure_call>_0(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      <procedure_call>_1(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END <procedure_call>;

  PROCEDURE <procedure_call>_0(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := TRUE;
    -- Position 1: Symbol <identifier>
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '<identifier>' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 2: Symbol ["("
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '["("' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 3: Symbol <expression_list>
    IF po_success THEN
      <expression_list>(po_success);
    END IF;
    -- Position 4: Symbol ")"]
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '")"]' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 5: Symbol ";"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '";"' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END <procedure_call>_0;

  PROCEDURE <procedure_call>_1(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := TRUE;
    -- Position 1: Symbol <identifier>
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '<identifier>' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 2: Symbol <procedure_call_opt_1>
    IF po_success THEN
      <procedure_call_opt_1>(po_success);
    END IF;
    -- Position 3: Symbol ";"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '";"' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END <procedure_call>_1;

  PROCEDURE <procedure_call_opt_1>(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := FALSE;
    IF NOT po_success THEN
      <procedure_call_opt_1>_2(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      <procedure_call_opt_1>_3(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END <procedure_call_opt_1>;

  PROCEDURE <procedure_call_opt_1>_2(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := TRUE;
    -- Position 1: Symbol "("
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '"("' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 2: Symbol <expression_list>
    IF po_success THEN
      <expression_list>(po_success);
    END IF;
    -- Position 3: Symbol ")"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '")"' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END <procedure_call_opt_1>_2;

  PROCEDURE <procedure_call_opt_1>_3(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := TRUE;
    -- Position 1: Symbol EPSILON
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = 'EPSILON' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END <procedure_call_opt_1>_3;

  PROCEDURE <raise_statement>(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := FALSE;
    IF NOT po_success THEN
      <raise_statement>_0(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      <raise_statement>_1(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END <raise_statement>;

  PROCEDURE <raise_statement>_0(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := TRUE;
    -- Position 1: Symbol "RAISE"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '"RAISE"' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 2: Symbol [<exception_name>]
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '[<exception_name>]' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 3: Symbol ";"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '";"' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END <raise_statement>_0;

  PROCEDURE <raise_statement>_1(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := TRUE;
    -- Position 1: Symbol "RAISE"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '"RAISE"' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 2: Symbol <raise_statement_opt_1>
    IF po_success THEN
      <raise_statement_opt_1>(po_success);
    END IF;
    -- Position 3: Symbol ";"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '";"' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END <raise_statement>_1;

  PROCEDURE <raise_statement_opt_1>(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := FALSE;
    IF NOT po_success THEN
      <raise_statement_opt_1>_2(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      <raise_statement_opt_1>_3(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END <raise_statement_opt_1>;

  PROCEDURE <raise_statement_opt_1>_2(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := TRUE;
    -- Position 1: Symbol <exception_name>
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '<exception_name>' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END <raise_statement_opt_1>_2;

  PROCEDURE <raise_statement_opt_1>_3(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := TRUE;
    -- Position 1: Symbol EPSILON
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = 'EPSILON' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END <raise_statement_opt_1>_3;

  PROCEDURE <range>(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := FALSE;
    IF NOT po_success THEN
      <range>_0(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      <range>_1(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END <range>;

  PROCEDURE <range>_0(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := TRUE;
    -- Position 1: Symbol <expression>
    IF po_success THEN
      <expression>(po_success);
    END IF;
    -- Position 2: Symbol ".."
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '".."' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 3: Symbol <expression>
    IF po_success THEN
      <expression>(po_success);
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END <range>_0;

  PROCEDURE <range>_1(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := TRUE;
    -- Position 1: Symbol <expression>
    IF po_success THEN
      <expression>(po_success);
    END IF;
    -- Position 2: Symbol ".."
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '".."' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 3: Symbol <expression>
    IF po_success THEN
      <expression>(po_success);
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END <range>_1;

  PROCEDURE <statement>(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := FALSE;
    IF NOT po_success THEN
      <statement>_0(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      <statement>_1(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END <statement>;

  PROCEDURE <statement>_0(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := TRUE;
    -- Position 1: Symbol <assignment_statement>
    IF po_success THEN
      <assignment_statement>(po_success);
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END <statement>_0;

  PROCEDURE <statement>_1(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := TRUE;
    -- Position 1: Symbol <assignment_statement>
    IF po_success THEN
      <assignment_statement>(po_success);
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END <statement>_1;

  PROCEDURE <term>(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := FALSE;
    IF NOT po_success THEN
      <term>_0(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      <term>_1(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END <term>;

  PROCEDURE <term>_0(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := TRUE;
    -- Position 1: Symbol <literal>
    IF po_success THEN
      <literal>(po_success);
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END <term>_0;

  PROCEDURE <term>_1(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := TRUE;
    -- Position 1: Symbol <literal>
    IF po_success THEN
      <literal>(po_success);
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END <term>_1;

  PROCEDURE <trigger>(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := FALSE;
    IF NOT po_success THEN
      <trigger>_0(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      <trigger>_1(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END <trigger>;

  PROCEDURE <trigger>_0(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := TRUE;
    -- Position 1: Symbol "CREATE"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '"CREATE"' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 2: Symbol "OR"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '"OR"' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 3: Symbol "REPLACE"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '"REPLACE"' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 4: Symbol "TRIGGER"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '"TRIGGER"' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 5: Symbol <identifier>
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '<identifier>' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 6: Symbol <trigger_time_event>
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '<trigger_time_event>' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 7: Symbol <trigger_body>
    IF po_success THEN
      <trigger_body>(po_success);
    END IF;
    -- Position 8: Symbol "END"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '"END"' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 9: Symbol <identifier>
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '<identifier>' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 10: Symbol ";"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '";"' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END <trigger>_0;

  PROCEDURE <trigger>_1(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := TRUE;
    -- Position 1: Symbol "CREATE"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '"CREATE"' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 2: Symbol "OR"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '"OR"' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 3: Symbol "REPLACE"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '"REPLACE"' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 4: Symbol "TRIGGER"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '"TRIGGER"' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 5: Symbol <identifier>
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '<identifier>' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 6: Symbol <trigger_time_event>
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '<trigger_time_event>' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 7: Symbol <trigger_body>
    IF po_success THEN
      <trigger_body>(po_success);
    END IF;
    -- Position 8: Symbol "END"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '"END"' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 9: Symbol <identifier>
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '<identifier>' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 10: Symbol ";"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '";"' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END <trigger>_1;

  PROCEDURE <trigger_body>(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := FALSE;
    IF NOT po_success THEN
      <trigger_body>_0(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      <trigger_body>_1(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END <trigger_body>;

  PROCEDURE <trigger_body>_0(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := TRUE;
    -- Position 1: Symbol <declaration_section>
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '<declaration_section>' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 2: Symbol "BEGIN"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '"BEGIN"' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 3: Symbol <executable_section>
    IF po_success THEN
      <executable_section>(po_success);
    END IF;
    -- Position 4: Symbol ["EXCEPTION"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '["EXCEPTION"' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 5: Symbol <exception_section>]
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '<exception_section>]' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END <trigger_body>_0;

  PROCEDURE <trigger_body>_1(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := TRUE;
    -- Position 1: Symbol <declaration_section>
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '<declaration_section>' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 2: Symbol "BEGIN"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '"BEGIN"' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 3: Symbol <executable_section>
    IF po_success THEN
      <executable_section>(po_success);
    END IF;
    -- Position 4: Symbol <trigger_body_opt_1>
    IF po_success THEN
      <trigger_body_opt_1>(po_success);
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END <trigger_body>_1;

  PROCEDURE <trigger_body_opt_1>(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := FALSE;
    IF NOT po_success THEN
      <trigger_body_opt_1>_2(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      <trigger_body_opt_1>_3(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END <trigger_body_opt_1>;

  PROCEDURE <trigger_body_opt_1>_2(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := TRUE;
    -- Position 1: Symbol "EXCEPTION"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '"EXCEPTION"' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 2: Symbol <exception_section>
    IF po_success THEN
      <exception_section>(po_success);
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END <trigger_body_opt_1>_2;

  PROCEDURE <trigger_body_opt_1>_3(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := TRUE;
    -- Position 1: Symbol EPSILON
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = 'EPSILON' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END <trigger_body_opt_1>_3;

  PROCEDURE <variable_reference>(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := FALSE;
    IF NOT po_success THEN
      <variable_reference>_0(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      <variable_reference>_1(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END <variable_reference>;

  PROCEDURE <variable_reference>_0(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := TRUE;
    -- Position 1: Symbol <identifier>
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '<identifier>' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 2: Symbol ["."
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '["."' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 3: Symbol <field_name>]
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '<field_name>]' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END <variable_reference>_0;

  PROCEDURE <variable_reference>_1(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := TRUE;
    -- Position 1: Symbol <identifier>
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '<identifier>' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 2: Symbol <variable_reference_opt_1>
    IF po_success THEN
      <variable_reference_opt_1>(po_success);
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END <variable_reference>_1;

  PROCEDURE <variable_reference_opt_1>(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := FALSE;
    IF NOT po_success THEN
      <variable_reference_opt_1>_2(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      <variable_reference_opt_1>_3(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END <variable_reference_opt_1>;

  PROCEDURE <variable_reference_opt_1>_2(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := TRUE;
    -- Position 1: Symbol "."
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '"."' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 2: Symbol <field_name>
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '<field_name>' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END <variable_reference_opt_1>_2;

  PROCEDURE <variable_reference_opt_1>_3(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := TRUE;
    -- Position 1: Symbol EPSILON
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = 'EPSILON' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END <variable_reference_opt_1>_3;

  PROCEDURE <while_statement>(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := FALSE;
    IF NOT po_success THEN
      <while_statement>_0(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      <while_statement>_1(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END <while_statement>;

  PROCEDURE <while_statement>_0(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := TRUE;
    -- Position 1: Symbol "WHILE"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '"WHILE"' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 2: Symbol <condition>
    IF po_success THEN
      <condition>(po_success);
    END IF;
    -- Position 3: Symbol "LOOP"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '"LOOP"' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 4: Symbol <executable_section>
    IF po_success THEN
      <executable_section>(po_success);
    END IF;
    -- Position 5: Symbol "END
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '"END' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 6: Symbol LOOP"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = 'LOOP"' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 7: Symbol ";"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '";"' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END <while_statement>_0;

  PROCEDURE <while_statement>_1(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := TRUE;
    -- Position 1: Symbol "WHILE"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '"WHILE"' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 2: Symbol <condition>
    IF po_success THEN
      <condition>(po_success);
    END IF;
    -- Position 3: Symbol "LOOP"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '"LOOP"' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 4: Symbol <executable_section>
    IF po_success THEN
      <executable_section>(po_success);
    END IF;
    -- Position 5: Symbol "END
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '"END' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 6: Symbol LOOP"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = 'LOOP"' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 7: Symbol ";"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).tok_type = '";"' THEN
        g_curr_token_ix := g_curr_token_ix + 1;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END <while_statement>_1;

  PROCEDURE parse_main(p_token_stream IN t_token_list, po_success OUT BOOLEAN) IS
  BEGIN
    g_tokens := p_token_stream;
    g_curr_token_ix := 1;
    po_success := FALSE;

    IF NOT po_success THEN
      g_curr_token_ix := 1; -- Reset stream index for next entry option
      <block>(po_success);
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := 1; -- Reset stream index for next entry option
      <dynamic_sql_statement>(po_success);
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := 1; -- Reset stream index for next entry option
      <exit_statement>(po_success);
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := 1; -- Reset stream index for next entry option
      <for_statement>(po_success);
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := 1; -- Reset stream index for next entry option
      <function_body>(po_success);
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := 1; -- Reset stream index for next entry option
      <if_statement>(po_success);
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := 1; -- Reset stream index for next entry option
      <loop_statement>(po_success);
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := 1; -- Reset stream index for next entry option
      <null_statement>(po_success);
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := 1; -- Reset stream index for next entry option
      <package_body>(po_success);
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := 1; -- Reset stream index for next entry option
      <package_spec>(po_success);
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := 1; -- Reset stream index for next entry option
      <procedure_call>(po_success);
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := 1; -- Reset stream index for next entry option
      <raise_statement>(po_success);
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := 1; -- Reset stream index for next entry option
      <trigger>(po_success);
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := 1; -- Reset stream index for next entry option
      <while_statement>(po_success);
    END IF;
  END parse_main;

END PKG_DYNAMIC_PARSER;
/