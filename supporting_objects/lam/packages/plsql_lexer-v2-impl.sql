CREATE OR REPLACE PACKAGE BODY plsql_lexer AS

   FUNCTION tokenize_code(p_code IN CLOB) 
   RETURN parser_token_col PIPELINED 
   IS
      v_len          PLS_INTEGER;
      v_idx          PLS_INTEGER := 1;
      v_seq          NUMBER := 1;
      
      -- State tracking variables
      v_char         VARCHAR2(4 CHAR);
      v_next         VARCHAR2(4 CHAR);
      v_next2        VARCHAR2(4 CHAR);
      
      -- Buffer variables
      v_tok_type     VARCHAR2(30);
      v_tok_buf      CLOB;
      v_buf_len      NUMBER := 0;
      
      -- Q-quote helper variables
      v_q_delim      VARCHAR2(1 CHAR);
      v_q_close      VARCHAR2(1 CHAR);

      -- Helper to flush the current token buffer to the pipeline
      FUNCTION consume_token 
	  RETURN parser_token_rec
	  IS
		v_rec parser_token_rec;
      BEGIN
         IF v_buf_len > 0 THEN
            v_rec := parser_token_rec(v_seq, v_tok_type, v_buf_len, NULL, NULL);
            IF v_buf_len <= 4000 THEN
               v_rec.tok_text_normal := DBMS_LOB.SUBSTR(v_tok_buf, v_buf_len, 1);
            ELSE
               v_rec.tok_text_long := v_tok_buf;
            END IF;
            
            --PIPE ROW(v_rec);
            v_seq := v_seq + 1;
            
            -- Reset buffer
            DBMS_LOB.CREATETEMPORARY(v_tok_buf, TRUE);
            v_buf_len := 0;
         END IF;
		 RETURN v_rec ;
      END consume_token;

      -- Helper to add character to the active token buffer
      PROCEDURE append_char(p_ch IN VARCHAR2) IS
      BEGIN
         DBMS_LOB.WRITEAPPEND(v_tok_buf, LENGTH(p_ch), p_ch);
         v_buf_len := v_buf_len + LENGTH(p_ch);
      END append_char;

   BEGIN
      IF p_code IS NULL THEN
         RETURN;
      END IF;

      DBMS_LOB.CREATETEMPORARY(v_tok_buf, TRUE);
      v_len := DBMS_LOB.GETLENGTH(p_code);

      WHILE v_idx <= v_len LOOP
         v_char := DBMS_LOB.SUBSTR(p_code, 1, v_idx);
         v_next := CASE WHEN v_idx + 1 <= v_len THEN DBMS_LOB.SUBSTR(p_code, 1, v_idx + 1) ELSE NULL END;
         
         -----------------------------------------------------------------------
         -- STATE: MULTI-LINE COMMENT (/* ... */)
         -----------------------------------------------------------------------
         IF v_char = '/' AND v_next = '*' THEN
            pipe row ( consume_token );
            v_tok_type := 'COMMENT';
            append_char(v_char);
            append_char(v_next);
            v_idx := v_idx + 2;
            
            WHILE v_idx <= v_len LOOP
               v_char := DBMS_LOB.SUBSTR(p_code, 1, v_idx);
               v_next := CASE WHEN v_idx + 1 <= v_len THEN DBMS_LOB.SUBSTR(p_code, 1, v_idx + 1) ELSE NULL END;
               append_char(v_char);
               IF v_char = '*' AND v_next = '/' THEN
                  append_char(v_next);
                  v_idx := v_idx + 2;
                  EXIT;
               END IF;
               v_idx := v_idx + 1;
            END LOOP;
            pipe row ( consume_token );
            CONTINUE;

         -----------------------------------------------------------------------
         -- STATE: SINGLE-LINE COMMENT (-- ...)
         -----------------------------------------------------------------------
         ELSIF v_char = '-' AND v_next = '-' THEN
            pipe row ( consume_token );
            v_tok_type := 'COMMENT';
            append_char(v_char);
            append_char(v_next);
            v_idx := v_idx + 2;
            
            WHILE v_idx <= v_len LOOP
               v_char := DBMS_LOB.SUBSTR(p_code, 1, v_idx);
               IF v_char = CHR(10) OR v_char = CHR(13) THEN
                  -- Stop right before the newline token so it can be parsed as whitespace
                  EXIT;
               END IF;
               append_char(v_char);
               v_idx := v_idx + 1;
            END LOOP;
            pipe row ( consume_token );
            CONTINUE;

         -----------------------------------------------------------------------
         -- STATE: Q-QUOTE STRING LITERAL (q'[...]' or q'!...!')
         -----------------------------------------------------------------------
         ELSIF (v_char = 'q' OR v_char = 'Q') AND v_next = '''' THEN
            v_next2 := CASE WHEN v_idx + 2 <= v_len THEN DBMS_LOB.SUBSTR(p_code, 1, v_idx + 2) ELSE NULL END;
            IF v_next2 IS NOT NULL THEN
               pipe row ( consume_token );
               v_tok_type := 'STRING_LITERAL';
               append_char(v_char);  -- 'q'
               append_char(v_next);  -- ''''
               append_char(v_next2); -- delimiter
               
               v_q_delim := v_next2;
               v_q_close := CASE v_q_delim 
                              WHEN '[' THEN ']'
                              WHEN '{' THEN '}'
                              WHEN '(' THEN ')'
                              WHEN '<' THEN '>'
                              ELSE v_q_delim 
                            END;
               v_idx := v_idx + 3;
               
               WHILE v_idx <= v_len LOOP
                  v_char := DBMS_LOB.SUBSTR(p_code, 1, v_idx);
                  v_next := CASE WHEN v_idx + 1 <= v_len THEN DBMS_LOB.SUBSTR(p_code, 1, v_idx + 1) ELSE NULL END;
                  append_char(v_char);
                  
                  IF v_char = v_q_close AND v_next = '''' THEN
                     append_char(v_next);
                     v_idx := v_idx + 2;
                     EXIT;
                  END IF;
                  v_idx := v_idx + 1;
               END LOOP;
               pipe row ( consume_token );
               CONTINUE;
            END IF;

         -----------------------------------------------------------------------
         -- STATE: STANDARD STRING LITERAL ('...')
         -----------------------------------------------------------------------
         ELSIF v_char = '''' THEN
            pipe row ( consume_token );
            v_tok_type := 'STRING_LITERAL';
            append_char(v_char);
            v_idx := v_idx + 1;
            
            WHILE v_idx <= v_len LOOP
               v_char := DBMS_LOB.SUBSTR(p_code, 1, v_idx);
               v_next := CASE WHEN v_idx + 1 <= v_len THEN DBMS_LOB.SUBSTR(p_code, 1, v_idx + 1) ELSE NULL END;
               append_char(v_char);
               
               -- Handle escaped apostrophe ('')
               IF v_char = '''' AND v_next = '''' THEN
                  append_char(v_next);
                  v_idx := v_idx + 2;
                  CONTINUE;
               -- End of standard string
               ELSIF v_char = '''' THEN
                  v_idx := v_idx + 1;
                  EXIT;
               END IF;
               v_idx := v_idx + 1;
            END LOOP;
            pipe row ( consume_token );
            CONTINUE;

         -----------------------------------------------------------------------
         -- STATE: MULTI-CHARACTER & SINGLE SPECIAL SIGN CHARACTERS
         -----------------------------------------------------------------------
         ELSIF INSTR(':=<>!+-*/^|&.(),[];', v_char) > 0 THEN
            pipe row ( consume_token );
            v_tok_type := 'SPECIAL_CHARACTER';
            
            -- Check for known compound operators: :=, !=, <>, <=, >=, =>, ||, **
            IF (v_char = ':' AND v_next = '=') OR
               (v_char = '!' AND v_next = '=') OR
               (v_char = '<' AND v_next = '>') OR
               (v_char = '<' AND v_next = '=') OR
               (v_char = '>' AND v_next = '=') OR
               (v_char = '=' AND v_next = '>') OR
               (v_char = '|' AND v_next = '|') OR
               (v_char = '*' AND v_next = '*') THEN
               append_char(v_char);
               append_char(v_next);
               v_idx := v_idx + 2;
            ELSE
               append_char(v_char);
               v_idx := v_idx + 1;
            END IF;
            pipe row ( consume_token );
            CONTINUE;

         -----------------------------------------------------------------------
         -- STATE: NUMERIC LITERALS
         -----------------------------------------------------------------------
         ELSIF v_char >= '0' AND v_char <= '9' THEN
            IF v_tok_type <> 'NUMBER_LITERAL' THEN
               pipe row ( consume_token );
               v_tok_type := 'NUMBER_LITERAL';
            END IF;
            append_char(v_char);
            v_idx := v_idx + 1;
            CONTINUE;

         -----------------------------------------------------------------------
         -- STATE: WHITESPACE (spaces, tabs, newlines)
         -----------------------------------------------------------------------
         ELSIF v_char = ' ' OR v_char = CHR(9) OR v_char = CHR(10) OR v_char = CHR(13) THEN
            IF v_tok_type <> 'WHITESPACE' THEN
               pipe row ( consume_token );
               v_tok_type := 'WHITESPACE';
            END IF;
            append_char(v_char);
            v_idx := v_idx + 1;
            CONTINUE;

         -----------------------------------------------------------------------
         -- STATE: WORDS (Identifiers or Keywords)
         -----------------------------------------------------------------------
         ELSE
            -- PL/SQL Identifiers can contain alphanumeric characters, _, $, and #
            IF v_tok_type <> 'WORD' THEN
               pipe row ( consume_token );
               v_tok_type := 'WORD';
            END IF;
            append_char(v_char);
            v_idx := v_idx + 1;
            CONTINUE;
         END IF;

      END LOOP;

      -- Flush any remaining text left in the buffer
      pipe row ( consume_token );
      
      DBMS_LOB.FREETEMPORARY(v_tok_buf);
      RETURN;
   END tokenize_code;

END;
/