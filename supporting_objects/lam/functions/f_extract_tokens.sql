CREATE OR REPLACE FUNCTION f_extract_tokens (p_sql IN CLOB)
  RETURN parser_token_col 
  PIPELINED
IS
	c_typ_keyw_or_id	CONSTANT parser_token.token_type%TYPE := 'KEYWORD_OR_IDENT';
	c_typ_comm		CONSTANT parser_token.token_type%TYPE := 'COMMENT';
    c_typ_eleM_sep  CONSTANT parser_token.token_type%TYPE := 'ELEM_SEP';
	c_typ_l_br_r	CONSTANT parser_token.token_type%TYPE := 'LE_BR_RND';
	c_typ_l_br_sq	CONSTANT parser_token.token_type%TYPE := 'LE_BR_SQR';
	c_typ_obj_qual	CONSTANT parser_token.token_type%TYPE := 'OBJ_QUALIFIER';
    c_typ_op        CONSTANT parser_token.token_type%TYPE := 'OPERATOR';
	c_typ_num_lit	CONSTANT parser_token.token_type%TYPE := 'NUM_LITERAL';
	c_typ_r_br_r	CONSTANT parser_token.token_type%TYPE := 'RI_BR_RND';
	c_typ_r_br_sq	CONSTANT parser_token.token_type%TYPE := 'RI_BR_SQR';
    c_typ_stm_e     CONSTANT parser_token.token_type%TYPE := 'STMT_END_SIGN';
	c_typ_str_lit	CONSTANT parser_token.token_type%TYPE := 'STR_LITERAL';
	--
    i        PLS_INTEGER := 1;
    len      PLS_INTEGER := DBMS_LOB.GETLENGTH(p_sql);
    ch       CHAR(1);
    v_token_seq NUMBER := 0;
    v_token_text VARCHAR2(32000 CHAR);
    -- 
    FUNCTION peek RETURN CHAR IS
    BEGIN
        IF i < len THEN
            RETURN DBMS_LOB.SUBSTR(p_sql,1,i+1);
        ELSE
            RETURN NULL;
        END IF;
    END;
    --
    FUNCTION get_token_rec  
    ( p_text VARCHAR2
     ,p_type VARCHAR2
     )
    RETURN parser_token_rec
    AS
        v_char_cnt NUMBER;
	    v_rec_tok    parser_token_rec := 
	    	parser_token_rec
	    	( tok_seq 	=> 0 
			 ,tok_type	=> p_type 
			 ,tok_char_cnt		=> 0
			 ,tok_text_normal 	=> null
			 ,tok_text_long 	=> null 
			 );
    BEGIN 
        v_char_cnt := length( p_text );
    	v_token_seq := v_token_seq + 1;
    	v_rec_tok.tok_seq      := v_token_seq;
        v_rec_tok.tok_char_cnt := v_char_cnt;
    	IF v_char_cnt  > 4000 
    	THEN
    		v_rec_tok.tok_text_long := p_text;
    	ELSE 
    		v_rec_tok.tok_text_normal := p_text;
    	END IF;
    	RETURN v_rec_tok ;
    END get_token_rec;
BEGIN

    WHILE i <= len LOOP

        ch := DBMS_LOB.SUBSTR(p_sql,1,i);

        -- skip whitespace regarding leading, trailing or interspersed 
        IF ch IN (' ', CHR(9), CHR(10), CHR(13)) THEN
            i := i + 1;
            CONTINUE;
        END IF;

        v_token_text := '';

        ------------------------------------------------------------------
        -- identifier or keyword
        ------------------------------------------------------------------
        IF REGEXP_LIKE(ch,'[A-Za-z_]') THEN
            WHILE i <= len LOOP
                ch := DBMS_LOB.SUBSTR(p_sql,1,i);
                EXIT WHEN NOT REGEXP_LIKE(ch,'[A-Za-z0-9_$#]');
                v_token_text := v_token_text || ch;
                i := i + 1;
            END LOOP;

            PIPE ROW ( get_token_rec( v_token_text, c_typ_keyw_or_id ) );
            CONTINUE;
        END IF;

        ------------------------------------------------------------------
        -- number
        ------------------------------------------------------------------
        IF ch BETWEEN '0' AND '9' THEN
            WHILE i <= len LOOP
                ch := DBMS_LOB.SUBSTR(p_sql,1,i);
                EXIT WHEN NOT (ch BETWEEN '0' AND '9' OR ch='.');
                v_token_text := v_token_text || ch;
                i := i + 1;
            END LOOP;

            PIPE ROW ( get_token_rec( v_token_text, c_typ_num_lit ) );
            CONTINUE;
        END IF;

        ------------------------------------------------------------------
        -- string literal
        ------------------------------------------------------------------
        IF ch = '''' THEN
            v_token_text := ch;
            i := i + 1;

            WHILE i <= len LOOP
                ch := DBMS_LOB.SUBSTR(p_sql,1,i);
                v_token_text := v_token_text || ch;
                i := i + 1;

                EXIT WHEN ch = ''''
                  AND DBMS_LOB.SUBSTR(p_sql,1,i) <> '''';
                  
                -- handle escaped ''
                IF ch = ''''
                   AND DBMS_LOB.SUBSTR(p_sql,1,i) = '''' THEN
                    v_token_text := v_token_text || '''';
                    i := i + 1;
                END IF;
            END LOOP;

            PIPE ROW ( get_token_rec( v_token_text, c_typ_str_lit ) );
            CONTINUE;
        END IF;

        ------------------------------------------------------------------
        -- quoted identifier
        ------------------------------------------------------------------
        IF ch = '"' THEN
            v_token_text := ch;
            i := i + 1;

            WHILE i <= len LOOP
                ch := DBMS_LOB.SUBSTR(p_sql,1,i);
                v_token_text := v_token_text || ch;
                i := i + 1;
                EXIT WHEN ch = '"';
            END LOOP;

            PIPE ROW ( get_token_rec( v_token_text, c_typ_keyw_or_id ) );
            CONTINUE;
        END IF;

        ------------------------------------------------------------------
        -- operators / punctuation
        ------------------------------------------------------------------
        v_token_text := ch;

        IF i < len THEN
            CASE 
            WHEN ch||peek IN ('<=','>=','<>','!=','||',':=') 
            THEN
                v_token_text := ch||peek;
                i := i + 2;
                PIPE ROW ( get_token_rec( v_token_text, c_typ_op ) );
                -- 
                CONTINUE; 
            WHEN ch IN ('(', ')', ',' , '[', ']', ';' , '.')
            THEN 
                i := i + 1;
                PIPE ROW ( get_token_rec( v_token_text
                    , p_type =>
                        CASE ch  
                            WHEN ';' THEN c_typ_stm_e 
                            WHEN '(' THEN c_typ_l_br_r
                            WHEN ')' THEN c_typ_r_br_r
                            WHEN ']' THEN c_typ_l_br_sq
                            WHEN ']' THEN c_typ_r_br_sq 
                            WHEN ',' THEN c_typ_elem_sep 
                            WHEN '.' THEN c_typ_obj_qual
                        END 
                    ) );
                --
                CONTINUE;
            WHEN ch IN ( '+','-', '*', '%', '@')
            THEN 
                i := i + 1;
                PIPE ROW ( get_token_rec( v_token_text, c_typ_op) );
                --
                CONTINUE;
            ELSE 
            	RAISE_APPLICATION_ERROR( -20001, 'No idea what to do with character "'||ch||'" !'); 
            END CASE;
        END IF;

        i := i + 1;		-- prevent infinite loop or FSM stucks 

    END LOOP;

    RETURN;
END;
/

