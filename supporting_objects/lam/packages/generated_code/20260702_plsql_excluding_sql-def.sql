CREATE OR REPLACE PACKAGE PKG_DYNAMIC_PARSER AS
  -- Global collection type for tokens
  --TYPE t_token_list IS TABLE OF parser_token_rec;

  --g_tokens         t_token_list;
  g_tokens         parser_token_col;
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
  PROCEDURE parse_main(p_token_stream IN /*t_token_list*/ parser_token_col, po_success OUT BOOLEAN);
END PKG_DYNAMIC_PARSER;
/

