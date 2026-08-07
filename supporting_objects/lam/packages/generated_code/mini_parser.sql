CREATE OR REPLACE PACKAGE MINI_PARSER AS
  -- Global collection type for tokens
  g_tokens         lexer_token_col;
  g_curr_token_ix  NUMBER := 1;

  PROCEDURE pr_data_type(po_success OUT BOOLEAN);
  PROCEDURE pr_data_type_opt_1(po_success OUT BOOLEAN);
  PROCEDURE pr_data_type_opt_2(po_success OUT BOOLEAN);
  PROCEDURE pr_index_by_type(po_success OUT BOOLEAN);
  PROCEDURE pr_ref_cursor_type_definition(po_success OUT BOOLEAN);
  PROCEDURE pr_ref_cursor_type_definition_opt_1(po_success OUT BOOLEAN);
  PROCEDURE pr_variable_declaration(po_success OUT BOOLEAN);
  PROCEDURE pr_variable_declaration_opt_1(po_success OUT BOOLEAN);
  PROCEDURE pr_variable_declaration_opt_2(po_success OUT BOOLEAN);

  -- Main entry point for top-level parsing rules
  PROCEDURE pr_increment_token_ix( p_symbol VARCHAR2 );
  PROCEDURE parse_main(p_token_stream IN lexer_token_col, po_success OUT BOOLEAN);
END MINI_PARSER;
/


