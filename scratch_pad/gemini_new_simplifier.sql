CREATE OR REPLACE PACKAGE ebnf_parser_pkg AS
    TYPE parser_grammar_rule_simple_rec IS RECORD (
        lhs         VARCHAR2(1000),
        rhs         VARCHAR2(4000),
        lhs_root    VARCHAR2(1000),
        subrule_no  NUMBER,
        source      VARCHAR2(100)
    );

    TYPE parser_grammar_rule_simple_col IS TABLE OF parser_grammar_rule_simple_rec;

    FUNCTION fn_1_ebnf_to_simple (
        p_lhs    IN VARCHAR2,
        p_rhs    IN VARCHAR2,
        p_source IN VARCHAR2 DEFAULT 'EBNF'
    ) RETURN parser_grammar_rule_simple_col;
END ebnf_parser_pkg;
/


















































































CREATE OR REPLACE PACKAGE BODY ebnf_parser_pkg AS

    C_EPSILON CONSTANT VARCHAR2(10) := 'EPSILON';

    PROCEDURE push_row (
        p_rec      IN parser_grammar_rule_simple_rec,
        pio_rows   IN OUT NOCOPY parser_grammar_rule_simple_col
    ) IS
    BEGIN
        pio_rows.EXTEND;
        pio_rows(pio_rows.LAST) := p_rec;
    END push_row;

    FUNCTION f_trim_angle_brackets (p_str VARCHAR2) RETURN VARCHAR2 IS
    BEGIN
        IF SUBSTR(p_str, 1, 1) = '<' AND SUBSTR(p_str, -1) = '>' THEN
            RETURN SUBSTR(p_str, 2, LENGTH(p_str) - 2);
        ELSE
            RETURN p_str;
        END IF;
    END f_trim_angle_brackets;

    FUNCTION fn_1_ebnf_to_simple (
        p_lhs    IN VARCHAR2,
        p_rhs    IN VARCHAR2,
        p_source IN VARCHAR2 DEFAULT 'EBNF'
    ) RETURN parser_grammar_rule_simple_col IS
        v_return parser_grammar_rule_simple_col := parser_grammar_rule_simple_col();

        TYPE token_list IS TABLE OF VARCHAR2(1000) INDEX BY PLS_INTEGER;

        TYPE rule_rec IS RECORD (
            lhs    VARCHAR2(1000),
            tokens token_list
        );
        TYPE rule_table IS TABLE OF rule_rec;

        v_working_rules  rule_table := rule_table();
        v_final_rules    rule_table := rule_table();

        v_current_idx    NUMBER := 1;
        v_suffix_ix      NUMBER := 0;
        v_rule_seq       NUMBER := 1;

        -- Helper function to split input into lexical tokens
        FUNCTION tokenize(p_str VARCHAR2) RETURN token_list IS
            v_tokens  token_list;
            v_idx     NUMBER := 1;
            v_pattern VARCHAR2(100) := '(<[^>]+>|"[^"]+"|[a-zA-Z0-9_]+|\[|\]|\{|\}|\(|\)|\*|\||[^[:space:]])';
            v_match   VARCHAR2(1000);
        BEGIN
            LOOP
                v_match := REGEXP_SUBSTR(p_str, v_pattern, 1, v_idx);
                EXIT WHEN v_match IS NULL;
                v_tokens(v_idx) := v_match;
                v_idx := v_idx + 1;
            END LOOP;
            RETURN v_tokens;
        END tokenize;

        -- PHASE 1: Extract brackets [], {}*, and convert plain {} to ()
        PROCEDURE process_token_brackets(pio_tokens IN OUT NOCOPY token_list) IS
            v_open_idx       NUMBER := 0;
            v_close_idx      NUMBER := 0;
            v_bracket_type   VARCHAR2(1);
            v_level          NUMBER := 0;
            v_inner_tokens   token_list;
            v_new_rule_name  VARCHAR2(100);
            v_new_tokens     token_list;
            v_new_idx        NUMBER := 1;
            v_skip_until     NUMBER := 0;
        BEGIN
            -- Find first outermost bracket block
            FOR i IN 1..pio_tokens.COUNT LOOP
                IF pio_tokens(i) IN ('[', '{') AND v_level = 0 THEN
                    v_open_idx := i;
                    v_bracket_type := pio_tokens(i);
                    v_level := 1;
                ELSIF pio_tokens(i) IN ('[', '{') THEN
                    v_level := v_level + 1;
                ELSIF pio_tokens(i) IN (']', '}') THEN
                    v_level := v_level - 1;
                    IF v_level = 0 AND pio_tokens(i) = CASE v_bracket_type WHEN '[' THEN ']' WHEN '{' THEN '}' END THEN
                        v_close_idx := i;
                        EXIT;
                    END IF;
                END IF;
            END LOOP;

            -- Outermost bracket isolated
            IF v_open_idx > 0 THEN
                FOR i IN (v_open_idx + 1)..(v_close_idx - 1) LOOP
                    v_inner_tokens(v_inner_tokens.COUNT + 1) := pio_tokens(i);
                END LOOP;

                v_suffix_ix := v_suffix_ix + 1;

                IF v_bracket_type = '[' THEN
                    -- Optional construct [ A ] -> <opt_N> ::= ( A | epsilon )
                    v_new_rule_name := '<' || f_trim_angle_brackets(p_lhs) || '_opt_' || v_suffix_ix || '>';

                    v_working_rules.EXTEND;
                    v_working_rules(v_working_rules.LAST).lhs := v_new_rule_name;

                    v_working_rules(v_working_rules.LAST).tokens(1) := '(';
                    FOR i IN 1..v_inner_tokens.COUNT LOOP
                        v_working_rules(v_working_rules.LAST).tokens(i+1) := v_inner_tokens(i);
                    END LOOP;
                    v_working_rules(v_working_rules.LAST).tokens(v_inner_tokens.COUNT + 2) := '|';
                    v_working_rules(v_working_rules.LAST).tokens(v_inner_tokens.COUNT + 3) := C_EPSILON;
                    v_working_rules(v_working_rules.LAST).tokens(v_inner_tokens.COUNT + 4) := ')';

                    v_skip_until := v_close_idx;

                ELSIF v_bracket_type = '{' THEN
                    IF pio_tokens.EXISTS(v_close_idx + 1) AND pio_tokens(v_close_idx + 1) = '*' THEN
                        -- Repetition construct { A }* -> <rep_N> ::= ( A <rep_N> | epsilon )
                        v_new_rule_name := '<' || f_trim_angle_brackets(p_lhs) || '_rep_' || v_suffix_ix || '>';

                        v_working_rules.EXTEND;
                        v_working_rules(v_working_rules.LAST).lhs := v_new_rule_name;

                        v_working_rules(v_working_rules.LAST).tokens(1) := '(';
                        FOR i IN 1..v_inner_tokens.COUNT LOOP
                            v_working_rules(v_working_rules.LAST).tokens(i+1) := v_inner_tokens(i);
                        END LOOP;

                        v_working_rules(v_working_rules.LAST).tokens(v_inner_tokens.COUNT + 2) := v_new_rule_name;
                        v_working_rules(v_working_rules.LAST).tokens(v_inner_tokens.COUNT + 3) := '|';
                        v_working_rules(v_working_rules.LAST).tokens(v_inner_tokens.COUNT + 4) := C_EPSILON;
                        v_working_rules(v_working_rules.LAST).tokens(v_inner_tokens.COUNT + 5) := ')';

                        v_skip_until := v_close_idx + 1;
                    ELSE
                        -- Option B: Grouping { A } without '*' -> convert { } to ( ) directly inline
                        v_new_tokens.DELETE;
                        v_new_idx := 1;
                        FOR i IN 1..pio_tokens.COUNT LOOP
                            IF i = v_open_idx THEN
                                v_new_tokens(v_new_idx) := '(';
                            ELSIF i = v_close_idx THEN
                                v_new_tokens(v_new_idx) := ')';
                            ELSE
                                v_new_tokens(v_new_idx) := pio_tokens(i);
                            END IF;
                            v_new_idx := v_new_idx + 1;
                        END LOOP;
                        pio_tokens := v_new_tokens;

                        process_token_brackets(pio_tokens);
                        RETURN;
                    END IF;
                END IF;

                -- Re-stitch parent rule tokens with inserted sub-rule name
                v_new_tokens.DELETE;
                v_new_idx := 1;
                FOR i IN 1..pio_tokens.COUNT LOOP
                    IF i < v_open_idx THEN
                        v_new_tokens(v_new_idx) := pio_tokens(i);
                        v_new_idx := v_new_idx + 1;
                    ELSIF i = v_open_idx THEN
                        v_new_tokens(v_new_idx) := v_new_rule_name;
                        v_new_idx := v_new_idx + 1;
                    ELSIF i > v_skip_until THEN
                        v_new_tokens(v_new_idx) := pio_tokens(i);
                        v_new_idx := v_new_idx + 1;
                    END IF;
                END LOOP;

                pio_tokens := v_new_tokens;

                -- Recurse for nested bracket structures
                process_token_brackets(pio_tokens);
            END IF;
        END process_token_brackets;

        -- PHASE 2: Cross-multiply alternatives '|' and parenthesized groups '( )'
        PROCEDURE flatten_alternatives(p_lhs VARCHAR2, pio_tokens token_list) IS
            v_open_group  NUMBER := 0;
            v_close_group NUMBER := 0;
            v_level       NUMBER := 0;

            TYPE choice_list IS TABLE OF token_list INDEX BY PLS_INTEGER;
            v_choices     choice_list;
            v_current_ch  NUMBER := 1;

            v_prefix      token_list;
            v_suffix      token_list;
            v_combined    token_list;
        BEGIN
            -- Find first outermost '(' ... ')' group
            FOR i IN 1..pio_tokens.COUNT LOOP
                IF pio_tokens(i) = '(' AND v_level = 0 THEN
                    v_open_group := i;
                    v_level := 1;
                ELSIF pio_tokens(i) = '(' THEN
                    v_level := v_level + 1;
                ELSIF pio_tokens(i) = ')' THEN
                    v_level := v_level - 1;
                    IF v_level = 0 THEN
                        v_close_group := i;
                        EXIT;
                    END IF;
                END IF;
            END LOOP;

            -- Explicit group found
            IF v_open_group > 0 THEN
                FOR i IN 1..(v_open_group - 1) LOOP
                    v_prefix(v_prefix.COUNT + 1) := pio_tokens(i);
                END LOOP;
                FOR i IN (v_close_group + 1)..pio_tokens.COUNT LOOP
                    v_suffix(v_suffix.COUNT + 1) := pio_tokens(i);
                END LOOP;

                v_level := 0;
                v_choices(1) := token_list();
                FOR i IN (v_open_group + 1)..(v_close_group - 1) LOOP
                    IF pio_tokens(i) = '(' THEN v_level := v_level + 1; END IF;
                    IF pio_tokens(i) = ')' THEN v_level := v_level - 1; END IF;

                    IF pio_tokens(i) = '|' AND v_level = 0 THEN
                        v_current_ch := v_current_ch + 1;
                        v_choices(v_current_ch) := token_list();
                    ELSE
                        v_choices(v_current_ch)(v_choices(v_current_ch).COUNT + 1) := pio_tokens(i);
                    END IF;
                END LOOP;

                -- Multiply prefix + choice + suffix
                FOR c IN 1..v_choices.COUNT LOOP
                    v_combined := v_prefix;
                    FOR m IN 1..v_choices(c).COUNT LOOP
                        v_combined(v_combined.COUNT + 1) := v_choices(c)(m);
                    END LOOP;
                    FOR s IN 1..v_suffix.COUNT LOOP
                        v_combined(v_combined.COUNT + 1) := v_suffix(s);
                    END LOOP;

                    flatten_alternatives(p_lhs, v_combined);
                END LOOP;
                RETURN;
            END IF;

            -- Handle top-level raw pipes: A | B
            v_current_ch := 1;
            v_choices.DELETE;
            v_choices(1) := token_list();
            FOR i IN 1..pio_tokens.COUNT LOOP
                IF pio_tokens(i) = '|' THEN
                    v_current_ch := v_current_ch + 1;
                    v_choices(v_current_ch) := token_list();
                ELSE
                    v_choices(v_current_ch)(v_choices(v_current_ch).COUNT + 1) := pio_tokens(i);
                END IF;
            END LOOP;

            IF v_choices.COUNT > 1 THEN
                FOR c IN 1..v_choices.COUNT LOOP
                    flatten_alternatives(p_lhs, v_choices(c));
                END LOOP;
                RETURN;
            END IF;

            -- Final simple rule segment reached
            v_final_rules.EXTEND;
            v_final_rules(v_final_rules.LAST).lhs := p_lhs;
            v_final_rules(v_final_rules.LAST).tokens := pio_tokens;
        END flatten_alternatives;

    BEGIN
        v_working_rules.EXTEND;
        v_working_rules(v_working_rules.LAST).lhs := TRIM(p_lhs);
        v_working_rules(v_working_rules.LAST).tokens := tokenize(p_rhs);

        -- Execute Phase 1
        WHILE v_current_idx <= v_working_rules.COUNT LOOP
            process_token_brackets(v_working_rules(v_current_idx).tokens);
            v_current_idx := v_current_idx + 1;
        END LOOP;

        -- Execute Phase 2
        FOR i IN 1..v_working_rules.COUNT LOOP
            flatten_alternatives(v_working_rules(i).lhs, v_working_rules(i).tokens);
        END LOOP;

        -- Formulate output records
        FOR i IN 1..v_final_rules.COUNT LOOP
            DECLARE
                v_final_lhs  VARCHAR2(1000) := v_final_rules(i).lhs;
                v_tok_array  token_list     := v_final_rules(i).tokens;
                v_buffer_rhs VARCHAR2(4000) := '';
            BEGIN
                FOR j IN 1..v_tok_array.COUNT LOOP
                    v_buffer_rhs := v_buffer_rhs || v_tok_array(j) || ' ';
                END LOOP;

                IF TRIM(v_buffer_rhs) IS NOT NULL THEN
                    push_row(
                        parser_grammar_rule_simple_rec(
                            lhs        => v_final_lhs,
                            rhs        => TRIM(v_buffer_rhs),
                            lhs_root   => p_lhs,
                            subrule_no => v_rule_seq,
                            source     => p_source
                        ),
                        pio_rows => v_return
                    );
                    v_rule_seq := v_rule_seq + 1;
                END IF;
            END;
        END LOOP;

        RETURN v_return;
    END fn_1_ebnf_to_simple;

END ebnf_parser_pkg;
/