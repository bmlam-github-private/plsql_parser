SET SERVEROUTPUT ON SIZE UNLIMITED;

DECLARE
    v_results ebnf_parser_pkg.parser_grammar_rule_simple_col;

    PROCEDURE print_test_case(p_title VARCHAR2, p_lhs VARCHAR2, p_rhs VARCHAR2) IS
    BEGIN
        DBMS_OUTPUT.PUT_LINE('======================================================================');
        DBMS_OUTPUT.PUT_LINE('TEST: ' || p_title);
        DBMS_OUTPUT.PUT_LINE('INPUT: ' || p_lhs || ' ::= ' || p_rhs);
        DBMS_OUTPUT.PUT_LINE('----------------------------------------------------------------------');

        v_results := ebnf_parser_pkg.fn_1_ebnf_to_simple(p_lhs, p_rhs);

        FOR i IN 1..v_results.COUNT LOOP
            DBMS_OUTPUT.PUT_LINE(
                RPAD(v_results(i).lhs, 28) || ' ::= ' || v_results(i).rhs
            );
        END LOOP;
        DBMS_OUTPUT.PUT_LINE('');
    END print_test_case;

BEGIN
    -- Test Case 1: Optional brackets [...]
    print_test_case(
        p_title => 'Optional Brackets',
        p_lhs   => '<relational_not>',
        p_rhs   => '[ "NOT" ] <relational_expr>'
    );

    -- Test Case 2: Repetition asterisk {...}*
    print_test_case(
        p_title => 'Repetition Asterisk',
        p_lhs   => '<additive_expr>',
        p_rhs   => '<multiplicative_expr> { ( "+" | "-" ) <multiplicative_expr> }*'
    );

    -- Test Case 3: Plain curly brackets {...} without asterisk (Option B)
    print_test_case(
        p_title => 'Plain Curly Brackets (Option B Inline Grouping)',
        p_lhs   => '<relational_expr>',
        p_rhs   => '<additive_expr> { "=" | "!=" } <additive_expr>'
    );

    -- Test Case 4: Complex Nested Rule
    print_test_case(
        p_title => 'Complex Combination with Optionals and Repetition',
        p_lhs   => '<like_op>',
        p_rhs   => '[ "NOT" ] "LIKE" <additive_expr> [ "ESCAPE" <additive_expr> ]'
    );
END;
/