CREATE OR REPLACE PACKAGE BODY MINI_PARSER AS

  PROCEDURE pr_data_type_1(po_success OUT BOOLEAN);
  PROCEDURE pr_data_type_2(po_success OUT BOOLEAN);
  PROCEDURE pr_data_type_opt_1_3(po_success OUT BOOLEAN);
  PROCEDURE pr_data_type_opt_1_4(po_success OUT BOOLEAN);
  PROCEDURE pr_data_type_opt_1_5(po_success OUT BOOLEAN);
  PROCEDURE pr_data_type_opt_2_6(po_success OUT BOOLEAN);
  PROCEDURE pr_data_type_opt_2_7(po_success OUT BOOLEAN);
  PROCEDURE pr_index_by_type_1(po_success OUT BOOLEAN);
  PROCEDURE pr_index_by_type_2(po_success OUT BOOLEAN);
  PROCEDURE pr_index_by_type_3(po_success OUT BOOLEAN);
  PROCEDURE pr_index_by_type_4(po_success OUT BOOLEAN);
  PROCEDURE pr_ref_cursor_type_definition_1(po_success OUT BOOLEAN);
  PROCEDURE pr_ref_cursor_type_definition_opt_1_2(po_success OUT BOOLEAN);
  PROCEDURE pr_ref_cursor_type_definition_opt_1_3(po_success OUT BOOLEAN);
  PROCEDURE pr_variable_declaration_1(po_success OUT BOOLEAN);
  PROCEDURE pr_variable_declaration_opt_1_2(po_success OUT BOOLEAN);
  PROCEDURE pr_variable_declaration_opt_1_3(po_success OUT BOOLEAN);
  PROCEDURE pr_variable_declaration_opt_2_4(po_success OUT BOOLEAN);
  PROCEDURE pr_variable_declaration_opt_2_5(po_success OUT BOOLEAN);

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
    IF NOT po_success THEN
      pr_data_type_2(po_success);
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
        pr_increment_token_ix( '<identifier>' );
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 2: Symbol "%"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '"%"' )  THEN
        pr_increment_token_ix( '"%"' );
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 3: Symbol <data_type_opt_1>
    IF po_success THEN
      pr_data_type_opt_1(po_success);
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_data_type_1;

  PROCEDURE pr_data_type_2(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
    po_success := TRUE;
    -- Position 1: Symbol <identifier>
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '<identifier>' )  THEN
        pr_increment_token_ix( '<identifier>' );
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 2: Symbol "("
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '"("' )  THEN
        pr_increment_token_ix( '"("' );
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 3: Symbol <number_literal>
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '<number_literal>' )  THEN
        pr_increment_token_ix( '<number_literal>' );
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 4: Symbol <data_type_opt_2>
    IF po_success THEN
      pr_data_type_opt_2(po_success);
    END IF;
    -- Position 5: Symbol ")"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '")"' )  THEN
        pr_increment_token_ix( '")"' );
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_data_type_2;

  PROCEDURE pr_data_type_opt_1(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line||':' ||UTL_CALL_STACK.CONCATENATE_SUBPROGRAM(UTL_CALL_STACK.SUBPROGRAM(1))||': g_curr_token_ix:'||   g_curr_token_ix);
    g_tokens( g_curr_token_ix ).print_details;
    po_success := FALSE;
    IF NOT po_success THEN
      pr_data_type_opt_1_3(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      pr_data_type_opt_1_4(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      pr_data_type_opt_1_5(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END pr_data_type_opt_1;

  PROCEDURE pr_data_type_opt_1_3(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
    po_success := TRUE;
    -- Position 1: Symbol "TYPE"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '"TYPE"' )  THEN
        pr_increment_token_ix( '"TYPE"' );
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
    -- Position 1: Symbol "ROWTYPE"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '"ROWTYPE"' )  THEN
        pr_increment_token_ix( '"ROWTYPE"' );
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_data_type_opt_1_4;

  PROCEDURE pr_data_type_opt_1_5(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
    po_success := TRUE;
    -- Position 1: Symbol EPSILON
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( 'EPSILON' )  THEN
        pr_increment_token_ix( 'EPSILON' );
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_data_type_opt_1_5;

  PROCEDURE pr_data_type_opt_2(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line||':' ||UTL_CALL_STACK.CONCATENATE_SUBPROGRAM(UTL_CALL_STACK.SUBPROGRAM(1))||': g_curr_token_ix:'||   g_curr_token_ix);
    g_tokens( g_curr_token_ix ).print_details;
    po_success := FALSE;
    IF NOT po_success THEN
      pr_data_type_opt_2_6(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      pr_data_type_opt_2_7(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END pr_data_type_opt_2;

  PROCEDURE pr_data_type_opt_2_6(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
    po_success := TRUE;
    -- Position 1: Symbol ","
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '","' )  THEN
        pr_increment_token_ix( '","' );
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 2: Symbol <number_literal>
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '<number_literal>' )  THEN
        pr_increment_token_ix( '<number_literal>' );
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_data_type_opt_2_6;

  PROCEDURE pr_data_type_opt_2_7(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
    po_success := TRUE;
    -- Position 1: Symbol EPSILON
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( 'EPSILON' )  THEN
        pr_increment_token_ix( 'EPSILON' );
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_data_type_opt_2_7;

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
    IF NOT po_success THEN
      pr_index_by_type_2(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      pr_index_by_type_3(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      pr_index_by_type_4(po_success);
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
        pr_increment_token_ix( '"VARCHAR2"' );
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 2: Symbol "("
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '"("' )  THEN
        pr_increment_token_ix( '"("' );
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 3: Symbol <number_literal>
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '<number_literal>' )  THEN
        pr_increment_token_ix( '<number_literal>' );
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 4: Symbol ")"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '")"' )  THEN
        pr_increment_token_ix( '")"' );
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_index_by_type_1;

  PROCEDURE pr_index_by_type_2(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
    po_success := TRUE;
    -- Position 1: Symbol "PLS_INTEGER"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '"PLS_INTEGER"' )  THEN
        pr_increment_token_ix( '"PLS_INTEGER"' );
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_index_by_type_2;

  PROCEDURE pr_index_by_type_3(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
    po_success := TRUE;
    -- Position 1: Symbol "BINARY_INTEGER"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '"BINARY_INTEGER"' )  THEN
        pr_increment_token_ix( '"BINARY_INTEGER"' );
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_index_by_type_3;

  PROCEDURE pr_index_by_type_4(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    dbms_output.put_line( $$plsql_unit||':'||$$plsql_line ||'  g_curr_token_ix: '||g_curr_token_ix );
    po_success := TRUE;
    -- Position 1: Symbol "LONG"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '"LONG"' )  THEN
        pr_increment_token_ix( '"LONG"' );
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_index_by_type_4;

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
        pr_increment_token_ix( '"REF' );
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 2: Symbol CURSOR"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( 'CURSOR"' )  THEN
        pr_increment_token_ix( 'CURSOR"' );
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
        pr_increment_token_ix( '"RETURN"' );
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
        pr_increment_token_ix( 'EPSILON' );
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_ref_cursor_type_definition_opt_1_3;

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
        pr_increment_token_ix( '<identifier>' );
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
        pr_increment_token_ix( '";"' );
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
        pr_increment_token_ix( '"CONSTANT"' );
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
        pr_increment_token_ix( 'EPSILON' );
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
        pr_increment_token_ix( '":="' );
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 2: Symbol <expression>
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '<expression>' )  THEN
        pr_increment_token_ix( '<expression>' );
      ELSE
        po_success := FALSE;
      END IF;
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
        pr_increment_token_ix( 'EPSILON' );
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_variable_declaration_opt_2_5;

PROCEDURE pr_increment_token_ix(p_symbol IN VARCHAR2) AS 
BEGIN 
  IF p_symbol = 'EPSILON' THEN
    -- Do NOT advance token index for Epsilon (empty string)
    dbms_output.put_line('EPSILON matched: current_ix remains ' || g_curr_token_ix);
  ELSE
    g_curr_token_ix := g_curr_token_ix + 1; 
    dbms_output.put_line('current_ix incremented to ' || g_curr_token_ix); 
  END IF;
END pr_increment_token_ix;
  PROCEDURE parse_main(p_token_stream IN lexer_token_col, po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
  BEGIN
    g_tokens := p_token_stream;
    g_curr_token_ix := 1;
    po_success := FALSE;

    IF NOT po_success THEN
      g_curr_token_ix := 1; -- Reset stream index for next entry option
      pr_index_by_type(po_success);
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := 1; -- Reset stream index for next entry option
      pr_ref_cursor_type_definition(po_success);
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := 1; -- Reset stream index for next entry option
      pr_variable_declaration(po_success);
    END IF;
  END parse_main;

END MINI_PARSER;
/
