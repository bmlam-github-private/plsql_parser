CREATE OR REPLACE PACKAGE PKG_DYNAMIC_PARSER AS
  -- Global collection type for tokens
  TYPE t_token_list IS TABLE OF parser_token_rec;

  g_tokens         t_token_list;
  g_curr_token_ix  NUMBER := 1;

  PROCEDURE pr_assignment_statement(po_success OUT BOOLEAN);
  PROCEDURE pr_block(po_success OUT BOOLEAN);
  PROCEDURE pr_block_opt_1(po_success OUT BOOLEAN);
  PROCEDURE pr_block_opt_2(po_success OUT BOOLEAN);
  PROCEDURE pr_condition(po_success OUT BOOLEAN);
  PROCEDURE pr_dynamic_sql_statement(po_success OUT BOOLEAN);
  PROCEDURE pr_dynamic_sql_statement_opt_1(po_success OUT BOOLEAN);
  PROCEDURE pr_exception_handler(po_success OUT BOOLEAN);
  PROCEDURE pr_exception_section(po_success OUT BOOLEAN);
  PROCEDURE pr_exception_section_rep_1(po_success OUT BOOLEAN);
  PROCEDURE pr_executable_section(po_success OUT BOOLEAN);
  PROCEDURE pr_executable_section_rep_1(po_success OUT BOOLEAN);
  PROCEDURE pr_exit_statement(po_success OUT BOOLEAN);
  PROCEDURE pr_exit_statement_opt_1(po_success OUT BOOLEAN);
  PROCEDURE pr_expression(po_success OUT BOOLEAN);
  PROCEDURE pr_expression_list(po_success OUT BOOLEAN);
  PROCEDURE pr_expression_list_rep_1(po_success OUT BOOLEAN);
  PROCEDURE pr_expression_tail(po_success OUT BOOLEAN);
  PROCEDURE pr_for_statement(po_success OUT BOOLEAN);
  PROCEDURE pr_function_body(po_success OUT BOOLEAN);
  PROCEDURE pr_function_body_opt_1(po_success OUT BOOLEAN);
  PROCEDURE pr_if_statement(po_success OUT BOOLEAN);
  PROCEDURE pr_literal(po_success OUT BOOLEAN);
  PROCEDURE pr_loop_statement(po_success OUT BOOLEAN);
  PROCEDURE pr_null_statement(po_success OUT BOOLEAN);
  PROCEDURE pr_operator(po_success OUT BOOLEAN);
  PROCEDURE pr_package_body(po_success OUT BOOLEAN);
  PROCEDURE pr_package_body_element(po_success OUT BOOLEAN);
  PROCEDURE pr_package_body_rep_1(po_success OUT BOOLEAN);
  PROCEDURE pr_package_element(po_success OUT BOOLEAN);
  PROCEDURE pr_package_spec(po_success OUT BOOLEAN);
  PROCEDURE pr_package_spec_rep_1(po_success OUT BOOLEAN);
  PROCEDURE pr_procedure_body(po_success OUT BOOLEAN);
  PROCEDURE pr_procedure_body_opt_1(po_success OUT BOOLEAN);
  PROCEDURE pr_procedure_call(po_success OUT BOOLEAN);
  PROCEDURE pr_procedure_call_opt_1(po_success OUT BOOLEAN);
  PROCEDURE pr_raise_statement(po_success OUT BOOLEAN);
  PROCEDURE pr_raise_statement_opt_1(po_success OUT BOOLEAN);
  PROCEDURE pr_range(po_success OUT BOOLEAN);
  PROCEDURE pr_statement(po_success OUT BOOLEAN);
  PROCEDURE pr_term(po_success OUT BOOLEAN);
  PROCEDURE pr_trigger(po_success OUT BOOLEAN);
  PROCEDURE pr_trigger_body(po_success OUT BOOLEAN);
  PROCEDURE pr_trigger_body_opt_1(po_success OUT BOOLEAN);
  PROCEDURE pr_variable_reference(po_success OUT BOOLEAN);
  PROCEDURE pr_variable_reference_opt_1(po_success OUT BOOLEAN);
  PROCEDURE pr_while_statement(po_success OUT BOOLEAN);

  -- Main entry point for top-level parsing rules
  PROCEDURE parse_main(p_token_stream IN t_token_list, po_success OUT BOOLEAN);
END PKG_DYNAMIC_PARSER;

