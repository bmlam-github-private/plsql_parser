CREATE TABLE parser_token (
     token_id       NUMBER GENERATED ALWAYS AS IDENTITY
    ,source_id      NUMBER     NOT NULL 
    ,token_type     VARCHAR2(50) NOT NULL 
    ,token_ch_cnt   NUMBER NOT NULL 
    ,token_text_normal     VARCHAR2(1000)   
    ,token_text_long       CLOB    
    ,tok_sequence   NUMBER NOT NULL 
    ,line_no        NUMBER       
    ,column_no      NUMBER     
);

ALTER TABLE parser_token ADD PRIMARY KEY (token_id)
;

ALTER TABLE parser_token ADD UNIQUE (source_id, tok_sequence )
;

ALTER TABLE parser_token ADD CONSTRAINT parser_token_type_ck1 CHECK ( token_type IN 
     ( 'COMMENT'
     , 'KEYWORD_OR_IDENT'
     , 'STMT_END_SIGN'
     , 'LE_BR_RND'
     , 'LE_BR_SQR'
     , 'NUM_LITERAL'
     , 'OPERATOR' 
     , 'RI_BR_RND' 
     , 'RI_BR_SQR' 
     , 'STR_LITERAL'
     , 'NUM_LITERAL'
     ) )
;
