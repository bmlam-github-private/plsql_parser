CREATE OR REPLACE FUNCTION f_gen_table_mockups (
    p_table_name IN VARCHAR2
) RETURN CLOB
AS
    l_table_name   VARCHAR2(128);
    l_rec_type     VARCHAR2(128);
    l_col_type     VARCHAR2(128);
    l_func_name    VARCHAR2(128);

    l_cols         CLOB;
    l_params       CLOB;

    l_result       CLOB;
BEGIN
    l_table_name := UPPER(p_table_name);

    l_rec_type  := LOWER(l_table_name) || '_rec';
    l_col_type  := LOWER(l_table_name) || '_col';
    l_func_name := 'fn_' || LOWER(l_table_name);

    -- ==========================================================
    -- Build object type column list
    -- ==========================================================
    SELECT LISTAGG(
               '    ' || LOWER(column_name) || ' ' ||
               CASE
                   WHEN data_type IN ('VARCHAR2', 'CHAR', 'NCHAR', 'NVARCHAR2')
                       THEN data_type || '(' || data_length || ')'

                   WHEN data_type = 'NUMBER'
                       THEN CASE
                                WHEN data_precision IS NOT NULL THEN
                                     'NUMBER(' ||
                                     data_precision ||
                                     CASE
                                         WHEN data_scale IS NOT NULL
                                             THEN ',' || data_scale
                                     END ||
                                     ')'
                                ELSE
                                     'NUMBER'
                            END

                   WHEN data_type = 'RAW'
                       THEN 'RAW(' || data_length || ')'

                   ELSE data_type
               END,
               ',' || CHR(10)
           ) WITHIN GROUP (ORDER BY column_id)
    INTO l_cols
    FROM user_tab_columns
    WHERE table_name = l_table_name;

    -- ==========================================================
    -- Build constructor parameter list
    -- ==========================================================
    SELECT LISTAGG(
               '                r.' || LOWER(column_name),
               ',' || CHR(10)
           ) WITHIN GROUP (ORDER BY column_id)
    INTO l_params
    FROM user_tab_columns
    WHERE table_name = l_table_name;

    -- ==========================================================
    -- Assemble generated code
    -- ==========================================================
    l_result :=
           '-- =========================================' || CHR(10)
        || '-- RECORD TYPE' || CHR(10)
        || '-- =========================================' || CHR(10)
        || CHR(10)

        || 'CREATE OR REPLACE TYPE ' || l_rec_type || ' AS OBJECT (' || CHR(10)
        || l_cols || CHR(10)
        || ');' || CHR(10)
        || '/' || CHR(10)
        || CHR(10)

        || '-- =========================================' || CHR(10)
        || '-- COLLECTION TYPE' || CHR(10)
        || '-- =========================================' || CHR(10)
        || CHR(10)

        || 'CREATE OR REPLACE TYPE ' || l_col_type
        || ' AS TABLE OF ' || l_rec_type || ';' || CHR(10)
        || '/' || CHR(10)
        || CHR(10)

        || '-- =========================================' || CHR(10)
        || '-- PIPELINED FUNCTION STUB' || CHR(10)
        || '-- =========================================' || CHR(10)
        || CHR(10)

        || 'CREATE OR REPLACE FUNCTION ' || l_func_name || CHR(10)
        || '    RETURN ' || l_col_type || ' PIPELINED' || CHR(10)
        || 'AS' || CHR(10)
        || 'BEGIN' || CHR(10)
        || CHR(10)

        || '    FOR r IN (SELECT * FROM '
        || LOWER(l_table_name) || ') LOOP' || CHR(10)

        || '        PIPE ROW (' || l_rec_type || '(' || CHR(10)
        || l_params || CHR(10)
        || '        ));' || CHR(10)

        || '    END LOOP;' || CHR(10)
        || CHR(10)

        || '    RETURN;' || CHR(10)
        || 'END;' || CHR(10)
        || '/' || CHR(10);

    RETURN l_result;
END;
/