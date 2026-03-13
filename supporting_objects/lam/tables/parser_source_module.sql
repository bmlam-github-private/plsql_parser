CREATE TABLE parser_source_module (
     id NUMBER GENERATED ALWAYS AS IDENTITY 
    ,short_key      VARCHAR2(100 CHAR)  NOT NULL 
    ,description    VARCHAR2(2000 CHAR)
    ,source_text    CLOB
);

ALTER TABLE parser_source_module ADD PRIMARY KEY (id)
;

ALTER TABLE parser_source_module ADD UNIQUE (short_key)
;
