create or replace PACKAGE BODY PKG_TEST_SIMPLE_EXPRESSION AS

  PROCEDURE pr_expression_1(po_success OUT BOOLEAN);
  PROCEDURE pr_expression_2(po_success OUT BOOLEAN);
  PROCEDURE pr_expression_3(po_success OUT BOOLEAN);
  PROCEDURE pr_factor_1(po_success OUT BOOLEAN);
  PROCEDURE pr_factor_2(po_success OUT BOOLEAN);
  PROCEDURE pr_factor_3(po_success OUT BOOLEAN);
  PROCEDURE pr_primary_1(po_success OUT BOOLEAN);
  PROCEDURE pr_primary_2(po_success OUT BOOLEAN);
  PROCEDURE pr_primary_3(po_success OUT BOOLEAN);
  PROCEDURE pr_primary_4(po_success OUT BOOLEAN);
  PROCEDURE pr_primary_5(po_success OUT BOOLEAN);
  PROCEDURE pr_primary_6(po_success OUT BOOLEAN);
  PROCEDURE pr_term_1(po_success OUT BOOLEAN);
  PROCEDURE pr_term_2(po_success OUT BOOLEAN);
  PROCEDURE pr_term_3(po_success OUT BOOLEAN);

  PROCEDURE pr_expression(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := FALSE;
    IF NOT po_success THEN
      pr_expression_1(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      pr_expression_2(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      pr_expression_3(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END pr_expression;

  PROCEDURE pr_expression_1(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := TRUE;
    -- Position 1: Symbol term
    IF po_success THEN
      pr_term(po_success);
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_expression_1;

  PROCEDURE pr_expression_2(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := TRUE;
    -- Position 1: Symbol expression
    IF po_success THEN
      pr_expression(po_success);
    END IF;
    -- Position 2: Symbol "+"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '"+"' )  THEN
        pr_increment_token_ix( '"+"' );
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 3: Symbol term
    IF po_success THEN
      pr_term(po_success);
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_expression_2;

  PROCEDURE pr_expression_3(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := TRUE;
    -- Position 1: Symbol expression
    IF po_success THEN
      pr_expression(po_success);
    END IF;
    -- Position 2: Symbol "-"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '"-"' )  THEN
        pr_increment_token_ix( '"-"' );
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 3: Symbol term
    IF po_success THEN
      pr_term(po_success);
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_expression_3;

  PROCEDURE pr_factor(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := FALSE;
    IF NOT po_success THEN
      pr_factor_1(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      pr_factor_2(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      pr_factor_3(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END pr_factor;

  PROCEDURE pr_factor_1(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := TRUE;
    -- Position 1: Symbol "+"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '"+"' )  THEN
        pr_increment_token_ix( '"+"' );
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 2: Symbol primary
    IF po_success THEN
      pr_primary(po_success);
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_factor_1;

  PROCEDURE pr_factor_2(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := TRUE;
    -- Position 1: Symbol "-"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '"-"' )  THEN
        pr_increment_token_ix( '"-"' );
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 2: Symbol primary
    IF po_success THEN
      pr_primary(po_success);
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_factor_2;

  PROCEDURE pr_factor_3(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := TRUE;
    -- Position 1: Symbol primary
    IF po_success THEN
      pr_primary(po_success);
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_factor_3;

  PROCEDURE pr_primary(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := FALSE;
    IF NOT po_success THEN
      pr_primary_1(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      pr_primary_2(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      pr_primary_3(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      pr_primary_4(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      pr_primary_5(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      pr_primary_6(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END pr_primary;

  PROCEDURE pr_primary_1(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := TRUE;
    -- Position 1: Symbol number_literal
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( 'number_literal' )  THEN
        pr_increment_token_ix( 'number_literal' );
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_primary_1;

  PROCEDURE pr_primary_2(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := TRUE;
    -- Position 1: Symbol identifier
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( 'identifier' )  THEN
        pr_increment_token_ix( 'identifier' );
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_primary_2;

  PROCEDURE pr_primary_3(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := TRUE;
    -- Position 1: Symbol "("
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '"("' )  THEN
        pr_increment_token_ix( '"("' );
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 2: Symbol expression
    IF po_success THEN
      pr_expression(po_success);
    END IF;
    -- Position 3: Symbol ")"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '")"' )  THEN
        pr_increment_token_ix( '")"' );
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 4: Symbol ;
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( ';' )  THEN
        pr_increment_token_ix( ';' );
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 5: Symbol expression
    IF po_success THEN
      pr_expression(po_success);
    END IF;
    -- Position 6: Symbol :
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( ':' )  THEN
        pr_increment_token_ix( ':' );
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 7: Symbol :
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( ':' )  THEN
        pr_increment_token_ix( ':' );
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 8: Symbol =
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '=' )  THEN
        pr_increment_token_ix( '=' );
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 9: Symbol term
    IF po_success THEN
      pr_term(po_success);
    END IF;
    -- Position 10: Symbol {
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '{' )  THEN
        pr_increment_token_ix( '{' );
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 11: Symbol "+"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '"+"' )  THEN
        pr_increment_token_ix( '"+"' );
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 12: Symbol term
    IF po_success THEN
      pr_term(po_success);
    END IF;
    -- Position 13: Symbol }
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '}' )  THEN
        pr_increment_token_ix( '}' );
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_primary_3;

  PROCEDURE pr_primary_4(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := TRUE;
    -- Position 1: Symbol number_literal
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( 'number_literal' )  THEN
        pr_increment_token_ix( 'number_literal' );
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_primary_4;

  PROCEDURE pr_primary_5(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := TRUE;
    -- Position 1: Symbol identifier
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( 'identifier' )  THEN
        pr_increment_token_ix( 'identifier' );
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_primary_5;

  PROCEDURE pr_primary_6(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := TRUE;
    -- Position 1: Symbol "("
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '"("' )  THEN
        pr_increment_token_ix( '"("' );
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 2: Symbol expression
    IF po_success THEN
      pr_expression(po_success);
    END IF;
    -- Position 3: Symbol ")"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '")"' )  THEN
        pr_increment_token_ix( '")"' );
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 4: Symbol ;
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( ';' )  THEN
        pr_increment_token_ix( ';' );
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 5: Symbol expression
    IF po_success THEN
      pr_expression(po_success);
    END IF;
    -- Position 6: Symbol :
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( ':' )  THEN
        pr_increment_token_ix( ':' );
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 7: Symbol :
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( ':' )  THEN
        pr_increment_token_ix( ':' );
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 8: Symbol =
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '=' )  THEN
        pr_increment_token_ix( '=' );
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 9: Symbol term
    IF po_success THEN
      pr_term(po_success);
    END IF;
    -- Position 10: Symbol {
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '{' )  THEN
        pr_increment_token_ix( '{' );
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 11: Symbol "-"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '"-"' )  THEN
        pr_increment_token_ix( '"-"' );
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 12: Symbol term
    IF po_success THEN
      pr_term(po_success);
    END IF;
    -- Position 13: Symbol }
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '}' )  THEN
        pr_increment_token_ix( '}' );
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_primary_6;

  PROCEDURE pr_term(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := FALSE;
    IF NOT po_success THEN
      pr_term_1(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      pr_term_2(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
    IF NOT po_success THEN
      pr_term_3(po_success);
      IF NOT po_success THEN g_curr_token_ix := l_entry_idx; END IF;
    END IF;
  END pr_term;

  PROCEDURE pr_term_1(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := TRUE;
    -- Position 1: Symbol factor
    IF po_success THEN
      pr_factor(po_success);
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_term_1;

  PROCEDURE pr_term_2(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := TRUE;
    -- Position 1: Symbol term
    IF po_success THEN
      pr_term(po_success);
    END IF;
    -- Position 2: Symbol "*"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '"*"' )  THEN
        pr_increment_token_ix( '"*"' );
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 3: Symbol factor
    IF po_success THEN
      pr_factor(po_success);
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_term_2;

  PROCEDURE pr_term_3(po_success OUT BOOLEAN) IS
    l_breadcrumb breadcrumb:=  breadcrumb();
    l_entry_idx NUMBER := g_curr_token_ix;
  BEGIN
    po_success := TRUE;
    -- Position 1: Symbol term
    IF po_success THEN
      pr_term(po_success);
    END IF;
    -- Position 2: Symbol "/"
    IF po_success THEN
      IF g_tokens.EXISTS(g_curr_token_ix) AND g_tokens(g_curr_token_ix).compare_symbol ( '"/"' )  THEN
        pr_increment_token_ix( '"/"' );
      ELSE
        po_success := FALSE;
      END IF;
    END IF;
    -- Position 3: Symbol factor
    IF po_success THEN
      pr_factor(po_success);
    END IF;
    IF NOT po_success THEN
      g_curr_token_ix := l_entry_idx;
    END IF;
  END pr_term_3;

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

      pr_expression(po_success);
  END parse_main;

END PKG_TEST_SIMPLE_EXPRESSION;