CREATE OR REPLACE PACKAGE BODY PKG_DYNAMIC_PARSER AS

  PROCEDURE pr_assignment_statement_0(po_success OUT BOOLEAN);
  PROCEDURE pr_assignment_statement_1(po_success OUT BOOLEAN);
  PROCEDURE pr_block_0(po_success OUT BOOLEAN);
  PROCEDURE pr_block_1(po_success OUT BOOLEAN);
  PROCEDURE pr_block_opt_1_2(po_success OUT BOOLEAN);
  PROCEDURE pr_block_opt_1_3(po_success OUT BOOLEAN);
  PROCEDURE pr_block_opt_2_4(po_success OUT BOOLEAN);
  PROCEDURE pr_block_opt_2_5(po_success OUT BOOLEAN);
  PROCEDURE pr_condition_0(po_success OUT BOOLEAN);
  PROCEDURE pr_condition_1(po_success OUT BOOLEAN);
  PROCEDURE pr_dynamic_sql_statement_0(po_success OUT BOOLEAN);
  PROCEDURE pr_dynamic_sql_statement_1(po_success OUT BOOLEAN);
  PROCEDURE pr_dynamic_sql_statement_opt_1_2(po_success OUT BOOLEAN);
  PROCEDURE pr_dynamic_sql_statement_opt_1_3(po_success OUT BOOLEAN);
  PROCEDURE pr_exception_handler_0(po_success OUT BOOLEAN);
  PROCEDURE pr_exception_handler_1(po_success OUT BOOLEAN);
  PROCEDURE pr_exception_section_0(po_success OUT BOOLEAN);
  PROCEDURE pr_exception_section_1(po_success OUT BOOLEAN);
  PROCEDURE pr_exception_section_rep_1_2(po_success OUT BOOLEAN);
  PROCEDURE pr_exception_section_rep_1_3(po_success OUT BOOLEAN);
  PROCEDURE pr_executable_section_0(po_success OUT BOOLEAN);
  PROCEDURE pr_executable_section_1(po_success OUT BOOLEAN);
  PROCEDURE pr_executable_section_rep_1_2(po_success OUT BOOLEAN);
  PROCEDURE pr_executable_section_rep_1_3(po_success OUT BOOLEAN);
  PROCEDURE pr_exit_statement_0(po_success OUT BOOLEAN);
  PROCEDURE pr_exit_statement_1(po_success OUT BOOLEAN);
  PROCEDURE pr_exit_statement_opt_1_2(po_success OUT BOOLEAN);
  PROCEDURE pr_exit_statement_opt_1_3(po_success OUT BOOLEAN);
  PROCEDURE pr_expression_0(po_success OUT BOOLEAN);
  PROCEDURE pr_expression_1(po_success OUT BOOLEAN);
  PROCEDURE pr_expression_list_0(po_success OUT BOOLEAN);
  PROCEDURE pr_expression_list_1(po_success OUT BOOLEAN);
  PROCEDURE pr_expression_list_rep_1_2(po_success OUT BOOLEAN);
  PROCEDURE pr_expression_list_rep_1_3(po_success OUT BOOLEAN);
  PROCEDURE pr_expression_tail_0(po_success OUT BOOLEAN);
  PROCEDURE pr_expression_tail_1(po_success OUT BOOLEAN);
  PROCEDURE pr_for_statement_0(po_success OUT BOOLEAN);
  PROCEDURE pr_for_statement_1(po_success OUT BOOLEAN);
  PROCEDURE pr_function_body_0(po_success OUT BOOLEAN);
  PROCEDURE pr_function_body_1(po_success OUT BOOLEAN);
  PROCEDURE pr_function_body_opt_1_2(po_success OUT BOOLEAN);
  PROCEDURE pr_function_body_opt_1_3(po_success OUT BOOLEAN);
  PROCEDURE pr_if_statement_0(po_success OUT BOOLEAN);
  PROCEDURE pr_if_statement_1(po_success OUT BOOLEAN);
  PROCEDURE pr_literal_0(po_success OUT BOOLEAN);
  PROCEDURE pr_literal_1(po_success OUT BOOLEAN);
  PROCEDURE pr_literal_2(po_success OUT BOOLEAN);
  PROCEDURE pr_literal_3(po_success OUT BOOLEAN);
  PROCEDURE pr_literal_4(po_success OUT BOOLEAN);
  PROCEDURE pr_literal_5(po_success OUT BOOLEAN);
  PROCEDURE pr_loop_statement_0(po_success OUT BOOLEAN);
  PROCEDURE pr_loop_statement_1(po_success OUT BOOLEAN);
  PROCEDURE pr_null_statement_0(po_success OUT BOOLEAN);
  PROCEDURE pr_null_statement_1(po_success OUT BOOLEAN);
  PROCEDURE pr_operator_0(po_success OUT BOOLEAN);
  PROCEDURE pr_operator_1(po_success OUT BOOLEAN);
  PROCEDURE pr_operator_2(po_success OUT BOOLEAN);
  PROCEDURE pr_operator_3(po_success OUT BOOLEAN);
  PROCEDURE pr_operator_4(po_success OUT BOOLEAN);
  PROCEDURE pr_operator_5(po_success OUT BOOLEAN);
  PROCEDURE pr_operator_6(po_success OUT BOOLEAN);
  PROCEDURE pr_operator_7(po_success OUT BOOLEAN);
  PROCEDURE pr_operator_8(po_success OUT BOOLEAN);
  PROCEDURE pr_operator_9(po_success OUT BOOLEAN);
  PROCEDURE pr_operator_10(po_success OUT BOOLEAN);
  PROCEDURE pr_operator_11(po_success OUT BOOLEAN);
  PROCEDURE pr_operator_12(po_success OUT BOOLEAN);
  PROCEDURE pr_operator_13(po_success OUT BOOLEAN);
  PROCEDURE pr_package_body_0(po_success OUT BOOLEAN);
  PROCEDURE pr_package_body_1(po_success OUT BOOLEAN);
  PROCEDURE pr_package_body_element_0(po_success OUT BOOLEAN);
  PROCEDURE pr_package_body_element_1(po_success OUT BOOLEAN);
  PROCEDURE pr_package_body_rep_1_2(po_success OUT BOOLEAN);
  PROCEDURE pr_package_body_rep_1_3(po_success OUT BOOLEAN);
  PROCEDURE pr_package_element_0(po_success OUT BOOLEAN);
  PROCEDURE pr_package_element_1(po_success OUT BOOLEAN);
  PROCEDURE pr_package_spec_0(po_success OUT BOOLEAN);
  PROCEDURE pr_package_spec_1(po_success OUT BOOLEAN);
  PROCEDURE pr_package_spec_rep_1_2(po_success OUT BOOLEAN);
  PROCEDURE pr_package_spec_rep_1_3(po_success OUT BOOLEAN);
  PROCEDURE pr_procedure_body_0(po_success OUT BOOLEAN);
  PROCEDURE pr_procedure_body_1(po_success OUT BOOLEAN);
  PROCEDURE pr_procedure_body_opt_1_2(po_success OUT BOOLEAN);
  PROCEDURE pr_procedure_body_opt_1_3(po_success OUT BOOLEAN);
  PROCEDURE pr_procedure_call_0(po_success OUT BOOLEAN);
  PROCEDURE pr_procedure_call_1(po_success OUT BOOLEAN);
  PROCEDURE pr_procedure_call_opt_1_2(po_success OUT BOOLEAN);
  PROCEDURE pr_procedure_call_opt_1_3(po_success OUT BOOLEAN);
  PROCEDURE pr_raise_statement_0(po_success OUT BOOLEAN);
  PROCEDURE pr_raise_statement_1(po_success OUT BOOLEAN);
  PROCEDURE pr_raise_statement_opt_1_2(po_success OUT BOOLEAN);
  PROCEDURE pr_raise_statement_opt_1_3(po_success OUT BOOLEAN);
  PROCEDURE pr_range_0(po_success OUT BOOLEAN);
  PROCEDURE pr_range_1(po_success OUT BOOLEAN);
  PROCEDURE pr_statement_0(po_success OUT BOOLEAN);
  PROCEDURE pr_statement_1(po_success OUT BOOLEAN);
  PROCEDURE pr_term_0(po_success OUT BOOLEAN);
  PROCEDURE pr_term_1(po_success OUT BOOLEAN);
  PROCEDURE pr_trigger_0(po_success OUT BOOLEAN);
  PROCEDURE pr_trigger_1(po_success OUT BOOLEAN);
  PROCEDURE pr_trigger_body_0(po_success OUT BOOLEAN);
  PROCEDURE pr_trigger_body_1(po_success OUT BOOLEAN);
  PROCEDURE pr_trigger_body_opt_1_2(po_success OUT BOOLEAN);
  PROCEDURE pr_trigger_body_opt_1_3(po_success OUT BOOLEAN);
  PROCEDURE pr_variable_reference_0(po_success OUT BOOLEAN);
  PROCEDURE pr_variable_reference_1(po_success OUT BOOLEAN);
  PROCEDURE pr_variable_reference_opt_1_2(po_success OUT BOOLEAN);
  PROCEDURE pr_variable_reference_opt_1_3(po_success OUT BOOLEAN);
  PROCEDURE pr_while_statement_0(po_success OUT BOOLEAN);
  PROCEDURE pr_while_statement_1(po_success OUT BOOLEAN);

  PROCEDURE pr_assignment_statement(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := FALSE;
    IF NOT po_success THEN
      pr_assignment_statement_0(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      pr_assignment_statement_1(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END pr_assignment_statement;

  PROCEDURE pr_assignment_statement_0(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := TRUE;
    -- Position 1: Symbol <variable_reference>
    IF po_success THEN
      pr_variable_reference(po_success);
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
      pr_expression(po_success);
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

  PROCEDURE pr_assignment_statement_1(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := TRUE;
    -- Position 1: Symbol <variable_reference>
    IF po_success THEN
      pr_variable_reference(po_success);
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
      pr_expression(po_success);
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

  PROCEDURE pr_block(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := FALSE;
    IF NOT po_success THEN
      pr_block_0(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      pr_block_1(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END pr_block;

  PROCEDURE pr_block_0(po_success OUT BOOLEAN) IS
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
      pr_executable_section(po_success);
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

  PROCEDURE pr_block_1(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := TRUE;
    -- Position 1: Symbol <block_opt_1>
    IF po_success THEN
      pr_block_opt_1(po_success);
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
      pr_executable_section(po_success);
    END IF;
    -- Position 4: Symbol <block_opt_2>
    IF po_success THEN
      pr_block_opt_2(po_success);
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

  PROCEDURE pr_block_opt_1(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := FALSE;
    IF NOT po_success THEN
      pr_block_opt_1_2(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      pr_block_opt_1_3(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END pr_block_opt_1;

  PROCEDURE pr_block_opt_1_2(po_success OUT BOOLEAN) IS
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

  PROCEDURE pr_block_opt_1_3(po_success OUT BOOLEAN) IS
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

  PROCEDURE pr_block_opt_2(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := FALSE;
    IF NOT po_success THEN
      pr_block_opt_2_4(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      pr_block_opt_2_5(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END pr_block_opt_2;

  PROCEDURE pr_block_opt_2_4(po_success OUT BOOLEAN) IS
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
      pr_exception_section(po_success);
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END <block_opt_2>_4;

  PROCEDURE pr_block_opt_2_5(po_success OUT BOOLEAN) IS
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

  PROCEDURE pr_condition(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := FALSE;
    IF NOT po_success THEN
      pr_condition_0(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      pr_condition_1(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END pr_condition;

  PROCEDURE pr_condition_0(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := TRUE;
    -- Position 1: Symbol <expression>
    IF po_success THEN
      pr_expression(po_success);
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END <condition>_0;

  PROCEDURE pr_condition_1(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := TRUE;
    -- Position 1: Symbol <expression>
    IF po_success THEN
      pr_expression(po_success);
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END <condition>_1;

  PROCEDURE pr_dynamic_sql_statement(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := FALSE;
    IF NOT po_success THEN
      pr_dynamic_sql_statement_0(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      pr_dynamic_sql_statement_1(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END pr_dynamic_sql_statement;

  PROCEDURE pr_dynamic_sql_statement_0(po_success OUT BOOLEAN) IS
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

  PROCEDURE pr_dynamic_sql_statement_1(po_success OUT BOOLEAN) IS
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
      pr_dynamic_sql_statement_opt_1(po_success);
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

  PROCEDURE pr_dynamic_sql_statement_opt_1(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := FALSE;
    IF NOT po_success THEN
      pr_dynamic_sql_statement_opt_1_2(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      pr_dynamic_sql_statement_opt_1_3(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END pr_dynamic_sql_statement_opt_1;

  PROCEDURE pr_dynamic_sql_statement_opt_1_2(po_success OUT BOOLEAN) IS
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
      pr_variable_reference(po_success);
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END <dynamic_sql_statement_opt_1>_2;

  PROCEDURE pr_dynamic_sql_statement_opt_1_3(po_success OUT BOOLEAN) IS
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

  PROCEDURE pr_exception_handler(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := FALSE;
    IF NOT po_success THEN
      pr_exception_handler_0(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      pr_exception_handler_1(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END pr_exception_handler;

  PROCEDURE pr_exception_handler_0(po_success OUT BOOLEAN) IS
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
      pr_executable_section(po_success);
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END <exception_handler>_0;

  PROCEDURE pr_exception_handler_1(po_success OUT BOOLEAN) IS
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
      pr_executable_section(po_success);
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END <exception_handler>_1;

  PROCEDURE pr_exception_section(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := FALSE;
    IF NOT po_success THEN
      pr_exception_section_0(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      pr_exception_section_1(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END pr_exception_section;

  PROCEDURE pr_exception_section_0(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := TRUE;
    -- Position 1: Symbol <exception_handler>
    IF po_success THEN
      pr_exception_handler(po_success);
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

  PROCEDURE pr_exception_section_1(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := TRUE;
    -- Position 1: Symbol <exception_handler>
    IF po_success THEN
      pr_exception_handler(po_success);
    END IF;
    -- Position 2: Symbol <exception_section_rep_1>
    IF po_success THEN
      pr_exception_section_rep_1(po_success);
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END <exception_section>_1;

  PROCEDURE pr_exception_section_rep_1(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := FALSE;
    IF NOT po_success THEN
      pr_exception_section_rep_1_2(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      pr_exception_section_rep_1_3(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END pr_exception_section_rep_1;

  PROCEDURE pr_exception_section_rep_1_2(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := TRUE;
    -- Position 1: Symbol <exception_handler>
    IF po_success THEN
      pr_exception_handler(po_success);
    END IF;
    -- Position 2: Symbol <exception_section_rep_1>
    IF po_success THEN
      pr_exception_section_rep_1(po_success);
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END <exception_section_rep_1>_2;

  PROCEDURE pr_exception_section_rep_1_3(po_success OUT BOOLEAN) IS
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

  PROCEDURE pr_executable_section(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := FALSE;
    IF NOT po_success THEN
      pr_executable_section_0(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      pr_executable_section_1(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END pr_executable_section;

  PROCEDURE pr_executable_section_0(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := TRUE;
    -- Position 1: Symbol <statement>
    IF po_success THEN
      pr_statement(po_success);
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

  PROCEDURE pr_executable_section_1(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := TRUE;
    -- Position 1: Symbol <statement>
    IF po_success THEN
      pr_statement(po_success);
    END IF;
    -- Position 2: Symbol <executable_section_rep_1>
    IF po_success THEN
      pr_executable_section_rep_1(po_success);
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END <executable_section>_1;

  PROCEDURE pr_executable_section_rep_1(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := FALSE;
    IF NOT po_success THEN
      pr_executable_section_rep_1_2(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      pr_executable_section_rep_1_3(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END pr_executable_section_rep_1;

  PROCEDURE pr_executable_section_rep_1_2(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := TRUE;
    -- Position 1: Symbol <statement>
    IF po_success THEN
      pr_statement(po_success);
    END IF;
    -- Position 2: Symbol <executable_section_rep_1>
    IF po_success THEN
      pr_executable_section_rep_1(po_success);
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END <executable_section_rep_1>_2;

  PROCEDURE pr_executable_section_rep_1_3(po_success OUT BOOLEAN) IS
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

  PROCEDURE pr_exit_statement(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := FALSE;
    IF NOT po_success THEN
      pr_exit_statement_0(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      pr_exit_statement_1(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END pr_exit_statement;

  PROCEDURE pr_exit_statement_0(po_success OUT BOOLEAN) IS
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

  PROCEDURE pr_exit_statement_1(po_success OUT BOOLEAN) IS
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
      pr_exit_statement_opt_1(po_success);
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

  PROCEDURE pr_exit_statement_opt_1(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := FALSE;
    IF NOT po_success THEN
      pr_exit_statement_opt_1_2(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      pr_exit_statement_opt_1_3(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END pr_exit_statement_opt_1;

  PROCEDURE pr_exit_statement_opt_1_2(po_success OUT BOOLEAN) IS
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
      pr_condition(po_success);
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END <exit_statement_opt_1>_2;

  PROCEDURE pr_exit_statement_opt_1_3(po_success OUT BOOLEAN) IS
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

  PROCEDURE pr_expression(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := FALSE;
    IF NOT po_success THEN
      pr_expression_0(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      pr_expression_1(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END pr_expression;

  PROCEDURE pr_expression_0(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := TRUE;
    -- Position 1: Symbol <term>
    IF po_success THEN
      pr_term(po_success);
    END IF;
    -- Position 2: Symbol <expression_tail>
    IF po_success THEN
      pr_expression_tail(po_success);
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END <expression>_0;

  PROCEDURE pr_expression_1(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := TRUE;
    -- Position 1: Symbol <term>
    IF po_success THEN
      pr_term(po_success);
    END IF;
    -- Position 2: Symbol <expression_tail>
    IF po_success THEN
      pr_expression_tail(po_success);
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END <expression>_1;

  PROCEDURE pr_expression_list(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := FALSE;
    IF NOT po_success THEN
      pr_expression_list_0(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      pr_expression_list_1(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END pr_expression_list;

  PROCEDURE pr_expression_list_0(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := TRUE;
    -- Position 1: Symbol <expression>
    IF po_success THEN
      pr_expression(po_success);
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

  PROCEDURE pr_expression_list_1(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := TRUE;
    -- Position 1: Symbol <expression>
    IF po_success THEN
      pr_expression(po_success);
    END IF;
    -- Position 2: Symbol <expression_list_rep_1>
    IF po_success THEN
      pr_expression_list_rep_1(po_success);
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END <expression_list>_1;

  PROCEDURE pr_expression_list_rep_1(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := FALSE;
    IF NOT po_success THEN
      pr_expression_list_rep_1_2(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      pr_expression_list_rep_1_3(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END pr_expression_list_rep_1;

  PROCEDURE pr_expression_list_rep_1_2(po_success OUT BOOLEAN) IS
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
      pr_expression(po_success);
    END IF;
    -- Position 3: Symbol <expression_list_rep_1>
    IF po_success THEN
      pr_expression_list_rep_1(po_success);
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END <expression_list_rep_1>_2;

  PROCEDURE pr_expression_list_rep_1_3(po_success OUT BOOLEAN) IS
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

  PROCEDURE pr_expression_tail(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := FALSE;
    IF NOT po_success THEN
      pr_expression_tail_0(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      pr_expression_tail_1(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END pr_expression_tail;

  PROCEDURE pr_expression_tail_0(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := TRUE;
    -- Position 1: Symbol <operator>
    IF po_success THEN
      pr_operator(po_success);
    END IF;
    -- Position 2: Symbol <term>
    IF po_success THEN
      pr_term(po_success);
    END IF;
    -- Position 3: Symbol <expression_tail>
    IF po_success THEN
      pr_expression_tail(po_success);
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END <expression_tail>_0;

  PROCEDURE pr_expression_tail_1(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := TRUE;
    -- Position 1: Symbol <operator>
    IF po_success THEN
      pr_operator(po_success);
    END IF;
    -- Position 2: Symbol <term>
    IF po_success THEN
      pr_term(po_success);
    END IF;
    -- Position 3: Symbol <expression_tail>
    IF po_success THEN
      pr_expression_tail(po_success);
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END <expression_tail>_1;

  PROCEDURE pr_for_statement(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := FALSE;
    IF NOT po_success THEN
      pr_for_statement_0(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      pr_for_statement_1(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END pr_for_statement;

  PROCEDURE pr_for_statement_0(po_success OUT BOOLEAN) IS
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
      pr_range(po_success);
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
      pr_executable_section(po_success);
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

  PROCEDURE pr_for_statement_1(po_success OUT BOOLEAN) IS
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
      pr_range(po_success);
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
      pr_executable_section(po_success);
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

  PROCEDURE pr_function_body(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := FALSE;
    IF NOT po_success THEN
      pr_function_body_0(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      pr_function_body_1(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END pr_function_body;

  PROCEDURE pr_function_body_0(po_success OUT BOOLEAN) IS
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
      pr_executable_section(po_success);
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

  PROCEDURE pr_function_body_1(po_success OUT BOOLEAN) IS
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
      pr_executable_section(po_success);
    END IF;
    -- Position 6: Symbol <function_body_opt_1>
    IF po_success THEN
      pr_function_body_opt_1(po_success);
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

  PROCEDURE pr_function_body_opt_1(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := FALSE;
    IF NOT po_success THEN
      pr_function_body_opt_1_2(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      pr_function_body_opt_1_3(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END pr_function_body_opt_1;

  PROCEDURE pr_function_body_opt_1_2(po_success OUT BOOLEAN) IS
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
      pr_exception_section(po_success);
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END <function_body_opt_1>_2;

  PROCEDURE pr_function_body_opt_1_3(po_success OUT BOOLEAN) IS
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

  PROCEDURE pr_if_statement(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := FALSE;
    IF NOT po_success THEN
      pr_if_statement_0(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      pr_if_statement_1(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END pr_if_statement;

  PROCEDURE pr_if_statement_0(po_success OUT BOOLEAN) IS
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
      pr_condition(po_success);
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
      pr_executable_section(po_success);
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END <if_statement>_0;

  PROCEDURE pr_if_statement_1(po_success OUT BOOLEAN) IS
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
      pr_condition(po_success);
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
      pr_executable_section(po_success);
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END <if_statement>_1;

  PROCEDURE pr_literal(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := FALSE;
    IF NOT po_success THEN
      pr_literal_0(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      pr_literal_1(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      pr_literal_2(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      pr_literal_3(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      pr_literal_4(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      pr_literal_5(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END pr_literal;

  PROCEDURE pr_literal_0(po_success OUT BOOLEAN) IS
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

  PROCEDURE pr_literal_1(po_success OUT BOOLEAN) IS
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

  PROCEDURE pr_literal_2(po_success OUT BOOLEAN) IS
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

  PROCEDURE pr_literal_3(po_success OUT BOOLEAN) IS
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

  PROCEDURE pr_literal_4(po_success OUT BOOLEAN) IS
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

  PROCEDURE pr_literal_5(po_success OUT BOOLEAN) IS
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

  PROCEDURE pr_loop_statement(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := FALSE;
    IF NOT po_success THEN
      pr_loop_statement_0(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      pr_loop_statement_1(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END pr_loop_statement;

  PROCEDURE pr_loop_statement_0(po_success OUT BOOLEAN) IS
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
      pr_executable_section(po_success);
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

  PROCEDURE pr_loop_statement_1(po_success OUT BOOLEAN) IS
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
      pr_executable_section(po_success);
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

  PROCEDURE pr_null_statement(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := FALSE;
    IF NOT po_success THEN
      pr_null_statement_0(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      pr_null_statement_1(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END pr_null_statement;

  PROCEDURE pr_null_statement_0(po_success OUT BOOLEAN) IS
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

  PROCEDURE pr_null_statement_1(po_success OUT BOOLEAN) IS
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

  PROCEDURE pr_operator(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := FALSE;
    IF NOT po_success THEN
      pr_operator_0(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      pr_operator_1(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      pr_operator_2(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      pr_operator_3(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      pr_operator_4(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      pr_operator_5(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      pr_operator_6(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      pr_operator_7(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      pr_operator_8(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      pr_operator_9(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      pr_operator_10(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      pr_operator_11(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      pr_operator_12(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      pr_operator_13(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END pr_operator;

  PROCEDURE pr_operator_0(po_success OUT BOOLEAN) IS
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

  PROCEDURE pr_operator_1(po_success OUT BOOLEAN) IS
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

  PROCEDURE pr_operator_2(po_success OUT BOOLEAN) IS
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

  PROCEDURE pr_operator_3(po_success OUT BOOLEAN) IS
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

  PROCEDURE pr_operator_4(po_success OUT BOOLEAN) IS
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

  PROCEDURE pr_operator_5(po_success OUT BOOLEAN) IS
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

  PROCEDURE pr_operator_6(po_success OUT BOOLEAN) IS
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

  PROCEDURE pr_operator_7(po_success OUT BOOLEAN) IS
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

  PROCEDURE pr_operator_8(po_success OUT BOOLEAN) IS
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

  PROCEDURE pr_operator_9(po_success OUT BOOLEAN) IS
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

  PROCEDURE pr_operator_10(po_success OUT BOOLEAN) IS
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

  PROCEDURE pr_operator_11(po_success OUT BOOLEAN) IS
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

  PROCEDURE pr_operator_12(po_success OUT BOOLEAN) IS
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

  PROCEDURE pr_operator_13(po_success OUT BOOLEAN) IS
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

  PROCEDURE pr_package_body(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := FALSE;
    IF NOT po_success THEN
      pr_package_body_0(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      pr_package_body_1(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END pr_package_body;

  PROCEDURE pr_package_body_0(po_success OUT BOOLEAN) IS
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

  PROCEDURE pr_package_body_1(po_success OUT BOOLEAN) IS
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
      pr_package_body_rep_1(po_success);
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

  PROCEDURE pr_package_body_element(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := FALSE;
    IF NOT po_success THEN
      pr_package_body_element_0(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      pr_package_body_element_1(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END pr_package_body_element;

  PROCEDURE pr_package_body_element_0(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := TRUE;
    -- Position 1: Symbol <procedure_body>
    IF po_success THEN
      pr_procedure_body(po_success);
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END <package_body_element>_0;

  PROCEDURE pr_package_body_element_1(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := TRUE;
    -- Position 1: Symbol <procedure_body>
    IF po_success THEN
      pr_procedure_body(po_success);
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END <package_body_element>_1;

  PROCEDURE pr_package_body_rep_1(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := FALSE;
    IF NOT po_success THEN
      pr_package_body_rep_1_2(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      pr_package_body_rep_1_3(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END pr_package_body_rep_1;

  PROCEDURE pr_package_body_rep_1_2(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := TRUE;
    -- Position 1: Symbol <package_body_element>
    IF po_success THEN
      pr_package_body_element(po_success);
    END IF;
    -- Position 2: Symbol <package_body_rep_1>
    IF po_success THEN
      pr_package_body_rep_1(po_success);
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END <package_body_rep_1>_2;

  PROCEDURE pr_package_body_rep_1_3(po_success OUT BOOLEAN) IS
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

  PROCEDURE pr_package_element(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := FALSE;
    IF NOT po_success THEN
      pr_package_element_0(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      pr_package_element_1(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END pr_package_element;

  PROCEDURE pr_package_element_0(po_success OUT BOOLEAN) IS
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

  PROCEDURE pr_package_element_1(po_success OUT BOOLEAN) IS
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

  PROCEDURE pr_package_spec(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := FALSE;
    IF NOT po_success THEN
      pr_package_spec_0(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      pr_package_spec_1(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END pr_package_spec;

  PROCEDURE pr_package_spec_0(po_success OUT BOOLEAN) IS
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

  PROCEDURE pr_package_spec_1(po_success OUT BOOLEAN) IS
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
      pr_package_spec_rep_1(po_success);
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

  PROCEDURE pr_package_spec_rep_1(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := FALSE;
    IF NOT po_success THEN
      pr_package_spec_rep_1_2(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      pr_package_spec_rep_1_3(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END pr_package_spec_rep_1;

  PROCEDURE pr_package_spec_rep_1_2(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := TRUE;
    -- Position 1: Symbol <package_element>
    IF po_success THEN
      pr_package_element(po_success);
    END IF;
    -- Position 2: Symbol <package_spec_rep_1>
    IF po_success THEN
      pr_package_spec_rep_1(po_success);
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END <package_spec_rep_1>_2;

  PROCEDURE pr_package_spec_rep_1_3(po_success OUT BOOLEAN) IS
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

  PROCEDURE pr_procedure_body(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := FALSE;
    IF NOT po_success THEN
      pr_procedure_body_0(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      pr_procedure_body_1(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END pr_procedure_body;

  PROCEDURE pr_procedure_body_0(po_success OUT BOOLEAN) IS
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
      pr_executable_section(po_success);
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

  PROCEDURE pr_procedure_body_1(po_success OUT BOOLEAN) IS
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
      pr_executable_section(po_success);
    END IF;
    -- Position 6: Symbol <procedure_body_opt_1>
    IF po_success THEN
      pr_procedure_body_opt_1(po_success);
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

  PROCEDURE pr_procedure_body_opt_1(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := FALSE;
    IF NOT po_success THEN
      pr_procedure_body_opt_1_2(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      pr_procedure_body_opt_1_3(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END pr_procedure_body_opt_1;

  PROCEDURE pr_procedure_body_opt_1_2(po_success OUT BOOLEAN) IS
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
      pr_exception_section(po_success);
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END <procedure_body_opt_1>_2;

  PROCEDURE pr_procedure_body_opt_1_3(po_success OUT BOOLEAN) IS
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

  PROCEDURE pr_procedure_call(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := FALSE;
    IF NOT po_success THEN
      pr_procedure_call_0(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      pr_procedure_call_1(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END pr_procedure_call;

  PROCEDURE pr_procedure_call_0(po_success OUT BOOLEAN) IS
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
      pr_expression_list(po_success);
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

  PROCEDURE pr_procedure_call_1(po_success OUT BOOLEAN) IS
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
      pr_procedure_call_opt_1(po_success);
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

  PROCEDURE pr_procedure_call_opt_1(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := FALSE;
    IF NOT po_success THEN
      pr_procedure_call_opt_1_2(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      pr_procedure_call_opt_1_3(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END pr_procedure_call_opt_1;

  PROCEDURE pr_procedure_call_opt_1_2(po_success OUT BOOLEAN) IS
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
      pr_expression_list(po_success);
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

  PROCEDURE pr_procedure_call_opt_1_3(po_success OUT BOOLEAN) IS
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

  PROCEDURE pr_raise_statement(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := FALSE;
    IF NOT po_success THEN
      pr_raise_statement_0(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      pr_raise_statement_1(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END pr_raise_statement;

  PROCEDURE pr_raise_statement_0(po_success OUT BOOLEAN) IS
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

  PROCEDURE pr_raise_statement_1(po_success OUT BOOLEAN) IS
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
      pr_raise_statement_opt_1(po_success);
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

  PROCEDURE pr_raise_statement_opt_1(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := FALSE;
    IF NOT po_success THEN
      pr_raise_statement_opt_1_2(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      pr_raise_statement_opt_1_3(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END pr_raise_statement_opt_1;

  PROCEDURE pr_raise_statement_opt_1_2(po_success OUT BOOLEAN) IS
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

  PROCEDURE pr_raise_statement_opt_1_3(po_success OUT BOOLEAN) IS
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

  PROCEDURE pr_range(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := FALSE;
    IF NOT po_success THEN
      pr_range_0(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      pr_range_1(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END pr_range;

  PROCEDURE pr_range_0(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := TRUE;
    -- Position 1: Symbol <expression>
    IF po_success THEN
      pr_expression(po_success);
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
      pr_expression(po_success);
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END <range>_0;

  PROCEDURE pr_range_1(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := TRUE;
    -- Position 1: Symbol <expression>
    IF po_success THEN
      pr_expression(po_success);
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
      pr_expression(po_success);
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END <range>_1;

  PROCEDURE pr_statement(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := FALSE;
    IF NOT po_success THEN
      pr_statement_0(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      pr_statement_1(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END pr_statement;

  PROCEDURE pr_statement_0(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := TRUE;
    -- Position 1: Symbol <assignment_statement>
    IF po_success THEN
      pr_assignment_statement(po_success);
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END <statement>_0;

  PROCEDURE pr_statement_1(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := TRUE;
    -- Position 1: Symbol <assignment_statement>
    IF po_success THEN
      pr_assignment_statement(po_success);
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END <statement>_1;

  PROCEDURE pr_term(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := FALSE;
    IF NOT po_success THEN
      pr_term_0(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      pr_term_1(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END pr_term;

  PROCEDURE pr_term_0(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := TRUE;
    -- Position 1: Symbol <literal>
    IF po_success THEN
      pr_literal(po_success);
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END <term>_0;

  PROCEDURE pr_term_1(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := TRUE;
    -- Position 1: Symbol <literal>
    IF po_success THEN
      pr_literal(po_success);
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END <term>_1;

  PROCEDURE pr_trigger(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := FALSE;
    IF NOT po_success THEN
      pr_trigger_0(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      pr_trigger_1(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END pr_trigger;

  PROCEDURE pr_trigger_0(po_success OUT BOOLEAN) IS
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
      pr_trigger_body(po_success);
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

  PROCEDURE pr_trigger_1(po_success OUT BOOLEAN) IS
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
      pr_trigger_body(po_success);
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

  PROCEDURE pr_trigger_body(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := FALSE;
    IF NOT po_success THEN
      pr_trigger_body_0(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      pr_trigger_body_1(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END pr_trigger_body;

  PROCEDURE pr_trigger_body_0(po_success OUT BOOLEAN) IS
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
      pr_executable_section(po_success);
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

  PROCEDURE pr_trigger_body_1(po_success OUT BOOLEAN) IS
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
      pr_executable_section(po_success);
    END IF;
    -- Position 4: Symbol <trigger_body_opt_1>
    IF po_success THEN
      pr_trigger_body_opt_1(po_success);
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END <trigger_body>_1;

  PROCEDURE pr_trigger_body_opt_1(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := FALSE;
    IF NOT po_success THEN
      pr_trigger_body_opt_1_2(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      pr_trigger_body_opt_1_3(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END pr_trigger_body_opt_1;

  PROCEDURE pr_trigger_body_opt_1_2(po_success OUT BOOLEAN) IS
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
      pr_exception_section(po_success);
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END <trigger_body_opt_1>_2;

  PROCEDURE pr_trigger_body_opt_1_3(po_success OUT BOOLEAN) IS
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

  PROCEDURE pr_variable_reference(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := FALSE;
    IF NOT po_success THEN
      pr_variable_reference_0(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      pr_variable_reference_1(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END pr_variable_reference;

  PROCEDURE pr_variable_reference_0(po_success OUT BOOLEAN) IS
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

  PROCEDURE pr_variable_reference_1(po_success OUT BOOLEAN) IS
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
      pr_variable_reference_opt_1(po_success);
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END <variable_reference>_1;

  PROCEDURE pr_variable_reference_opt_1(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := FALSE;
    IF NOT po_success THEN
      pr_variable_reference_opt_1_2(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      pr_variable_reference_opt_1_3(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END pr_variable_reference_opt_1;

  PROCEDURE pr_variable_reference_opt_1_2(po_success OUT BOOLEAN) IS
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

  PROCEDURE pr_variable_reference_opt_1_3(po_success OUT BOOLEAN) IS
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

  PROCEDURE pr_while_statement(po_success OUT BOOLEAN) IS
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := FALSE;
    IF NOT po_success THEN
      pr_while_statement_0(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      pr_while_statement_1(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END pr_while_statement;

  PROCEDURE pr_while_statement_0(po_success OUT BOOLEAN) IS
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
      pr_condition(po_success);
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
      pr_executable_section(po_success);
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

  PROCEDURE pr_while_statement_1(po_success OUT BOOLEAN) IS
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
      pr_condition(po_success);
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
      pr_executable_section(po_success);
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