CREATE OR REPLACE PACKAGE BODY PKG_DYNAMIC_PARSER AS

  PROCEDURE pr_assignment_statement_1(po_success OUT BOOLEAN);
  PROCEDURE pr_block_1(po_success OUT BOOLEAN);
  PROCEDURE pr_block_opt_1_2(po_success OUT BOOLEAN);
  PROCEDURE pr_block_opt_1_3(po_success OUT BOOLEAN);
  PROCEDURE pr_block_opt_2_4(po_success OUT BOOLEAN);
  PROCEDURE pr_block_opt_2_5(po_success OUT BOOLEAN);
  PROCEDURE pr_collection_type_definition_1(po_success OUT BOOLEAN);
  PROCEDURE pr_collection_type_definition_opt_1_2(po_success OUT BOOLEAN);
  PROCEDURE pr_collection_type_definition_opt_1_3(po_success OUT BOOLEAN);
  PROCEDURE pr_column_list_1(po_success OUT BOOLEAN);
  PROCEDURE pr_column_list_rep_1_2(po_success OUT BOOLEAN);
  PROCEDURE pr_column_list_rep_1_3(po_success OUT BOOLEAN);
  PROCEDURE pr_commit_statement_1(po_success OUT BOOLEAN);
  PROCEDURE pr_condition_1(po_success OUT BOOLEAN);
  PROCEDURE pr_constant_declaration_1(po_success OUT BOOLEAN);
  PROCEDURE pr_cursor_declaration_1(po_success OUT BOOLEAN);
  PROCEDURE pr_cursor_declaration_opt_1_2(po_success OUT BOOLEAN);
  PROCEDURE pr_cursor_declaration_opt_1_3(po_success OUT BOOLEAN);
  PROCEDURE pr_data_type_1(po_success OUT BOOLEAN);
  PROCEDURE pr_data_type_opt_1_2(po_success OUT BOOLEAN);
  PROCEDURE pr_data_type_opt_1_3(po_success OUT BOOLEAN);
  PROCEDURE pr_data_type_opt_1_4(po_success OUT BOOLEAN);
  PROCEDURE pr_declaration_1(po_success OUT BOOLEAN);
  PROCEDURE pr_declaration_section_1(po_success OUT BOOLEAN);
  PROCEDURE pr_declaration_section_rep_1_2(po_success OUT BOOLEAN);
  PROCEDURE pr_declaration_section_rep_1_3(po_success OUT BOOLEAN);
  PROCEDURE pr_dynamic_sql_statement_1(po_success OUT BOOLEAN);
  PROCEDURE pr_dynamic_sql_statement_opt_1_2(po_success OUT BOOLEAN);
  PROCEDURE pr_dynamic_sql_statement_opt_1_3(po_success OUT BOOLEAN);
  PROCEDURE pr_exception_declaration_1(po_success OUT BOOLEAN);
  PROCEDURE pr_exception_handler_1(po_success OUT BOOLEAN);
  PROCEDURE pr_exception_name_1(po_success OUT BOOLEAN);
  PROCEDURE pr_exception_section_1(po_success OUT BOOLEAN);
  PROCEDURE pr_exception_section_rep_1_2(po_success OUT BOOLEAN);
  PROCEDURE pr_exception_section_rep_1_3(po_success OUT BOOLEAN);
  PROCEDURE pr_executable_section_1(po_success OUT BOOLEAN);
  PROCEDURE pr_executable_section_rep_1_2(po_success OUT BOOLEAN);
  PROCEDURE pr_executable_section_rep_1_3(po_success OUT BOOLEAN);
  PROCEDURE pr_exit_statement_1(po_success OUT BOOLEAN);
  PROCEDURE pr_exit_statement_opt_1_2(po_success OUT BOOLEAN);
  PROCEDURE pr_exit_statement_opt_1_3(po_success OUT BOOLEAN);
  PROCEDURE pr_expression_1(po_success OUT BOOLEAN);
  PROCEDURE pr_expression_list_1(po_success OUT BOOLEAN);
  PROCEDURE pr_expression_list_rep_1_2(po_success OUT BOOLEAN);
  PROCEDURE pr_expression_list_rep_1_3(po_success OUT BOOLEAN);
  PROCEDURE pr_expression_tail_1(po_success OUT BOOLEAN);
  PROCEDURE pr_field_name_1(po_success OUT BOOLEAN);
  PROCEDURE pr_for_statement_1(po_success OUT BOOLEAN);
  PROCEDURE pr_function_body_1(po_success OUT BOOLEAN);
  PROCEDURE pr_function_body_opt_1_2(po_success OUT BOOLEAN);
  PROCEDURE pr_function_body_opt_1_3(po_success OUT BOOLEAN);
  PROCEDURE pr_function_call_1(po_success OUT BOOLEAN);
  PROCEDURE pr_function_call_opt_1_2(po_success OUT BOOLEAN);
  PROCEDURE pr_function_call_opt_1_3(po_success OUT BOOLEAN);
  PROCEDURE pr_function_spec_1(po_success OUT BOOLEAN);
  PROCEDURE pr_function_spec_opt_1_2(po_success OUT BOOLEAN);
  PROCEDURE pr_function_spec_opt_1_3(po_success OUT BOOLEAN);
  PROCEDURE pr_if_statement_1(po_success OUT BOOLEAN);
  PROCEDURE pr_index_by_type_1(po_success OUT BOOLEAN);
  PROCEDURE pr_literal_1(po_success OUT BOOLEAN);
  PROCEDURE pr_literal_2(po_success OUT BOOLEAN);
  PROCEDURE pr_literal_3(po_success OUT BOOLEAN);
  PROCEDURE pr_literal_4(po_success OUT BOOLEAN);
  PROCEDURE pr_literal_5(po_success OUT BOOLEAN);
  PROCEDURE pr_loop_statement_1(po_success OUT BOOLEAN);
  PROCEDURE pr_null_statement_1(po_success OUT BOOLEAN);
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
  PROCEDURE pr_other_sql_statement_1(po_success OUT BOOLEAN);
  PROCEDURE pr_package_body_1(po_success OUT BOOLEAN);
  PROCEDURE pr_package_body_element_1(po_success OUT BOOLEAN);
  PROCEDURE pr_package_body_rep_1_2(po_success OUT BOOLEAN);
  PROCEDURE pr_package_body_rep_1_3(po_success OUT BOOLEAN);
  PROCEDURE pr_package_element_1(po_success OUT BOOLEAN);
  PROCEDURE pr_package_spec_1(po_success OUT BOOLEAN);
  PROCEDURE pr_package_spec_rep_1_2(po_success OUT BOOLEAN);
  PROCEDURE pr_package_spec_rep_1_3(po_success OUT BOOLEAN);
  PROCEDURE pr_parameter_list_1(po_success OUT BOOLEAN);
  PROCEDURE pr_parameter_list_rep_1_2(po_success OUT BOOLEAN);
  PROCEDURE pr_parameter_list_rep_1_3(po_success OUT BOOLEAN);
  PROCEDURE pr_parameter_spec_1(po_success OUT BOOLEAN);
  PROCEDURE pr_parameter_spec_opt_1_2(po_success OUT BOOLEAN);
  PROCEDURE pr_parameter_spec_opt_1_3(po_success OUT BOOLEAN);
  PROCEDURE pr_parameter_spec_opt_1_4(po_success OUT BOOLEAN);
  PROCEDURE pr_parameter_spec_opt_1_5(po_success OUT BOOLEAN);
  PROCEDURE pr_parameter_spec_opt_2_6(po_success OUT BOOLEAN);
  PROCEDURE pr_parameter_spec_opt_2_7(po_success OUT BOOLEAN);
  PROCEDURE pr_procedure_body_1(po_success OUT BOOLEAN);
  PROCEDURE pr_procedure_body_opt_1_2(po_success OUT BOOLEAN);
  PROCEDURE pr_procedure_body_opt_1_3(po_success OUT BOOLEAN);
  PROCEDURE pr_procedure_call_1(po_success OUT BOOLEAN);
  PROCEDURE pr_procedure_call_opt_1_2(po_success OUT BOOLEAN);
  PROCEDURE pr_procedure_call_opt_1_3(po_success OUT BOOLEAN);
  PROCEDURE pr_procedure_spec_1(po_success OUT BOOLEAN);
  PROCEDURE pr_procedure_spec_opt_1_2(po_success OUT BOOLEAN);
  PROCEDURE pr_procedure_spec_opt_1_3(po_success OUT BOOLEAN);
  PROCEDURE pr_raise_statement_1(po_success OUT BOOLEAN);
  PROCEDURE pr_raise_statement_opt_1_2(po_success OUT BOOLEAN);
  PROCEDURE pr_raise_statement_opt_1_3(po_success OUT BOOLEAN);
  PROCEDURE pr_range_1(po_success OUT BOOLEAN);
  PROCEDURE pr_record_field_spec_1(po_success OUT BOOLEAN);
  PROCEDURE pr_record_field_spec_opt_1_2(po_success OUT BOOLEAN);
  PROCEDURE pr_record_field_spec_opt_1_3(po_success OUT BOOLEAN);
  PROCEDURE pr_record_field_spec_opt_2_4(po_success OUT BOOLEAN);
  PROCEDURE pr_record_field_spec_opt_2_5(po_success OUT BOOLEAN);
  PROCEDURE pr_record_field_spec_opt_2_6(po_success OUT BOOLEAN);
  PROCEDURE pr_record_type_definition_1(po_success OUT BOOLEAN);
  PROCEDURE pr_record_type_definition_rep_1_2(po_success OUT BOOLEAN);
  PROCEDURE pr_record_type_definition_rep_1_3(po_success OUT BOOLEAN);
  PROCEDURE pr_ref_cursor_type_definition_1(po_success OUT BOOLEAN);
  PROCEDURE pr_ref_cursor_type_definition_opt_1_2(po_success OUT BOOLEAN);
  PROCEDURE pr_ref_cursor_type_definition_opt_1_3(po_success OUT BOOLEAN);
  PROCEDURE pr_rollback_statement_1(po_success OUT BOOLEAN);
  PROCEDURE pr_statement_1(po_success OUT BOOLEAN);
  PROCEDURE pr_table_or_view_reference_1(po_success OUT BOOLEAN);
  PROCEDURE pr_table_or_view_reference_opt_1_2(po_success OUT BOOLEAN);
  PROCEDURE pr_table_or_view_reference_opt_1_3(po_success OUT BOOLEAN);
  PROCEDURE pr_term_1(po_success OUT BOOLEAN);
  PROCEDURE pr_trigger_1(po_success OUT BOOLEAN);
  PROCEDURE pr_trigger_body_1(po_success OUT BOOLEAN);
  PROCEDURE pr_trigger_body_opt_1_2(po_success OUT BOOLEAN);
  PROCEDURE pr_trigger_body_opt_1_3(po_success OUT BOOLEAN);
  PROCEDURE pr_trigger_event_1(po_success OUT BOOLEAN);
  PROCEDURE pr_trigger_event_list_1(po_success OUT BOOLEAN);
  PROCEDURE pr_trigger_event_list_rep_1_2(po_success OUT BOOLEAN);
  PROCEDURE pr_trigger_event_list_rep_1_3(po_success OUT BOOLEAN);
  PROCEDURE pr_trigger_time_event_1(po_success OUT BOOLEAN);
  PROCEDURE pr_trigger_time_event_opt_1_2(po_success OUT BOOLEAN);
  PROCEDURE pr_trigger_time_event_opt_1_3(po_success OUT BOOLEAN);
  PROCEDURE pr_trigger_time_event_opt_2_4(po_success OUT BOOLEAN);
  PROCEDURE pr_trigger_time_event_opt_2_5(po_success OUT BOOLEAN);
  PROCEDURE pr_trigger_timing_1(po_success OUT BOOLEAN);
  PROCEDURE pr_trigger_when_clause_1(po_success OUT BOOLEAN);
  PROCEDURE pr_type_declaration_1(po_success OUT BOOLEAN);
  PROCEDURE pr_type_definition_1(po_success OUT BOOLEAN);
  PROCEDURE pr_variable_declaration_1(po_success OUT BOOLEAN);
  PROCEDURE pr_variable_declaration_opt_1_2(po_success OUT BOOLEAN);
  PROCEDURE pr_variable_declaration_opt_1_3(po_success OUT BOOLEAN);
  PROCEDURE pr_variable_declaration_opt_2_4(po_success OUT BOOLEAN);
  PROCEDURE pr_variable_declaration_opt_2_5(po_success OUT BOOLEAN);
  PROCEDURE pr_variable_reference_1(po_success OUT BOOLEAN);
  PROCEDURE pr_variable_reference_opt_2_4(po_success OUT BOOLEAN);
  PROCEDURE pr_variable_reference_opt_2_5(po_success OUT BOOLEAN);
  PROCEDURE pr_variable_reference_rep_1_2(po_success OUT BOOLEAN);
  PROCEDURE pr_variable_reference_rep_1_3(po_success OUT BOOLEAN);
  PROCEDURE pr_while_statement_1(po_success OUT BOOLEAN);

  PROCEDURE pr_assignment_statement(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line||':' ||UTL_CALL_STACK.CONCATENATE_SUBPROGRAM(UTL_CALL_STACK.SUBPROGRAM(1))||': g_curr_token_ix:'||   g_curr_token_ix);
    g_tokens( g_curr_token_ix ).print_details;
    po_success := FALSE;
    IF NOT po_success THEN
      pr_assignment_statement_1(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END pr_assignment_statement;

  PROCEDURE pr_assignment_statement_1(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
    po_success := TRUE;
    -- Position 1: Symbol <variable_reference>
    IF po_success THEN
      pr_variable_reference(po_success);
    END IF;
    -- Position 2: Symbol ":="
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '":="' )  THEN
        pr_increment_token_ix;
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
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '";"' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_assignment_statement_1;

  PROCEDURE pr_block(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line||':' ||UTL_CALL_STACK.CONCATENATE_SUBPROGRAM(UTL_CALL_STACK.SUBPROGRAM(1))||': g_curr_token_ix:'||   g_curr_token_ix);
    g_tokens( g_curr_token_ix ).print_details;
    po_success := FALSE;
    IF NOT po_success THEN
      pr_block_1(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END pr_block;

  PROCEDURE pr_block_1(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
    po_success := TRUE;
    -- Position 1: Symbol <block_opt_1>
    IF po_success THEN
      pr_block_opt_1(po_success);
    END IF;
    -- Position 2: Symbol "BEGIN"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '"BEGIN"' )  THEN
        pr_increment_token_ix;
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
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '"END"' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 6: Symbol ";"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '";"' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_block_1;

  PROCEDURE pr_block_opt_1(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line||':' ||UTL_CALL_STACK.CONCATENATE_SUBPROGRAM(UTL_CALL_STACK.SUBPROGRAM(1))||': g_curr_token_ix:'||   g_curr_token_ix);
    g_tokens( g_curr_token_ix ).print_details;
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
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
    po_success := TRUE;
    -- Position 1: Symbol "DECLARE"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '"DECLARE"' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 2: Symbol <declaration_section>
    IF po_success THEN
      pr_declaration_section(po_success);
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_block_opt_1_2;

  PROCEDURE pr_block_opt_1_3(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
    po_success := TRUE;
    -- Position 1: Symbol EPSILON
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( 'EPSILON' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_block_opt_1_3;

  PROCEDURE pr_block_opt_2(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line||':' ||UTL_CALL_STACK.CONCATENATE_SUBPROGRAM(UTL_CALL_STACK.SUBPROGRAM(1))||': g_curr_token_ix:'||   g_curr_token_ix);
    g_tokens( g_curr_token_ix ).print_details;
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
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
    po_success := TRUE;
    -- Position 1: Symbol "EXCEPTION"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '"EXCEPTION"' )  THEN
        pr_increment_token_ix;
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
  END pr_block_opt_2_4;

  PROCEDURE pr_block_opt_2_5(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
    po_success := TRUE;
    -- Position 1: Symbol EPSILON
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( 'EPSILON' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_block_opt_2_5;

  PROCEDURE pr_collection_type_definition(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line||':' ||UTL_CALL_STACK.CONCATENATE_SUBPROGRAM(UTL_CALL_STACK.SUBPROGRAM(1))||': g_curr_token_ix:'||   g_curr_token_ix);
    g_tokens( g_curr_token_ix ).print_details;
    po_success := FALSE;
    IF NOT po_success THEN
      pr_collection_type_definition_1(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END pr_collection_type_definition;

  PROCEDURE pr_collection_type_definition_1(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
    po_success := TRUE;
    -- Position 1: Symbol "VARRAY"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '"VARRAY"' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 2: Symbol "("
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '"("' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 3: Symbol <number_literal>
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '<number_literal>' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 4: Symbol ")"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '")"' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 5: Symbol "OF"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '"OF"' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 6: Symbol <data_type>
    IF po_success THEN
      pr_data_type(po_success);
    END IF;
    -- Position 7: Symbol <collection_type_definition_opt_1>
    IF po_success THEN
      pr_collection_type_definition_opt_1(po_success);
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_collection_type_definition_1;

  PROCEDURE pr_collection_type_definition_opt_1(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line||':' ||UTL_CALL_STACK.CONCATENATE_SUBPROGRAM(UTL_CALL_STACK.SUBPROGRAM(1))||': g_curr_token_ix:'||   g_curr_token_ix);
    g_tokens( g_curr_token_ix ).print_details;
    po_success := FALSE;
    IF NOT po_success THEN
      pr_collection_type_definition_opt_1_2(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      pr_collection_type_definition_opt_1_3(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END pr_collection_type_definition_opt_1;

  PROCEDURE pr_collection_type_definition_opt_1_2(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
    po_success := TRUE;
    -- Position 1: Symbol "NOT
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '"NOT' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 2: Symbol NULL"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( 'NULL"' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_collection_type_definition_opt_1_2;

  PROCEDURE pr_collection_type_definition_opt_1_3(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
    po_success := TRUE;
    -- Position 1: Symbol EPSILON
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( 'EPSILON' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_collection_type_definition_opt_1_3;

  PROCEDURE pr_column_list(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line||':' ||UTL_CALL_STACK.CONCATENATE_SUBPROGRAM(UTL_CALL_STACK.SUBPROGRAM(1))||': g_curr_token_ix:'||   g_curr_token_ix);
    g_tokens( g_curr_token_ix ).print_details;
    po_success := FALSE;
    IF NOT po_success THEN
      pr_column_list_1(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END pr_column_list;

  PROCEDURE pr_column_list_1(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
    po_success := TRUE;
    -- Position 1: Symbol <identifier>
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '<identifier>' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 2: Symbol <column_list_rep_1>
    IF po_success THEN
      pr_column_list_rep_1(po_success);
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_column_list_1;

  PROCEDURE pr_column_list_rep_1(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line||':' ||UTL_CALL_STACK.CONCATENATE_SUBPROGRAM(UTL_CALL_STACK.SUBPROGRAM(1))||': g_curr_token_ix:'||   g_curr_token_ix);
    g_tokens( g_curr_token_ix ).print_details;
    po_success := FALSE;
    IF NOT po_success THEN
      pr_column_list_rep_1_2(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      pr_column_list_rep_1_3(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END pr_column_list_rep_1;

  PROCEDURE pr_column_list_rep_1_2(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
    po_success := TRUE;
    -- Position 1: Symbol ","
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '","' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 2: Symbol <identifier>
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '<identifier>' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 3: Symbol <column_list_rep_1>
    IF po_success THEN
      pr_column_list_rep_1(po_success);
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_column_list_rep_1_2;

  PROCEDURE pr_column_list_rep_1_3(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
    po_success := TRUE;
    -- Position 1: Symbol EPSILON
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( 'EPSILON' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_column_list_rep_1_3;

  PROCEDURE pr_commit_statement(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line||':' ||UTL_CALL_STACK.CONCATENATE_SUBPROGRAM(UTL_CALL_STACK.SUBPROGRAM(1))||': g_curr_token_ix:'||   g_curr_token_ix);
    g_tokens( g_curr_token_ix ).print_details;
    po_success := FALSE;
    IF NOT po_success THEN
      pr_commit_statement_1(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END pr_commit_statement;

  PROCEDURE pr_commit_statement_1(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
    po_success := TRUE;
    -- Position 1: Symbol "COMMIT"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '"COMMIT"' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_commit_statement_1;

  PROCEDURE pr_condition(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line||':' ||UTL_CALL_STACK.CONCATENATE_SUBPROGRAM(UTL_CALL_STACK.SUBPROGRAM(1))||': g_curr_token_ix:'||   g_curr_token_ix);
    g_tokens( g_curr_token_ix ).print_details;
    po_success := FALSE;
    IF NOT po_success THEN
      pr_condition_1(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END pr_condition;

  PROCEDURE pr_condition_1(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
    po_success := TRUE;
    -- Position 1: Symbol <expression>
    IF po_success THEN
      pr_expression(po_success);
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_condition_1;

  PROCEDURE pr_constant_declaration(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line||':' ||UTL_CALL_STACK.CONCATENATE_SUBPROGRAM(UTL_CALL_STACK.SUBPROGRAM(1))||': g_curr_token_ix:'||   g_curr_token_ix);
    g_tokens( g_curr_token_ix ).print_details;
    po_success := FALSE;
    IF NOT po_success THEN
      pr_constant_declaration_1(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END pr_constant_declaration;

  PROCEDURE pr_constant_declaration_1(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
    po_success := TRUE;
    -- Position 1: Symbol <identifier>
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '<identifier>' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 2: Symbol "CONSTANT"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '"CONSTANT"' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 3: Symbol <data_type>
    IF po_success THEN
      pr_data_type(po_success);
    END IF;
    -- Position 4: Symbol ":="
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '":="' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 5: Symbol <expression>
    IF po_success THEN
      pr_expression(po_success);
    END IF;
    -- Position 6: Symbol ";"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '";"' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_constant_declaration_1;

  PROCEDURE pr_cursor_declaration(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line||':' ||UTL_CALL_STACK.CONCATENATE_SUBPROGRAM(UTL_CALL_STACK.SUBPROGRAM(1))||': g_curr_token_ix:'||   g_curr_token_ix);
    g_tokens( g_curr_token_ix ).print_details;
    po_success := FALSE;
    IF NOT po_success THEN
      pr_cursor_declaration_1(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END pr_cursor_declaration;

  PROCEDURE pr_cursor_declaration_1(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
    po_success := TRUE;
    -- Position 1: Symbol "CURSOR"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '"CURSOR"' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 2: Symbol <identifier>
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '<identifier>' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 3: Symbol <cursor_declaration_opt_1>
    IF po_success THEN
      pr_cursor_declaration_opt_1(po_success);
    END IF;
    -- Position 4: Symbol "IS"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '"IS"' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 5: Symbol <select_statement>
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '<select_statement>' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 6: Symbol ";"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '";"' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_cursor_declaration_1;

  PROCEDURE pr_cursor_declaration_opt_1(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line||':' ||UTL_CALL_STACK.CONCATENATE_SUBPROGRAM(UTL_CALL_STACK.SUBPROGRAM(1))||': g_curr_token_ix:'||   g_curr_token_ix);
    g_tokens( g_curr_token_ix ).print_details;
    po_success := FALSE;
    IF NOT po_success THEN
      pr_cursor_declaration_opt_1_2(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      pr_cursor_declaration_opt_1_3(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END pr_cursor_declaration_opt_1;

  PROCEDURE pr_cursor_declaration_opt_1_2(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
    po_success := TRUE;
    -- Position 1: Symbol "("
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '"("' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 2: Symbol <parameter_list>
    IF po_success THEN
      pr_parameter_list(po_success);
    END IF;
    -- Position 3: Symbol ")"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '")"' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_cursor_declaration_opt_1_2;

  PROCEDURE pr_cursor_declaration_opt_1_3(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
    po_success := TRUE;
    -- Position 1: Symbol EPSILON
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( 'EPSILON' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_cursor_declaration_opt_1_3;

  PROCEDURE pr_data_type(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line||':' ||UTL_CALL_STACK.CONCATENATE_SUBPROGRAM(UTL_CALL_STACK.SUBPROGRAM(1))||': g_curr_token_ix:'||   g_curr_token_ix);
    g_tokens( g_curr_token_ix ).print_details;
    po_success := FALSE;
    IF NOT po_success THEN
      pr_data_type_1(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END pr_data_type;

  PROCEDURE pr_data_type_1(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
    po_success := TRUE;
    -- Position 1: Symbol <identifier>
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '<identifier>' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 2: Symbol <data_type_opt_1>
    IF po_success THEN
      pr_data_type_opt_1(po_success);
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_data_type_1;

  PROCEDURE pr_data_type_opt_1(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line||':' ||UTL_CALL_STACK.CONCATENATE_SUBPROGRAM(UTL_CALL_STACK.SUBPROGRAM(1))||': g_curr_token_ix:'||   g_curr_token_ix);
    g_tokens( g_curr_token_ix ).print_details;
    po_success := FALSE;
    IF NOT po_success THEN
      pr_data_type_opt_1_2(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      pr_data_type_opt_1_3(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      pr_data_type_opt_1_4(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END pr_data_type_opt_1;

  PROCEDURE pr_data_type_opt_1_2(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
    po_success := TRUE;
    -- Position 1: Symbol "%TYPE"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '"%TYPE"' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_data_type_opt_1_2;

  PROCEDURE pr_data_type_opt_1_3(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
    po_success := TRUE;
    -- Position 1: Symbol "%ROWTYPE"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '"%ROWTYPE"' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_data_type_opt_1_3;

  PROCEDURE pr_data_type_opt_1_4(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
    po_success := TRUE;
    -- Position 1: Symbol EPSILON
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( 'EPSILON' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_data_type_opt_1_4;

  PROCEDURE pr_declaration(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line||':' ||UTL_CALL_STACK.CONCATENATE_SUBPROGRAM(UTL_CALL_STACK.SUBPROGRAM(1))||': g_curr_token_ix:'||   g_curr_token_ix);
    g_tokens( g_curr_token_ix ).print_details;
    po_success := FALSE;
    IF NOT po_success THEN
      pr_declaration_1(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END pr_declaration;

  PROCEDURE pr_declaration_1(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
    po_success := TRUE;
    -- Position 1: Symbol <variable_declaration>
    IF po_success THEN
      pr_variable_declaration(po_success);
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_declaration_1;

  PROCEDURE pr_declaration_section(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line||':' ||UTL_CALL_STACK.CONCATENATE_SUBPROGRAM(UTL_CALL_STACK.SUBPROGRAM(1))||': g_curr_token_ix:'||   g_curr_token_ix);
    g_tokens( g_curr_token_ix ).print_details;
    po_success := FALSE;
    IF NOT po_success THEN
      pr_declaration_section_1(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END pr_declaration_section;

  PROCEDURE pr_declaration_section_1(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
    po_success := TRUE;
    -- Position 1: Symbol <declaration_section_rep_1>
    IF po_success THEN
      pr_declaration_section_rep_1(po_success);
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_declaration_section_1;

  PROCEDURE pr_declaration_section_rep_1(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line||':' ||UTL_CALL_STACK.CONCATENATE_SUBPROGRAM(UTL_CALL_STACK.SUBPROGRAM(1))||': g_curr_token_ix:'||   g_curr_token_ix);
    g_tokens( g_curr_token_ix ).print_details;
    po_success := FALSE;
    IF NOT po_success THEN
      pr_declaration_section_rep_1_2(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      pr_declaration_section_rep_1_3(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END pr_declaration_section_rep_1;

  PROCEDURE pr_declaration_section_rep_1_2(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
    po_success := TRUE;
    -- Position 1: Symbol <declaration>
    IF po_success THEN
      pr_declaration(po_success);
    END IF;
    -- Position 2: Symbol <declaration_section_rep_1>
    IF po_success THEN
      pr_declaration_section_rep_1(po_success);
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_declaration_section_rep_1_2;

  PROCEDURE pr_declaration_section_rep_1_3(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
    po_success := TRUE;
    -- Position 1: Symbol EPSILON
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( 'EPSILON' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_declaration_section_rep_1_3;

  PROCEDURE pr_dynamic_sql_statement(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line||':' ||UTL_CALL_STACK.CONCATENATE_SUBPROGRAM(UTL_CALL_STACK.SUBPROGRAM(1))||': g_curr_token_ix:'||   g_curr_token_ix);
    g_tokens( g_curr_token_ix ).print_details;
    po_success := FALSE;
    IF NOT po_success THEN
      pr_dynamic_sql_statement_1(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END pr_dynamic_sql_statement;

  PROCEDURE pr_dynamic_sql_statement_1(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
    po_success := TRUE;
    -- Position 1: Symbol "EXECUTE
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '"EXECUTE' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 2: Symbol IMMEDIATE"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( 'IMMEDIATE"' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 3: Symbol <string_literal>
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '<string_literal>' )  THEN
        pr_increment_token_ix;
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
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( ';' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_dynamic_sql_statement_1;

  PROCEDURE pr_dynamic_sql_statement_opt_1(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line||':' ||UTL_CALL_STACK.CONCATENATE_SUBPROGRAM(UTL_CALL_STACK.SUBPROGRAM(1))||': g_curr_token_ix:'||   g_curr_token_ix);
    g_tokens( g_curr_token_ix ).print_details;
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
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
    po_success := TRUE;
    -- Position 1: Symbol "INTO"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '"INTO"' )  THEN
        pr_increment_token_ix;
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
  END pr_dynamic_sql_statement_opt_1_2;

  PROCEDURE pr_dynamic_sql_statement_opt_1_3(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
    po_success := TRUE;
    -- Position 1: Symbol EPSILON
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( 'EPSILON' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_dynamic_sql_statement_opt_1_3;

  PROCEDURE pr_exception_declaration(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line||':' ||UTL_CALL_STACK.CONCATENATE_SUBPROGRAM(UTL_CALL_STACK.SUBPROGRAM(1))||': g_curr_token_ix:'||   g_curr_token_ix);
    g_tokens( g_curr_token_ix ).print_details;
    po_success := FALSE;
    IF NOT po_success THEN
      pr_exception_declaration_1(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END pr_exception_declaration;

  PROCEDURE pr_exception_declaration_1(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
    po_success := TRUE;
    -- Position 1: Symbol <identifier>
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '<identifier>' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 2: Symbol "EXCEPTION"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '"EXCEPTION"' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 3: Symbol ";"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '";"' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_exception_declaration_1;

  PROCEDURE pr_exception_handler(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line||':' ||UTL_CALL_STACK.CONCATENATE_SUBPROGRAM(UTL_CALL_STACK.SUBPROGRAM(1))||': g_curr_token_ix:'||   g_curr_token_ix);
    g_tokens( g_curr_token_ix ).print_details;
    po_success := FALSE;
    IF NOT po_success THEN
      pr_exception_handler_1(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END pr_exception_handler;

  PROCEDURE pr_exception_handler_1(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
    po_success := TRUE;
    -- Position 1: Symbol "WHEN"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '"WHEN"' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 2: Symbol <exception_name>
    IF po_success THEN
      pr_exception_name(po_success);
    END IF;
    -- Position 3: Symbol "THEN"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '"THEN"' )  THEN
        pr_increment_token_ix;
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
  END pr_exception_handler_1;

  PROCEDURE pr_exception_name(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line||':' ||UTL_CALL_STACK.CONCATENATE_SUBPROGRAM(UTL_CALL_STACK.SUBPROGRAM(1))||': g_curr_token_ix:'||   g_curr_token_ix);
    g_tokens( g_curr_token_ix ).print_details;
    po_success := FALSE;
    IF NOT po_success THEN
      pr_exception_name_1(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END pr_exception_name;

  PROCEDURE pr_exception_name_1(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
    po_success := TRUE;
    -- Position 1: Symbol <identifier>
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '<identifier>' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_exception_name_1;

  PROCEDURE pr_exception_section(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line||':' ||UTL_CALL_STACK.CONCATENATE_SUBPROGRAM(UTL_CALL_STACK.SUBPROGRAM(1))||': g_curr_token_ix:'||   g_curr_token_ix);
    g_tokens( g_curr_token_ix ).print_details;
    po_success := FALSE;
    IF NOT po_success THEN
      pr_exception_section_1(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END pr_exception_section;

  PROCEDURE pr_exception_section_1(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
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
  END pr_exception_section_1;

  PROCEDURE pr_exception_section_rep_1(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line||':' ||UTL_CALL_STACK.CONCATENATE_SUBPROGRAM(UTL_CALL_STACK.SUBPROGRAM(1))||': g_curr_token_ix:'||   g_curr_token_ix);
    g_tokens( g_curr_token_ix ).print_details;
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
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
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
  END pr_exception_section_rep_1_2;

  PROCEDURE pr_exception_section_rep_1_3(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
    po_success := TRUE;
    -- Position 1: Symbol EPSILON
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( 'EPSILON' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_exception_section_rep_1_3;

  PROCEDURE pr_executable_section(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line||':' ||UTL_CALL_STACK.CONCATENATE_SUBPROGRAM(UTL_CALL_STACK.SUBPROGRAM(1))||': g_curr_token_ix:'||   g_curr_token_ix);
    g_tokens( g_curr_token_ix ).print_details;
    po_success := FALSE;
    IF NOT po_success THEN
      pr_executable_section_1(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END pr_executable_section;

  PROCEDURE pr_executable_section_1(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
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
  END pr_executable_section_1;

  PROCEDURE pr_executable_section_rep_1(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line||':' ||UTL_CALL_STACK.CONCATENATE_SUBPROGRAM(UTL_CALL_STACK.SUBPROGRAM(1))||': g_curr_token_ix:'||   g_curr_token_ix);
    g_tokens( g_curr_token_ix ).print_details;
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
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
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
  END pr_executable_section_rep_1_2;

  PROCEDURE pr_executable_section_rep_1_3(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
    po_success := TRUE;
    -- Position 1: Symbol EPSILON
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( 'EPSILON' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_executable_section_rep_1_3;

  PROCEDURE pr_exit_statement(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line||':' ||UTL_CALL_STACK.CONCATENATE_SUBPROGRAM(UTL_CALL_STACK.SUBPROGRAM(1))||': g_curr_token_ix:'||   g_curr_token_ix);
    g_tokens( g_curr_token_ix ).print_details;
    po_success := FALSE;
    IF NOT po_success THEN
      pr_exit_statement_1(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END pr_exit_statement;

  PROCEDURE pr_exit_statement_1(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
    po_success := TRUE;
    -- Position 1: Symbol "EXIT"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '"EXIT"' )  THEN
        pr_increment_token_ix;
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
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '";"' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_exit_statement_1;

  PROCEDURE pr_exit_statement_opt_1(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line||':' ||UTL_CALL_STACK.CONCATENATE_SUBPROGRAM(UTL_CALL_STACK.SUBPROGRAM(1))||': g_curr_token_ix:'||   g_curr_token_ix);
    g_tokens( g_curr_token_ix ).print_details;
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
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
    po_success := TRUE;
    -- Position 1: Symbol "WHEN"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '"WHEN"' )  THEN
        pr_increment_token_ix;
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
  END pr_exit_statement_opt_1_2;

  PROCEDURE pr_exit_statement_opt_1_3(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
    po_success := TRUE;
    -- Position 1: Symbol EPSILON
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( 'EPSILON' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_exit_statement_opt_1_3;

  PROCEDURE pr_expression(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line||':' ||UTL_CALL_STACK.CONCATENATE_SUBPROGRAM(UTL_CALL_STACK.SUBPROGRAM(1))||': g_curr_token_ix:'||   g_curr_token_ix);
    g_tokens( g_curr_token_ix ).print_details;
    po_success := FALSE;
    IF NOT po_success THEN
      pr_expression_1(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END pr_expression;

  PROCEDURE pr_expression_1(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
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
  END pr_expression_1;

  PROCEDURE pr_expression_list(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line||':' ||UTL_CALL_STACK.CONCATENATE_SUBPROGRAM(UTL_CALL_STACK.SUBPROGRAM(1))||': g_curr_token_ix:'||   g_curr_token_ix);
    g_tokens( g_curr_token_ix ).print_details;
    po_success := FALSE;
    IF NOT po_success THEN
      pr_expression_list_1(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END pr_expression_list;

  PROCEDURE pr_expression_list_1(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
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
  END pr_expression_list_1;

  PROCEDURE pr_expression_list_rep_1(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line||':' ||UTL_CALL_STACK.CONCATENATE_SUBPROGRAM(UTL_CALL_STACK.SUBPROGRAM(1))||': g_curr_token_ix:'||   g_curr_token_ix);
    g_tokens( g_curr_token_ix ).print_details;
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
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
    po_success := TRUE;
    -- Position 1: Symbol ","
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '","' )  THEN
        pr_increment_token_ix;
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
  END pr_expression_list_rep_1_2;

  PROCEDURE pr_expression_list_rep_1_3(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
    po_success := TRUE;
    -- Position 1: Symbol EPSILON
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( 'EPSILON' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_expression_list_rep_1_3;

  PROCEDURE pr_expression_tail(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line||':' ||UTL_CALL_STACK.CONCATENATE_SUBPROGRAM(UTL_CALL_STACK.SUBPROGRAM(1))||': g_curr_token_ix:'||   g_curr_token_ix);
    g_tokens( g_curr_token_ix ).print_details;
    po_success := FALSE;
    IF NOT po_success THEN
      pr_expression_tail_1(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END pr_expression_tail;

  PROCEDURE pr_expression_tail_1(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
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
  END pr_expression_tail_1;

  PROCEDURE pr_field_name(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line||':' ||UTL_CALL_STACK.CONCATENATE_SUBPROGRAM(UTL_CALL_STACK.SUBPROGRAM(1))||': g_curr_token_ix:'||   g_curr_token_ix);
    g_tokens( g_curr_token_ix ).print_details;
    po_success := FALSE;
    IF NOT po_success THEN
      pr_field_name_1(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END pr_field_name;

  PROCEDURE pr_field_name_1(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
    po_success := TRUE;
    -- Position 1: Symbol <identifier>
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '<identifier>' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_field_name_1;

  PROCEDURE pr_for_statement(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line||':' ||UTL_CALL_STACK.CONCATENATE_SUBPROGRAM(UTL_CALL_STACK.SUBPROGRAM(1))||': g_curr_token_ix:'||   g_curr_token_ix);
    g_tokens( g_curr_token_ix ).print_details;
    po_success := FALSE;
    IF NOT po_success THEN
      pr_for_statement_1(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END pr_for_statement;

  PROCEDURE pr_for_statement_1(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
    po_success := TRUE;
    -- Position 1: Symbol "FOR"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '"FOR"' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 2: Symbol <identifier>
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '<identifier>' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 3: Symbol "IN"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '"IN"' )  THEN
        pr_increment_token_ix;
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
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '"LOOP"' )  THEN
        pr_increment_token_ix;
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
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '"END' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 8: Symbol LOOP"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( 'LOOP"' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 9: Symbol ";"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '";"' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_for_statement_1;

  PROCEDURE pr_function_body(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line||':' ||UTL_CALL_STACK.CONCATENATE_SUBPROGRAM(UTL_CALL_STACK.SUBPROGRAM(1))||': g_curr_token_ix:'||   g_curr_token_ix);
    g_tokens( g_curr_token_ix ).print_details;
    po_success := FALSE;
    IF NOT po_success THEN
      pr_function_body_1(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END pr_function_body;

  PROCEDURE pr_function_body_1(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
    po_success := TRUE;
    -- Position 1: Symbol <function_spec>
    IF po_success THEN
      pr_function_spec(po_success);
    END IF;
    -- Position 2: Symbol "IS"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '"IS"' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 3: Symbol <declaration_section>
    IF po_success THEN
      pr_declaration_section(po_success);
    END IF;
    -- Position 4: Symbol "BEGIN"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '"BEGIN"' )  THEN
        pr_increment_token_ix;
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
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '"END"' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 8: Symbol <identifier>
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '<identifier>' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 9: Symbol ";"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '";"' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_function_body_1;

  PROCEDURE pr_function_body_opt_1(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line||':' ||UTL_CALL_STACK.CONCATENATE_SUBPROGRAM(UTL_CALL_STACK.SUBPROGRAM(1))||': g_curr_token_ix:'||   g_curr_token_ix);
    g_tokens( g_curr_token_ix ).print_details;
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
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
    po_success := TRUE;
    -- Position 1: Symbol "EXCEPTION"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '"EXCEPTION"' )  THEN
        pr_increment_token_ix;
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
  END pr_function_body_opt_1_2;

  PROCEDURE pr_function_body_opt_1_3(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
    po_success := TRUE;
    -- Position 1: Symbol EPSILON
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( 'EPSILON' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_function_body_opt_1_3;

  PROCEDURE pr_function_call(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line||':' ||UTL_CALL_STACK.CONCATENATE_SUBPROGRAM(UTL_CALL_STACK.SUBPROGRAM(1))||': g_curr_token_ix:'||   g_curr_token_ix);
    g_tokens( g_curr_token_ix ).print_details;
    po_success := FALSE;
    IF NOT po_success THEN
      pr_function_call_1(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END pr_function_call;

  PROCEDURE pr_function_call_1(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
    po_success := TRUE;
    -- Position 1: Symbol <identifier>
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '<identifier>' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 2: Symbol "("
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '"("' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 3: Symbol <function_call_opt_1>
    IF po_success THEN
      pr_function_call_opt_1(po_success);
    END IF;
    -- Position 4: Symbol ")"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '")"' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_function_call_1;

  PROCEDURE pr_function_call_opt_1(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line||':' ||UTL_CALL_STACK.CONCATENATE_SUBPROGRAM(UTL_CALL_STACK.SUBPROGRAM(1))||': g_curr_token_ix:'||   g_curr_token_ix);
    g_tokens( g_curr_token_ix ).print_details;
    po_success := FALSE;
    IF NOT po_success THEN
      pr_function_call_opt_1_2(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      pr_function_call_opt_1_3(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END pr_function_call_opt_1;

  PROCEDURE pr_function_call_opt_1_2(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
    po_success := TRUE;
    -- Position 1: Symbol <expression_list>
    IF po_success THEN
      pr_expression_list(po_success);
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_function_call_opt_1_2;

  PROCEDURE pr_function_call_opt_1_3(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
    po_success := TRUE;
    -- Position 1: Symbol EPSILON
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( 'EPSILON' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_function_call_opt_1_3;

  PROCEDURE pr_function_spec(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line||':' ||UTL_CALL_STACK.CONCATENATE_SUBPROGRAM(UTL_CALL_STACK.SUBPROGRAM(1))||': g_curr_token_ix:'||   g_curr_token_ix);
    g_tokens( g_curr_token_ix ).print_details;
    po_success := FALSE;
    IF NOT po_success THEN
      pr_function_spec_1(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END pr_function_spec;

  PROCEDURE pr_function_spec_1(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
    po_success := TRUE;
    -- Position 1: Symbol "FUNCTION"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '"FUNCTION"' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 2: Symbol <identifier>
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '<identifier>' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 3: Symbol <function_spec_opt_1>
    IF po_success THEN
      pr_function_spec_opt_1(po_success);
    END IF;
    -- Position 4: Symbol "RETURN"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '"RETURN"' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 5: Symbol <data_type>
    IF po_success THEN
      pr_data_type(po_success);
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_function_spec_1;

  PROCEDURE pr_function_spec_opt_1(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line||':' ||UTL_CALL_STACK.CONCATENATE_SUBPROGRAM(UTL_CALL_STACK.SUBPROGRAM(1))||': g_curr_token_ix:'||   g_curr_token_ix);
    g_tokens( g_curr_token_ix ).print_details;
    po_success := FALSE;
    IF NOT po_success THEN
      pr_function_spec_opt_1_2(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      pr_function_spec_opt_1_3(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END pr_function_spec_opt_1;

  PROCEDURE pr_function_spec_opt_1_2(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
    po_success := TRUE;
    -- Position 1: Symbol "("
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '"("' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 2: Symbol <parameter_list>
    IF po_success THEN
      pr_parameter_list(po_success);
    END IF;
    -- Position 3: Symbol ")"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '")"' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_function_spec_opt_1_2;

  PROCEDURE pr_function_spec_opt_1_3(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
    po_success := TRUE;
    -- Position 1: Symbol EPSILON
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( 'EPSILON' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_function_spec_opt_1_3;

  PROCEDURE pr_if_statement(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line||':' ||UTL_CALL_STACK.CONCATENATE_SUBPROGRAM(UTL_CALL_STACK.SUBPROGRAM(1))||': g_curr_token_ix:'||   g_curr_token_ix);
    g_tokens( g_curr_token_ix ).print_details;
    po_success := FALSE;
    IF NOT po_success THEN
      pr_if_statement_1(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END pr_if_statement;

  PROCEDURE pr_if_statement_1(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
    po_success := TRUE;
    -- Position 1: Symbol "IF"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '"IF"' )  THEN
        pr_increment_token_ix;
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
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '"THEN"' )  THEN
        pr_increment_token_ix;
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
  END pr_if_statement_1;

  PROCEDURE pr_index_by_type(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line||':' ||UTL_CALL_STACK.CONCATENATE_SUBPROGRAM(UTL_CALL_STACK.SUBPROGRAM(1))||': g_curr_token_ix:'||   g_curr_token_ix);
    g_tokens( g_curr_token_ix ).print_details;
    po_success := FALSE;
    IF NOT po_success THEN
      pr_index_by_type_1(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END pr_index_by_type;

  PROCEDURE pr_index_by_type_1(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
    po_success := TRUE;
    -- Position 1: Symbol "VARCHAR2"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '"VARCHAR2"' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 2: Symbol "("
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '"("' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 3: Symbol <number_literal>
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '<number_literal>' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 4: Symbol ")"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '")"' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_index_by_type_1;

  PROCEDURE pr_literal(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line||':' ||UTL_CALL_STACK.CONCATENATE_SUBPROGRAM(UTL_CALL_STACK.SUBPROGRAM(1))||': g_curr_token_ix:'||   g_curr_token_ix);
    g_tokens( g_curr_token_ix ).print_details;
    po_success := FALSE;
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

  PROCEDURE pr_literal_1(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
    po_success := TRUE;
    -- Position 1: Symbol <number>
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '<number>' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_literal_1;

  PROCEDURE pr_literal_2(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
    po_success := TRUE;
    -- Position 1: Symbol <string>
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '<string>' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_literal_2;

  PROCEDURE pr_literal_3(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
    po_success := TRUE;
    -- Position 1: Symbol "TRUE"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '"TRUE"' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_literal_3;

  PROCEDURE pr_literal_4(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
    po_success := TRUE;
    -- Position 1: Symbol "FALSE"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '"FALSE"' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_literal_4;

  PROCEDURE pr_literal_5(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
    po_success := TRUE;
    -- Position 1: Symbol "NULL"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '"NULL"' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_literal_5;

  PROCEDURE pr_loop_statement(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line||':' ||UTL_CALL_STACK.CONCATENATE_SUBPROGRAM(UTL_CALL_STACK.SUBPROGRAM(1))||': g_curr_token_ix:'||   g_curr_token_ix);
    g_tokens( g_curr_token_ix ).print_details;
    po_success := FALSE;
    IF NOT po_success THEN
      pr_loop_statement_1(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END pr_loop_statement;

  PROCEDURE pr_loop_statement_1(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
    po_success := TRUE;
    -- Position 1: Symbol "LOOP"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '"LOOP"' )  THEN
        pr_increment_token_ix;
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
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '"END' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 4: Symbol LOOP"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( 'LOOP"' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 5: Symbol ";"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '";"' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_loop_statement_1;

  PROCEDURE pr_null_statement(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line||':' ||UTL_CALL_STACK.CONCATENATE_SUBPROGRAM(UTL_CALL_STACK.SUBPROGRAM(1))||': g_curr_token_ix:'||   g_curr_token_ix);
    g_tokens( g_curr_token_ix ).print_details;
    po_success := FALSE;
    IF NOT po_success THEN
      pr_null_statement_1(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END pr_null_statement;

  PROCEDURE pr_null_statement_1(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
    po_success := TRUE;
    -- Position 1: Symbol "NULL"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '"NULL"' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 2: Symbol ";"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '";"' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_null_statement_1;

  PROCEDURE pr_operator(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line||':' ||UTL_CALL_STACK.CONCATENATE_SUBPROGRAM(UTL_CALL_STACK.SUBPROGRAM(1))||': g_curr_token_ix:'||   g_curr_token_ix);
    g_tokens( g_curr_token_ix ).print_details;
    po_success := FALSE;
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

  PROCEDURE pr_operator_1(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
    po_success := TRUE;
    -- Position 1: Symbol "+"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '"+"' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_operator_1;

  PROCEDURE pr_operator_2(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
    po_success := TRUE;
    -- Position 1: Symbol "-"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '"-"' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_operator_2;

  PROCEDURE pr_operator_3(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
    po_success := TRUE;
    -- Position 1: Symbol "*"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '"*"' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_operator_3;

  PROCEDURE pr_operator_4(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
    po_success := TRUE;
    -- Position 1: Symbol "/"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '"/"' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_operator_4;

  PROCEDURE pr_operator_5(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
    po_success := TRUE;
    -- Position 1: Symbol "="
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '"="' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_operator_5;

  PROCEDURE pr_operator_6(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
    po_success := TRUE;
    -- Position 1: Symbol "<>"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '"<>"' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_operator_6;

  PROCEDURE pr_operator_7(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
    po_success := TRUE;
    -- Position 1: Symbol "<"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '"<"' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_operator_7;

  PROCEDURE pr_operator_8(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
    po_success := TRUE;
    -- Position 1: Symbol "<="
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '"<="' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_operator_8;

  PROCEDURE pr_operator_9(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
    po_success := TRUE;
    -- Position 1: Symbol ">"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '">"' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_operator_9;

  PROCEDURE pr_operator_10(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
    po_success := TRUE;
    -- Position 1: Symbol ">="
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '">="' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_operator_10;

  PROCEDURE pr_operator_11(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
    po_success := TRUE;
    -- Position 1: Symbol "AND"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '"AND"' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_operator_11;

  PROCEDURE pr_operator_12(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
    po_success := TRUE;
    -- Position 1: Symbol "OR"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '"OR"' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_operator_12;

  PROCEDURE pr_operator_13(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
    po_success := TRUE;
    -- Position 1: Symbol "NOT"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '"NOT"' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_operator_13;

  PROCEDURE pr_other_sql_statement(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line||':' ||UTL_CALL_STACK.CONCATENATE_SUBPROGRAM(UTL_CALL_STACK.SUBPROGRAM(1))||': g_curr_token_ix:'||   g_curr_token_ix);
    g_tokens( g_curr_token_ix ).print_details;
    po_success := FALSE;
    IF NOT po_success THEN
      pr_other_sql_statement_1(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END pr_other_sql_statement;

  PROCEDURE pr_other_sql_statement_1(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
    po_success := TRUE;
    -- Position 1: Symbol <select_statement>
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '<select_statement>' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 2: Symbol ";"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '";"' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_other_sql_statement_1;

  PROCEDURE pr_package_body(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line||':' ||UTL_CALL_STACK.CONCATENATE_SUBPROGRAM(UTL_CALL_STACK.SUBPROGRAM(1))||': g_curr_token_ix:'||   g_curr_token_ix);
    g_tokens( g_curr_token_ix ).print_details;
    po_success := FALSE;
    IF NOT po_success THEN
      pr_package_body_1(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END pr_package_body;

  PROCEDURE pr_package_body_1(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
    po_success := TRUE;
    -- Position 1: Symbol "PACKAGE
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '"PACKAGE' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 2: Symbol BODY"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( 'BODY"' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 3: Symbol <identifier>
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '<identifier>' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 4: Symbol "IS"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '"IS"' )  THEN
        pr_increment_token_ix;
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
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '"END"' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 7: Symbol <identifier>
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '<identifier>' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 8: Symbol ";"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '";"' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_package_body_1;

  PROCEDURE pr_package_body_element(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line||':' ||UTL_CALL_STACK.CONCATENATE_SUBPROGRAM(UTL_CALL_STACK.SUBPROGRAM(1))||': g_curr_token_ix:'||   g_curr_token_ix);
    g_tokens( g_curr_token_ix ).print_details;
    po_success := FALSE;
    IF NOT po_success THEN
      pr_package_body_element_1(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END pr_package_body_element;

  PROCEDURE pr_package_body_element_1(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
    po_success := TRUE;
    -- Position 1: Symbol <procedure_body>
    IF po_success THEN
      pr_procedure_body(po_success);
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_package_body_element_1;

  PROCEDURE pr_package_body_rep_1(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line||':' ||UTL_CALL_STACK.CONCATENATE_SUBPROGRAM(UTL_CALL_STACK.SUBPROGRAM(1))||': g_curr_token_ix:'||   g_curr_token_ix);
    g_tokens( g_curr_token_ix ).print_details;
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
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
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
  END pr_package_body_rep_1_2;

  PROCEDURE pr_package_body_rep_1_3(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
    po_success := TRUE;
    -- Position 1: Symbol EPSILON
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( 'EPSILON' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_package_body_rep_1_3;

  PROCEDURE pr_package_element(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line||':' ||UTL_CALL_STACK.CONCATENATE_SUBPROGRAM(UTL_CALL_STACK.SUBPROGRAM(1))||': g_curr_token_ix:'||   g_curr_token_ix);
    g_tokens( g_curr_token_ix ).print_details;
    po_success := FALSE;
    IF NOT po_success THEN
      pr_package_element_1(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END pr_package_element;

  PROCEDURE pr_package_element_1(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
    po_success := TRUE;
    -- Position 1: Symbol <procedure_spec>
    IF po_success THEN
      pr_procedure_spec(po_success);
    END IF;
    -- Position 2: Symbol ";"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '";"' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_package_element_1;

  PROCEDURE pr_package_spec(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line||':' ||UTL_CALL_STACK.CONCATENATE_SUBPROGRAM(UTL_CALL_STACK.SUBPROGRAM(1))||': g_curr_token_ix:'||   g_curr_token_ix);
    g_tokens( g_curr_token_ix ).print_details;
    po_success := FALSE;
    IF NOT po_success THEN
      pr_package_spec_1(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END pr_package_spec;

  PROCEDURE pr_package_spec_1(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
    po_success := TRUE;
    -- Position 1: Symbol "PACKAGE"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '"PACKAGE"' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 2: Symbol <identifier>
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '<identifier>' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 3: Symbol "IS"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '"IS"' )  THEN
        pr_increment_token_ix;
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
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '"END"' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 6: Symbol <identifier>
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '<identifier>' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 7: Symbol ";"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '";"' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_package_spec_1;

  PROCEDURE pr_package_spec_rep_1(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line||':' ||UTL_CALL_STACK.CONCATENATE_SUBPROGRAM(UTL_CALL_STACK.SUBPROGRAM(1))||': g_curr_token_ix:'||   g_curr_token_ix);
    g_tokens( g_curr_token_ix ).print_details;
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
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
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
  END pr_package_spec_rep_1_2;

  PROCEDURE pr_package_spec_rep_1_3(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
    po_success := TRUE;
    -- Position 1: Symbol EPSILON
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( 'EPSILON' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_package_spec_rep_1_3;

  PROCEDURE pr_parameter_list(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line||':' ||UTL_CALL_STACK.CONCATENATE_SUBPROGRAM(UTL_CALL_STACK.SUBPROGRAM(1))||': g_curr_token_ix:'||   g_curr_token_ix);
    g_tokens( g_curr_token_ix ).print_details;
    po_success := FALSE;
    IF NOT po_success THEN
      pr_parameter_list_1(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END pr_parameter_list;

  PROCEDURE pr_parameter_list_1(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
    po_success := TRUE;
    -- Position 1: Symbol <parameter_spec>
    IF po_success THEN
      pr_parameter_spec(po_success);
    END IF;
    -- Position 2: Symbol <parameter_list_rep_1>
    IF po_success THEN
      pr_parameter_list_rep_1(po_success);
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_parameter_list_1;

  PROCEDURE pr_parameter_list_rep_1(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line||':' ||UTL_CALL_STACK.CONCATENATE_SUBPROGRAM(UTL_CALL_STACK.SUBPROGRAM(1))||': g_curr_token_ix:'||   g_curr_token_ix);
    g_tokens( g_curr_token_ix ).print_details;
    po_success := FALSE;
    IF NOT po_success THEN
      pr_parameter_list_rep_1_2(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      pr_parameter_list_rep_1_3(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END pr_parameter_list_rep_1;

  PROCEDURE pr_parameter_list_rep_1_2(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
    po_success := TRUE;
    -- Position 1: Symbol ","
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '","' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 2: Symbol <parameter_spec>
    IF po_success THEN
      pr_parameter_spec(po_success);
    END IF;
    -- Position 3: Symbol <parameter_list_rep_1>
    IF po_success THEN
      pr_parameter_list_rep_1(po_success);
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_parameter_list_rep_1_2;

  PROCEDURE pr_parameter_list_rep_1_3(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
    po_success := TRUE;
    -- Position 1: Symbol EPSILON
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( 'EPSILON' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_parameter_list_rep_1_3;

  PROCEDURE pr_parameter_spec(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line||':' ||UTL_CALL_STACK.CONCATENATE_SUBPROGRAM(UTL_CALL_STACK.SUBPROGRAM(1))||': g_curr_token_ix:'||   g_curr_token_ix);
    g_tokens( g_curr_token_ix ).print_details;
    po_success := FALSE;
    IF NOT po_success THEN
      pr_parameter_spec_1(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END pr_parameter_spec;

  PROCEDURE pr_parameter_spec_1(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
    po_success := TRUE;
    -- Position 1: Symbol <identifier>
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '<identifier>' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 2: Symbol <parameter_spec_opt_1>
    IF po_success THEN
      pr_parameter_spec_opt_1(po_success);
    END IF;
    -- Position 3: Symbol <data_type>
    IF po_success THEN
      pr_data_type(po_success);
    END IF;
    -- Position 4: Symbol <parameter_spec_opt_2>
    IF po_success THEN
      pr_parameter_spec_opt_2(po_success);
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_parameter_spec_1;

  PROCEDURE pr_parameter_spec_opt_1(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line||':' ||UTL_CALL_STACK.CONCATENATE_SUBPROGRAM(UTL_CALL_STACK.SUBPROGRAM(1))||': g_curr_token_ix:'||   g_curr_token_ix);
    g_tokens( g_curr_token_ix ).print_details;
    po_success := FALSE;
    IF NOT po_success THEN
      pr_parameter_spec_opt_1_2(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      pr_parameter_spec_opt_1_3(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      pr_parameter_spec_opt_1_4(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      pr_parameter_spec_opt_1_5(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END pr_parameter_spec_opt_1;

  PROCEDURE pr_parameter_spec_opt_1_2(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
    po_success := TRUE;
    -- Position 1: Symbol "IN"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '"IN"' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_parameter_spec_opt_1_2;

  PROCEDURE pr_parameter_spec_opt_1_3(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
    po_success := TRUE;
    -- Position 1: Symbol "OUT"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '"OUT"' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_parameter_spec_opt_1_3;

  PROCEDURE pr_parameter_spec_opt_1_4(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
    po_success := TRUE;
    -- Position 1: Symbol "IN
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '"IN' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 2: Symbol OUT"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( 'OUT"' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_parameter_spec_opt_1_4;

  PROCEDURE pr_parameter_spec_opt_1_5(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
    po_success := TRUE;
    -- Position 1: Symbol EPSILON
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( 'EPSILON' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_parameter_spec_opt_1_5;

  PROCEDURE pr_parameter_spec_opt_2(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line||':' ||UTL_CALL_STACK.CONCATENATE_SUBPROGRAM(UTL_CALL_STACK.SUBPROGRAM(1))||': g_curr_token_ix:'||   g_curr_token_ix);
    g_tokens( g_curr_token_ix ).print_details;
    po_success := FALSE;
    IF NOT po_success THEN
      pr_parameter_spec_opt_2_6(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      pr_parameter_spec_opt_2_7(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END pr_parameter_spec_opt_2;

  PROCEDURE pr_parameter_spec_opt_2_6(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
    po_success := TRUE;
    -- Position 1: Symbol ":="
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '":="' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 2: Symbol <expression>
    IF po_success THEN
      pr_expression(po_success);
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_parameter_spec_opt_2_6;

  PROCEDURE pr_parameter_spec_opt_2_7(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
    po_success := TRUE;
    -- Position 1: Symbol EPSILON
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( 'EPSILON' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_parameter_spec_opt_2_7;

  PROCEDURE pr_procedure_body(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line||':' ||UTL_CALL_STACK.CONCATENATE_SUBPROGRAM(UTL_CALL_STACK.SUBPROGRAM(1))||': g_curr_token_ix:'||   g_curr_token_ix);
    g_tokens( g_curr_token_ix ).print_details;
    po_success := FALSE;
    IF NOT po_success THEN
      pr_procedure_body_1(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END pr_procedure_body;

  PROCEDURE pr_procedure_body_1(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
    po_success := TRUE;
    -- Position 1: Symbol <procedure_spec>
    IF po_success THEN
      pr_procedure_spec(po_success);
    END IF;
    -- Position 2: Symbol "IS"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '"IS"' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 3: Symbol <declaration_section>
    IF po_success THEN
      pr_declaration_section(po_success);
    END IF;
    -- Position 4: Symbol "BEGIN"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '"BEGIN"' )  THEN
        pr_increment_token_ix;
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
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '"END"' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 8: Symbol <identifier>
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '<identifier>' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 9: Symbol ";"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '";"' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_procedure_body_1;

  PROCEDURE pr_procedure_body_opt_1(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line||':' ||UTL_CALL_STACK.CONCATENATE_SUBPROGRAM(UTL_CALL_STACK.SUBPROGRAM(1))||': g_curr_token_ix:'||   g_curr_token_ix);
    g_tokens( g_curr_token_ix ).print_details;
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
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
    po_success := TRUE;
    -- Position 1: Symbol "EXCEPTION"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '"EXCEPTION"' )  THEN
        pr_increment_token_ix;
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
  END pr_procedure_body_opt_1_2;

  PROCEDURE pr_procedure_body_opt_1_3(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
    po_success := TRUE;
    -- Position 1: Symbol EPSILON
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( 'EPSILON' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_procedure_body_opt_1_3;

  PROCEDURE pr_procedure_call(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line||':' ||UTL_CALL_STACK.CONCATENATE_SUBPROGRAM(UTL_CALL_STACK.SUBPROGRAM(1))||': g_curr_token_ix:'||   g_curr_token_ix);
    g_tokens( g_curr_token_ix ).print_details;
    po_success := FALSE;
    IF NOT po_success THEN
      pr_procedure_call_1(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END pr_procedure_call;

  PROCEDURE pr_procedure_call_1(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
    po_success := TRUE;
    -- Position 1: Symbol <identifier>
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '<identifier>' )  THEN
        pr_increment_token_ix;
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
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '";"' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_procedure_call_1;

  PROCEDURE pr_procedure_call_opt_1(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line||':' ||UTL_CALL_STACK.CONCATENATE_SUBPROGRAM(UTL_CALL_STACK.SUBPROGRAM(1))||': g_curr_token_ix:'||   g_curr_token_ix);
    g_tokens( g_curr_token_ix ).print_details;
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
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
    po_success := TRUE;
    -- Position 1: Symbol "("
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '"("' )  THEN
        pr_increment_token_ix;
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
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '")"' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_procedure_call_opt_1_2;

  PROCEDURE pr_procedure_call_opt_1_3(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
    po_success := TRUE;
    -- Position 1: Symbol EPSILON
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( 'EPSILON' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_procedure_call_opt_1_3;

  PROCEDURE pr_procedure_spec(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line||':' ||UTL_CALL_STACK.CONCATENATE_SUBPROGRAM(UTL_CALL_STACK.SUBPROGRAM(1))||': g_curr_token_ix:'||   g_curr_token_ix);
    g_tokens( g_curr_token_ix ).print_details;
    po_success := FALSE;
    IF NOT po_success THEN
      pr_procedure_spec_1(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END pr_procedure_spec;

  PROCEDURE pr_procedure_spec_1(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
    po_success := TRUE;
    -- Position 1: Symbol "PROCEDURE"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '"PROCEDURE"' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 2: Symbol <identifier>
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '<identifier>' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 3: Symbol <procedure_spec_opt_1>
    IF po_success THEN
      pr_procedure_spec_opt_1(po_success);
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_procedure_spec_1;

  PROCEDURE pr_procedure_spec_opt_1(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line||':' ||UTL_CALL_STACK.CONCATENATE_SUBPROGRAM(UTL_CALL_STACK.SUBPROGRAM(1))||': g_curr_token_ix:'||   g_curr_token_ix);
    g_tokens( g_curr_token_ix ).print_details;
    po_success := FALSE;
    IF NOT po_success THEN
      pr_procedure_spec_opt_1_2(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      pr_procedure_spec_opt_1_3(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END pr_procedure_spec_opt_1;

  PROCEDURE pr_procedure_spec_opt_1_2(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
    po_success := TRUE;
    -- Position 1: Symbol "("
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '"("' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 2: Symbol <parameter_list>
    IF po_success THEN
      pr_parameter_list(po_success);
    END IF;
    -- Position 3: Symbol ")"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '")"' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_procedure_spec_opt_1_2;

  PROCEDURE pr_procedure_spec_opt_1_3(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
    po_success := TRUE;
    -- Position 1: Symbol EPSILON
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( 'EPSILON' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_procedure_spec_opt_1_3;

  PROCEDURE pr_raise_statement(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line||':' ||UTL_CALL_STACK.CONCATENATE_SUBPROGRAM(UTL_CALL_STACK.SUBPROGRAM(1))||': g_curr_token_ix:'||   g_curr_token_ix);
    g_tokens( g_curr_token_ix ).print_details;
    po_success := FALSE;
    IF NOT po_success THEN
      pr_raise_statement_1(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END pr_raise_statement;

  PROCEDURE pr_raise_statement_1(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
    po_success := TRUE;
    -- Position 1: Symbol "RAISE"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '"RAISE"' )  THEN
        pr_increment_token_ix;
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
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '";"' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_raise_statement_1;

  PROCEDURE pr_raise_statement_opt_1(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line||':' ||UTL_CALL_STACK.CONCATENATE_SUBPROGRAM(UTL_CALL_STACK.SUBPROGRAM(1))||': g_curr_token_ix:'||   g_curr_token_ix);
    g_tokens( g_curr_token_ix ).print_details;
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
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
    po_success := TRUE;
    -- Position 1: Symbol <exception_name>
    IF po_success THEN
      pr_exception_name(po_success);
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_raise_statement_opt_1_2;

  PROCEDURE pr_raise_statement_opt_1_3(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
    po_success := TRUE;
    -- Position 1: Symbol EPSILON
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( 'EPSILON' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_raise_statement_opt_1_3;

  PROCEDURE pr_range(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line||':' ||UTL_CALL_STACK.CONCATENATE_SUBPROGRAM(UTL_CALL_STACK.SUBPROGRAM(1))||': g_curr_token_ix:'||   g_curr_token_ix);
    g_tokens( g_curr_token_ix ).print_details;
    po_success := FALSE;
    IF NOT po_success THEN
      pr_range_1(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END pr_range;

  PROCEDURE pr_range_1(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
    po_success := TRUE;
    -- Position 1: Symbol <expression>
    IF po_success THEN
      pr_expression(po_success);
    END IF;
    -- Position 2: Symbol ".."
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '".."' )  THEN
        pr_increment_token_ix;
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
  END pr_range_1;

  PROCEDURE pr_record_field_spec(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line||':' ||UTL_CALL_STACK.CONCATENATE_SUBPROGRAM(UTL_CALL_STACK.SUBPROGRAM(1))||': g_curr_token_ix:'||   g_curr_token_ix);
    g_tokens( g_curr_token_ix ).print_details;
    po_success := FALSE;
    IF NOT po_success THEN
      pr_record_field_spec_1(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END pr_record_field_spec;

  PROCEDURE pr_record_field_spec_1(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
    po_success := TRUE;
    -- Position 1: Symbol <identifier>
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '<identifier>' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 2: Symbol <data_type>
    IF po_success THEN
      pr_data_type(po_success);
    END IF;
    -- Position 3: Symbol <record_field_spec_opt_1>
    IF po_success THEN
      pr_record_field_spec_opt_1(po_success);
    END IF;
    -- Position 4: Symbol <record_field_spec_opt_2>
    IF po_success THEN
      pr_record_field_spec_opt_2(po_success);
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_record_field_spec_1;

  PROCEDURE pr_record_field_spec_opt_1(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line||':' ||UTL_CALL_STACK.CONCATENATE_SUBPROGRAM(UTL_CALL_STACK.SUBPROGRAM(1))||': g_curr_token_ix:'||   g_curr_token_ix);
    g_tokens( g_curr_token_ix ).print_details;
    po_success := FALSE;
    IF NOT po_success THEN
      pr_record_field_spec_opt_1_2(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      pr_record_field_spec_opt_1_3(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END pr_record_field_spec_opt_1;

  PROCEDURE pr_record_field_spec_opt_1_2(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
    po_success := TRUE;
    -- Position 1: Symbol "NOT
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '"NOT' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 2: Symbol NULL"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( 'NULL"' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_record_field_spec_opt_1_2;

  PROCEDURE pr_record_field_spec_opt_1_3(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
    po_success := TRUE;
    -- Position 1: Symbol EPSILON
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( 'EPSILON' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_record_field_spec_opt_1_3;

  PROCEDURE pr_record_field_spec_opt_2(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line||':' ||UTL_CALL_STACK.CONCATENATE_SUBPROGRAM(UTL_CALL_STACK.SUBPROGRAM(1))||': g_curr_token_ix:'||   g_curr_token_ix);
    g_tokens( g_curr_token_ix ).print_details;
    po_success := FALSE;
    IF NOT po_success THEN
      pr_record_field_spec_opt_2_4(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      pr_record_field_spec_opt_2_5(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      pr_record_field_spec_opt_2_6(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END pr_record_field_spec_opt_2;

  PROCEDURE pr_record_field_spec_opt_2_4(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
    po_success := TRUE;
    -- Position 1: Symbol ":="
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '":="' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 2: Symbol <expression>
    IF po_success THEN
      pr_expression(po_success);
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_record_field_spec_opt_2_4;

  PROCEDURE pr_record_field_spec_opt_2_5(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
    po_success := TRUE;
    -- Position 1: Symbol "DEFAULT"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '"DEFAULT"' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 2: Symbol <expression>
    IF po_success THEN
      pr_expression(po_success);
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_record_field_spec_opt_2_5;

  PROCEDURE pr_record_field_spec_opt_2_6(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
    po_success := TRUE;
    -- Position 1: Symbol EPSILON
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( 'EPSILON' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_record_field_spec_opt_2_6;

  PROCEDURE pr_record_type_definition(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line||':' ||UTL_CALL_STACK.CONCATENATE_SUBPROGRAM(UTL_CALL_STACK.SUBPROGRAM(1))||': g_curr_token_ix:'||   g_curr_token_ix);
    g_tokens( g_curr_token_ix ).print_details;
    po_success := FALSE;
    IF NOT po_success THEN
      pr_record_type_definition_1(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END pr_record_type_definition;

  PROCEDURE pr_record_type_definition_1(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
    po_success := TRUE;
    -- Position 1: Symbol "RECORD"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '"RECORD"' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 2: Symbol "("
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '"("' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 3: Symbol <record_field_spec>
    IF po_success THEN
      pr_record_field_spec(po_success);
    END IF;
    -- Position 4: Symbol <record_type_definition_rep_1>
    IF po_success THEN
      pr_record_type_definition_rep_1(po_success);
    END IF;
    -- Position 5: Symbol ")"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '")"' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_record_type_definition_1;

  PROCEDURE pr_record_type_definition_rep_1(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line||':' ||UTL_CALL_STACK.CONCATENATE_SUBPROGRAM(UTL_CALL_STACK.SUBPROGRAM(1))||': g_curr_token_ix:'||   g_curr_token_ix);
    g_tokens( g_curr_token_ix ).print_details;
    po_success := FALSE;
    IF NOT po_success THEN
      pr_record_type_definition_rep_1_2(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      pr_record_type_definition_rep_1_3(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END pr_record_type_definition_rep_1;

  PROCEDURE pr_record_type_definition_rep_1_2(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
    po_success := TRUE;
    -- Position 1: Symbol ","
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '","' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 2: Symbol <record_field_spec>
    IF po_success THEN
      pr_record_field_spec(po_success);
    END IF;
    -- Position 3: Symbol <record_type_definition_rep_1>
    IF po_success THEN
      pr_record_type_definition_rep_1(po_success);
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_record_type_definition_rep_1_2;

  PROCEDURE pr_record_type_definition_rep_1_3(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
    po_success := TRUE;
    -- Position 1: Symbol EPSILON
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( 'EPSILON' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_record_type_definition_rep_1_3;

  PROCEDURE pr_ref_cursor_type_definition(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line||':' ||UTL_CALL_STACK.CONCATENATE_SUBPROGRAM(UTL_CALL_STACK.SUBPROGRAM(1))||': g_curr_token_ix:'||   g_curr_token_ix);
    g_tokens( g_curr_token_ix ).print_details;
    po_success := FALSE;
    IF NOT po_success THEN
      pr_ref_cursor_type_definition_1(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END pr_ref_cursor_type_definition;

  PROCEDURE pr_ref_cursor_type_definition_1(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
    po_success := TRUE;
    -- Position 1: Symbol "REF
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '"REF' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 2: Symbol CURSOR"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( 'CURSOR"' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 3: Symbol <ref_cursor_type_definition_opt_1>
    IF po_success THEN
      pr_ref_cursor_type_definition_opt_1(po_success);
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_ref_cursor_type_definition_1;

  PROCEDURE pr_ref_cursor_type_definition_opt_1(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line||':' ||UTL_CALL_STACK.CONCATENATE_SUBPROGRAM(UTL_CALL_STACK.SUBPROGRAM(1))||': g_curr_token_ix:'||   g_curr_token_ix);
    g_tokens( g_curr_token_ix ).print_details;
    po_success := FALSE;
    IF NOT po_success THEN
      pr_ref_cursor_type_definition_opt_1_2(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      pr_ref_cursor_type_definition_opt_1_3(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END pr_ref_cursor_type_definition_opt_1;

  PROCEDURE pr_ref_cursor_type_definition_opt_1_2(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
    po_success := TRUE;
    -- Position 1: Symbol "RETURN"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '"RETURN"' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 2: Symbol <data_type>
    IF po_success THEN
      pr_data_type(po_success);
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_ref_cursor_type_definition_opt_1_2;

  PROCEDURE pr_ref_cursor_type_definition_opt_1_3(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
    po_success := TRUE;
    -- Position 1: Symbol EPSILON
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( 'EPSILON' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_ref_cursor_type_definition_opt_1_3;

  PROCEDURE pr_rollback_statement(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line||':' ||UTL_CALL_STACK.CONCATENATE_SUBPROGRAM(UTL_CALL_STACK.SUBPROGRAM(1))||': g_curr_token_ix:'||   g_curr_token_ix);
    g_tokens( g_curr_token_ix ).print_details;
    po_success := FALSE;
    IF NOT po_success THEN
      pr_rollback_statement_1(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END pr_rollback_statement;

  PROCEDURE pr_rollback_statement_1(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
    po_success := TRUE;
    -- Position 1: Symbol "ROLLBACK"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '"ROLLBACK"' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_rollback_statement_1;

  PROCEDURE pr_statement(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line||':' ||UTL_CALL_STACK.CONCATENATE_SUBPROGRAM(UTL_CALL_STACK.SUBPROGRAM(1))||': g_curr_token_ix:'||   g_curr_token_ix);
    g_tokens( g_curr_token_ix ).print_details;
    po_success := FALSE;
    IF NOT po_success THEN
      pr_statement_1(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END pr_statement;

  PROCEDURE pr_statement_1(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
    po_success := TRUE;
    -- Position 1: Symbol <assignment_statement>
    IF po_success THEN
      pr_assignment_statement(po_success);
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_statement_1;

  PROCEDURE pr_table_or_view_reference(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line||':' ||UTL_CALL_STACK.CONCATENATE_SUBPROGRAM(UTL_CALL_STACK.SUBPROGRAM(1))||': g_curr_token_ix:'||   g_curr_token_ix);
    g_tokens( g_curr_token_ix ).print_details;
    po_success := FALSE;
    IF NOT po_success THEN
      pr_table_or_view_reference_1(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END pr_table_or_view_reference;

  PROCEDURE pr_table_or_view_reference_1(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
    po_success := TRUE;
    -- Position 1: Symbol <identifier>
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '<identifier>' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 2: Symbol <table_or_view_reference_opt_1>
    IF po_success THEN
      pr_table_or_view_reference_opt_1(po_success);
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_table_or_view_reference_1;

  PROCEDURE pr_table_or_view_reference_opt_1(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line||':' ||UTL_CALL_STACK.CONCATENATE_SUBPROGRAM(UTL_CALL_STACK.SUBPROGRAM(1))||': g_curr_token_ix:'||   g_curr_token_ix);
    g_tokens( g_curr_token_ix ).print_details;
    po_success := FALSE;
    IF NOT po_success THEN
      pr_table_or_view_reference_opt_1_2(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      pr_table_or_view_reference_opt_1_3(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END pr_table_or_view_reference_opt_1;

  PROCEDURE pr_table_or_view_reference_opt_1_2(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
    po_success := TRUE;
    -- Position 1: Symbol "."
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '"."' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 2: Symbol <identifier>
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '<identifier>' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_table_or_view_reference_opt_1_2;

  PROCEDURE pr_table_or_view_reference_opt_1_3(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
    po_success := TRUE;
    -- Position 1: Symbol EPSILON
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( 'EPSILON' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_table_or_view_reference_opt_1_3;

  PROCEDURE pr_term(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line||':' ||UTL_CALL_STACK.CONCATENATE_SUBPROGRAM(UTL_CALL_STACK.SUBPROGRAM(1))||': g_curr_token_ix:'||   g_curr_token_ix);
    g_tokens( g_curr_token_ix ).print_details;
    po_success := FALSE;
    IF NOT po_success THEN
      pr_term_1(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END pr_term;

  PROCEDURE pr_term_1(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
    po_success := TRUE;
    -- Position 1: Symbol <literal>
    IF po_success THEN
      pr_literal(po_success);
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_term_1;

  PROCEDURE pr_trigger(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line||':' ||UTL_CALL_STACK.CONCATENATE_SUBPROGRAM(UTL_CALL_STACK.SUBPROGRAM(1))||': g_curr_token_ix:'||   g_curr_token_ix);
    g_tokens( g_curr_token_ix ).print_details;
    po_success := FALSE;
    IF NOT po_success THEN
      pr_trigger_1(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END pr_trigger;

  PROCEDURE pr_trigger_1(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
    po_success := TRUE;
    -- Position 1: Symbol "CREATE"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '"CREATE"' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 2: Symbol "OR"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '"OR"' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 3: Symbol "REPLACE"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '"REPLACE"' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 4: Symbol "TRIGGER"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '"TRIGGER"' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 5: Symbol <identifier>
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '<identifier>' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 6: Symbol <trigger_time_event>
    IF po_success THEN
      pr_trigger_time_event(po_success);
    END IF;
    -- Position 7: Symbol <trigger_body>
    IF po_success THEN
      pr_trigger_body(po_success);
    END IF;
    -- Position 8: Symbol "END"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '"END"' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 9: Symbol <identifier>
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '<identifier>' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 10: Symbol ";"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '";"' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_trigger_1;

  PROCEDURE pr_trigger_body(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line||':' ||UTL_CALL_STACK.CONCATENATE_SUBPROGRAM(UTL_CALL_STACK.SUBPROGRAM(1))||': g_curr_token_ix:'||   g_curr_token_ix);
    g_tokens( g_curr_token_ix ).print_details;
    po_success := FALSE;
    IF NOT po_success THEN
      pr_trigger_body_1(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END pr_trigger_body;

  PROCEDURE pr_trigger_body_1(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
    po_success := TRUE;
    -- Position 1: Symbol <declaration_section>
    IF po_success THEN
      pr_declaration_section(po_success);
    END IF;
    -- Position 2: Symbol "BEGIN"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '"BEGIN"' )  THEN
        pr_increment_token_ix;
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
  END pr_trigger_body_1;

  PROCEDURE pr_trigger_body_opt_1(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line||':' ||UTL_CALL_STACK.CONCATENATE_SUBPROGRAM(UTL_CALL_STACK.SUBPROGRAM(1))||': g_curr_token_ix:'||   g_curr_token_ix);
    g_tokens( g_curr_token_ix ).print_details;
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
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
    po_success := TRUE;
    -- Position 1: Symbol "EXCEPTION"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '"EXCEPTION"' )  THEN
        pr_increment_token_ix;
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
  END pr_trigger_body_opt_1_2;

  PROCEDURE pr_trigger_body_opt_1_3(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
    po_success := TRUE;
    -- Position 1: Symbol EPSILON
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( 'EPSILON' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_trigger_body_opt_1_3;

  PROCEDURE pr_trigger_event(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line||':' ||UTL_CALL_STACK.CONCATENATE_SUBPROGRAM(UTL_CALL_STACK.SUBPROGRAM(1))||': g_curr_token_ix:'||   g_curr_token_ix);
    g_tokens( g_curr_token_ix ).print_details;
    po_success := FALSE;
    IF NOT po_success THEN
      pr_trigger_event_1(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END pr_trigger_event;

  PROCEDURE pr_trigger_event_1(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
    po_success := TRUE;
    -- Position 1: Symbol "INSERT"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '"INSERT"' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_trigger_event_1;

  PROCEDURE pr_trigger_event_list(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line||':' ||UTL_CALL_STACK.CONCATENATE_SUBPROGRAM(UTL_CALL_STACK.SUBPROGRAM(1))||': g_curr_token_ix:'||   g_curr_token_ix);
    g_tokens( g_curr_token_ix ).print_details;
    po_success := FALSE;
    IF NOT po_success THEN
      pr_trigger_event_list_1(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END pr_trigger_event_list;

  PROCEDURE pr_trigger_event_list_1(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
    po_success := TRUE;
    -- Position 1: Symbol <trigger_event>
    IF po_success THEN
      pr_trigger_event(po_success);
    END IF;
    -- Position 2: Symbol <trigger_event_list_rep_1>
    IF po_success THEN
      pr_trigger_event_list_rep_1(po_success);
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_trigger_event_list_1;

  PROCEDURE pr_trigger_event_list_rep_1(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line||':' ||UTL_CALL_STACK.CONCATENATE_SUBPROGRAM(UTL_CALL_STACK.SUBPROGRAM(1))||': g_curr_token_ix:'||   g_curr_token_ix);
    g_tokens( g_curr_token_ix ).print_details;
    po_success := FALSE;
    IF NOT po_success THEN
      pr_trigger_event_list_rep_1_2(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      pr_trigger_event_list_rep_1_3(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END pr_trigger_event_list_rep_1;

  PROCEDURE pr_trigger_event_list_rep_1_2(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
    po_success := TRUE;
    -- Position 1: Symbol "OR"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '"OR"' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 2: Symbol <trigger_event>
    IF po_success THEN
      pr_trigger_event(po_success);
    END IF;
    -- Position 3: Symbol <trigger_event_list_rep_1>
    IF po_success THEN
      pr_trigger_event_list_rep_1(po_success);
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_trigger_event_list_rep_1_2;

  PROCEDURE pr_trigger_event_list_rep_1_3(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
    po_success := TRUE;
    -- Position 1: Symbol EPSILON
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( 'EPSILON' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_trigger_event_list_rep_1_3;

  PROCEDURE pr_trigger_time_event(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line||':' ||UTL_CALL_STACK.CONCATENATE_SUBPROGRAM(UTL_CALL_STACK.SUBPROGRAM(1))||': g_curr_token_ix:'||   g_curr_token_ix);
    g_tokens( g_curr_token_ix ).print_details;
    po_success := FALSE;
    IF NOT po_success THEN
      pr_trigger_time_event_1(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END pr_trigger_time_event;

  PROCEDURE pr_trigger_time_event_1(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
    po_success := TRUE;
    -- Position 1: Symbol <trigger_timing>
    IF po_success THEN
      pr_trigger_timing(po_success);
    END IF;
    -- Position 2: Symbol <trigger_event_list>
    IF po_success THEN
      pr_trigger_event_list(po_success);
    END IF;
    -- Position 3: Symbol "ON"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '"ON"' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 4: Symbol <table_or_view_reference>
    IF po_success THEN
      pr_table_or_view_reference(po_success);
    END IF;
    -- Position 5: Symbol <trigger_time_event_opt_1>
    IF po_success THEN
      pr_trigger_time_event_opt_1(po_success);
    END IF;
    -- Position 6: Symbol <trigger_time_event_opt_2>
    IF po_success THEN
      pr_trigger_time_event_opt_2(po_success);
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_trigger_time_event_1;

  PROCEDURE pr_trigger_time_event_opt_1(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line||':' ||UTL_CALL_STACK.CONCATENATE_SUBPROGRAM(UTL_CALL_STACK.SUBPROGRAM(1))||': g_curr_token_ix:'||   g_curr_token_ix);
    g_tokens( g_curr_token_ix ).print_details;
    po_success := FALSE;
    IF NOT po_success THEN
      pr_trigger_time_event_opt_1_2(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      pr_trigger_time_event_opt_1_3(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END pr_trigger_time_event_opt_1;

  PROCEDURE pr_trigger_time_event_opt_1_2(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
    po_success := TRUE;
    -- Position 1: Symbol "FOR
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '"FOR' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 2: Symbol EACH
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( 'EACH' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 3: Symbol ROW"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( 'ROW"' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_trigger_time_event_opt_1_2;

  PROCEDURE pr_trigger_time_event_opt_1_3(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
    po_success := TRUE;
    -- Position 1: Symbol EPSILON
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( 'EPSILON' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_trigger_time_event_opt_1_3;

  PROCEDURE pr_trigger_time_event_opt_2(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line||':' ||UTL_CALL_STACK.CONCATENATE_SUBPROGRAM(UTL_CALL_STACK.SUBPROGRAM(1))||': g_curr_token_ix:'||   g_curr_token_ix);
    g_tokens( g_curr_token_ix ).print_details;
    po_success := FALSE;
    IF NOT po_success THEN
      pr_trigger_time_event_opt_2_4(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      pr_trigger_time_event_opt_2_5(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END pr_trigger_time_event_opt_2;

  PROCEDURE pr_trigger_time_event_opt_2_4(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
    po_success := TRUE;
    -- Position 1: Symbol <trigger_when_clause>
    IF po_success THEN
      pr_trigger_when_clause(po_success);
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_trigger_time_event_opt_2_4;

  PROCEDURE pr_trigger_time_event_opt_2_5(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
    po_success := TRUE;
    -- Position 1: Symbol EPSILON
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( 'EPSILON' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_trigger_time_event_opt_2_5;

  PROCEDURE pr_trigger_timing(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line||':' ||UTL_CALL_STACK.CONCATENATE_SUBPROGRAM(UTL_CALL_STACK.SUBPROGRAM(1))||': g_curr_token_ix:'||   g_curr_token_ix);
    g_tokens( g_curr_token_ix ).print_details;
    po_success := FALSE;
    IF NOT po_success THEN
      pr_trigger_timing_1(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END pr_trigger_timing;

  PROCEDURE pr_trigger_timing_1(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
    po_success := TRUE;
    -- Position 1: Symbol "BEFORE"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '"BEFORE"' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_trigger_timing_1;

  PROCEDURE pr_trigger_when_clause(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line||':' ||UTL_CALL_STACK.CONCATENATE_SUBPROGRAM(UTL_CALL_STACK.SUBPROGRAM(1))||': g_curr_token_ix:'||   g_curr_token_ix);
    g_tokens( g_curr_token_ix ).print_details;
    po_success := FALSE;
    IF NOT po_success THEN
      pr_trigger_when_clause_1(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END pr_trigger_when_clause;

  PROCEDURE pr_trigger_when_clause_1(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
    po_success := TRUE;
    -- Position 1: Symbol "WHEN"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '"WHEN"' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 2: Symbol "("
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '"("' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 3: Symbol <condition>
    IF po_success THEN
      pr_condition(po_success);
    END IF;
    -- Position 4: Symbol ")"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '")"' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_trigger_when_clause_1;

  PROCEDURE pr_type_declaration(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line||':' ||UTL_CALL_STACK.CONCATENATE_SUBPROGRAM(UTL_CALL_STACK.SUBPROGRAM(1))||': g_curr_token_ix:'||   g_curr_token_ix);
    g_tokens( g_curr_token_ix ).print_details;
    po_success := FALSE;
    IF NOT po_success THEN
      pr_type_declaration_1(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END pr_type_declaration;

  PROCEDURE pr_type_declaration_1(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
    po_success := TRUE;
    -- Position 1: Symbol "TYPE"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '"TYPE"' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 2: Symbol <identifier>
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '<identifier>' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 3: Symbol "IS"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '"IS"' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 4: Symbol <type_definition>
    IF po_success THEN
      pr_type_definition(po_success);
    END IF;
    -- Position 5: Symbol ";"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '";"' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_type_declaration_1;

  PROCEDURE pr_type_definition(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line||':' ||UTL_CALL_STACK.CONCATENATE_SUBPROGRAM(UTL_CALL_STACK.SUBPROGRAM(1))||': g_curr_token_ix:'||   g_curr_token_ix);
    g_tokens( g_curr_token_ix ).print_details;
    po_success := FALSE;
    IF NOT po_success THEN
      pr_type_definition_1(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END pr_type_definition;

  PROCEDURE pr_type_definition_1(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
    po_success := TRUE;
    -- Position 1: Symbol <record_type_definition>
    IF po_success THEN
      pr_record_type_definition(po_success);
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_type_definition_1;

  PROCEDURE pr_variable_declaration(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line||':' ||UTL_CALL_STACK.CONCATENATE_SUBPROGRAM(UTL_CALL_STACK.SUBPROGRAM(1))||': g_curr_token_ix:'||   g_curr_token_ix);
    g_tokens( g_curr_token_ix ).print_details;
    po_success := FALSE;
    IF NOT po_success THEN
      pr_variable_declaration_1(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END pr_variable_declaration;

  PROCEDURE pr_variable_declaration_1(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
    po_success := TRUE;
    -- Position 1: Symbol <identifier>
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '<identifier>' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 2: Symbol <variable_declaration_opt_1>
    IF po_success THEN
      pr_variable_declaration_opt_1(po_success);
    END IF;
    -- Position 3: Symbol <data_type>
    IF po_success THEN
      pr_data_type(po_success);
    END IF;
    -- Position 4: Symbol <variable_declaration_opt_2>
    IF po_success THEN
      pr_variable_declaration_opt_2(po_success);
    END IF;
    -- Position 5: Symbol ";"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '";"' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_variable_declaration_1;

  PROCEDURE pr_variable_declaration_opt_1(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line||':' ||UTL_CALL_STACK.CONCATENATE_SUBPROGRAM(UTL_CALL_STACK.SUBPROGRAM(1))||': g_curr_token_ix:'||   g_curr_token_ix);
    g_tokens( g_curr_token_ix ).print_details;
    po_success := FALSE;
    IF NOT po_success THEN
      pr_variable_declaration_opt_1_2(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      pr_variable_declaration_opt_1_3(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END pr_variable_declaration_opt_1;

  PROCEDURE pr_variable_declaration_opt_1_2(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
    po_success := TRUE;
    -- Position 1: Symbol "CONSTANT"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '"CONSTANT"' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_variable_declaration_opt_1_2;

  PROCEDURE pr_variable_declaration_opt_1_3(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
    po_success := TRUE;
    -- Position 1: Symbol EPSILON
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( 'EPSILON' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_variable_declaration_opt_1_3;

  PROCEDURE pr_variable_declaration_opt_2(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line||':' ||UTL_CALL_STACK.CONCATENATE_SUBPROGRAM(UTL_CALL_STACK.SUBPROGRAM(1))||': g_curr_token_ix:'||   g_curr_token_ix);
    g_tokens( g_curr_token_ix ).print_details;
    po_success := FALSE;
    IF NOT po_success THEN
      pr_variable_declaration_opt_2_4(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      pr_variable_declaration_opt_2_5(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END pr_variable_declaration_opt_2;

  PROCEDURE pr_variable_declaration_opt_2_4(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
    po_success := TRUE;
    -- Position 1: Symbol ":="
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '":="' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 2: Symbol <expression>
    IF po_success THEN
      pr_expression(po_success);
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_variable_declaration_opt_2_4;

  PROCEDURE pr_variable_declaration_opt_2_5(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
    po_success := TRUE;
    -- Position 1: Symbol EPSILON
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( 'EPSILON' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_variable_declaration_opt_2_5;

  PROCEDURE pr_variable_reference(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line||':' ||UTL_CALL_STACK.CONCATENATE_SUBPROGRAM(UTL_CALL_STACK.SUBPROGRAM(1))||': g_curr_token_ix:'||   g_curr_token_ix);
    g_tokens( g_curr_token_ix ).print_details;
    po_success := FALSE;
    IF NOT po_success THEN
      pr_variable_reference_1(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END pr_variable_reference;

  PROCEDURE pr_variable_reference_1(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
    po_success := TRUE;
    -- Position 1: Symbol <identifier>
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '<identifier>' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 2: Symbol <variable_reference_rep_1>
    IF po_success THEN
      pr_variable_reference_rep_1(po_success);
    END IF;
    -- Position 3: Symbol <variable_reference_opt_2>
    IF po_success THEN
      pr_variable_reference_opt_2(po_success);
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_variable_reference_1;

  PROCEDURE pr_variable_reference_opt_2(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line||':' ||UTL_CALL_STACK.CONCATENATE_SUBPROGRAM(UTL_CALL_STACK.SUBPROGRAM(1))||': g_curr_token_ix:'||   g_curr_token_ix);
    g_tokens( g_curr_token_ix ).print_details;
    po_success := FALSE;
    IF NOT po_success THEN
      pr_variable_reference_opt_2_4(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      pr_variable_reference_opt_2_5(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END pr_variable_reference_opt_2;

  PROCEDURE pr_variable_reference_opt_2_4(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
    po_success := TRUE;
    -- Position 1: Symbol "("
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '"("' )  THEN
        pr_increment_token_ix;
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
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '")"' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_variable_reference_opt_2_4;

  PROCEDURE pr_variable_reference_opt_2_5(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
    po_success := TRUE;
    -- Position 1: Symbol EPSILON
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( 'EPSILON' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_variable_reference_opt_2_5;

  PROCEDURE pr_variable_reference_rep_1(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line||':' ||UTL_CALL_STACK.CONCATENATE_SUBPROGRAM(UTL_CALL_STACK.SUBPROGRAM(1))||': g_curr_token_ix:'||   g_curr_token_ix);
    g_tokens( g_curr_token_ix ).print_details;
    po_success := FALSE;
    IF NOT po_success THEN
      pr_variable_reference_rep_1_2(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      pr_variable_reference_rep_1_3(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END pr_variable_reference_rep_1;

  PROCEDURE pr_variable_reference_rep_1_2(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
    po_success := TRUE;
    -- Position 1: Symbol "."
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '"."' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 2: Symbol <identifier>
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '<identifier>' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 3: Symbol <variable_reference_rep_1>
    IF po_success THEN
      pr_variable_reference_rep_1(po_success);
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_variable_reference_rep_1_2;

  PROCEDURE pr_variable_reference_rep_1_3(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
    po_success := TRUE;
    -- Position 1: Symbol EPSILON
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( 'EPSILON' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_variable_reference_rep_1_3;

  PROCEDURE pr_while_statement(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line||':' ||UTL_CALL_STACK.CONCATENATE_SUBPROGRAM(UTL_CALL_STACK.SUBPROGRAM(1))||': g_curr_token_ix:'||   g_curr_token_ix);
    g_tokens( g_curr_token_ix ).print_details;
    po_success := FALSE;
    IF NOT po_success THEN
      pr_while_statement_1(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END pr_while_statement;

  PROCEDURE pr_while_statement_1(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
    po_success := TRUE;
    -- Position 1: Symbol "WHILE"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '"WHILE"' )  THEN
        pr_increment_token_ix;
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
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '"LOOP"' )  THEN
        pr_increment_token_ix;
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
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '"END' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 6: Symbol LOOP"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( 'LOOP"' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 7: Symbol ";"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '";"' )  THEN
        pr_increment_token_ix;
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_while_statement_1;

  PROCEDURE pr_increment_token_ix AS BEGIN g_curr_token_ix := g_curr_token_ix+1; dbms_output.put_line( 'current_ix incremented to '||g_curr_token_ix); END pr_increment_token_ix;
  PROCEDURE parse_main(p_token_stream IN lexer_token_col, po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
  BEGIN
    g_tokens := p_token_stream;
    g_curr_token_ix := 1;
    po_success := FALSE;

    IF NOT po_success THEN
      g_curr_token_ix := 1; -- Reset stream index for next entry option
      pr_block(po_success);
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := 1; -- Reset stream index for next entry option
      pr_collection_type_definition(po_success);
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := 1; -- Reset stream index for next entry option
      pr_column_list(po_success);
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := 1; -- Reset stream index for next entry option
      pr_commit_statement(po_success);
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := 1; -- Reset stream index for next entry option
      pr_constant_declaration(po_success);
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := 1; -- Reset stream index for next entry option
      pr_cursor_declaration(po_success);
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := 1; -- Reset stream index for next entry option
      pr_dynamic_sql_statement(po_success);
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := 1; -- Reset stream index for next entry option
      pr_exception_declaration(po_success);
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := 1; -- Reset stream index for next entry option
      pr_exit_statement(po_success);
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := 1; -- Reset stream index for next entry option
      pr_field_name(po_success);
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := 1; -- Reset stream index for next entry option
      pr_for_statement(po_success);
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := 1; -- Reset stream index for next entry option
      pr_function_body(po_success);
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := 1; -- Reset stream index for next entry option
      pr_function_call(po_success);
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := 1; -- Reset stream index for next entry option
      pr_if_statement(po_success);
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := 1; -- Reset stream index for next entry option
      pr_index_by_type(po_success);
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := 1; -- Reset stream index for next entry option
      pr_loop_statement(po_success);
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := 1; -- Reset stream index for next entry option
      pr_null_statement(po_success);
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := 1; -- Reset stream index for next entry option
      pr_other_sql_statement(po_success);
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := 1; -- Reset stream index for next entry option
      pr_package_body(po_success);
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := 1; -- Reset stream index for next entry option
      pr_package_spec(po_success);
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := 1; -- Reset stream index for next entry option
      pr_procedure_call(po_success);
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := 1; -- Reset stream index for next entry option
      pr_raise_statement(po_success);
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := 1; -- Reset stream index for next entry option
      pr_ref_cursor_type_definition(po_success);
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := 1; -- Reset stream index for next entry option
      pr_rollback_statement(po_success);
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := 1; -- Reset stream index for next entry option
      pr_trigger(po_success);
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := 1; -- Reset stream index for next entry option
      pr_type_declaration(po_success);
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := 1; -- Reset stream index for next entry option
      pr_while_statement(po_success);
    END IF;
  END parse_main;

END PKG_DYNAMIC_PARSER;
/
