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
      
      -- Shared record container for out-of-line piping
      v_pipe_rec     parser_token_rec;
      
      -- Q-quote helper variables
      v_q_delim      VARCHAR2(1 CHAR);
      v_q_close      VARCHAR2(1 CHAR);

      -- Helper constructs the record and cleans the buffer. 
      -- Returns TRUE if a token is ready to be processed by the main body.
      FUNCTION prepare_token RETURN BOOLEAN IS
      BEGIN
         IF v_buf_len > 0 THEN
            v_pipe_rec := parser_token_rec(v_seq, v_tok_type, v_buf_len, NULL, NULL);
            IF v_buf_len <= 4000 THEN
               v_pipe_rec.tok_text_normal := DBMS_LOB.SUBSTR(v_tok_buf, v_buf_len, 1);
            ELSE
               v_pipe_rec.tok_text_long := v_tok_buf;
            END IF;
            
            v_seq := v_seq + 1;
            
            -- Reset buffer
            DBMS_LOB.CREATETEMPORARY(v_tok_buf, TRUE);
            v_buf_len := 0;
            RETURN TRUE;
         END IF;
         RETURN FALSE;
      END prepare_token;

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
            IF prepare_token THEN PIPE ROW (v_pipe_rec); END IF;
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
            IF prepare_token THEN PIPE ROW (v_pipe_rec); END IF;
            CONTINUE;

         -----------------------------------------------------------------------
         -- STATE: SINGLE-LINE COMMENT (-- ...)
         -----------------------------------------------------------------------
         ELSIF v_char = '-' AND v_next = '-' THEN
            IF prepare_token THEN PIPE ROW (v_pipe_rec); END IF;
            v_tok_type := 'COMMENT';
            append_char(v_char);
            append_char(v_next);
            v_idx := v_idx + 2;
            
            WHILE v_idx <= v_len LOOP
               v_char := DBMS_LOB.SUBSTR(p_code, 1, v_idx);
               IF v_char = CHR(10) OR v_char = CHR(13) THEN
                  EXIT;
               END IF;
               append_char(v_char);
               v_idx := v_idx + 1;
            END LOOP;
            IF prepare_token THEN PIPE ROW (v_pipe_rec); END IF;
            CONTINUE;

         -----------------------------------------------------------------------
         -- STATE: Q-QUOTE STRING LITERAL (q'[...]' or q'!...!')
         -----------------------------------------------------------------------
         ELSIF (v_char = 'q' OR v_char = 'Q') AND v_next = '''' THEN
            v_next2 := CASE WHEN v_idx + 2 <= v_len THEN DBMS_LOB.SUBSTR(p_code, 1, v_idx + 2) ELSE NULL END;
            IF v_next2 IS NOT NULL THEN
               IF prepare_token THEN PIPE ROW (v_pipe_rec); END IF;
               v_tok_type := 'STRING_LITERAL';
               append_char(v_char); 
               append_char(v_next); 
               append_char(v_next2);
               
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
               IF prepare_token THEN PIPE ROW (v_pipe_rec); END IF;
               CONTINUE;
            END IF;

         -----------------------------------------------------------------------
         -- STATE: STANDARD STRING LITERAL ('...')
         -----------------------------------------------------------------------
         ELSIF v_char = '''' THEN
            IF prepare_token THEN PIPE ROW (v_pipe_rec); END IF;
            v_tok_type := 'STRING_LITERAL';
            append_char(v_char);
            v_idx := v_idx + 1;
            
            WHILE v_idx <= v_len LOOP
               v_char := DBMS_LOB.SUBSTR(p_code, 1, v_idx);
               v_next := CASE WHEN v_idx + 1 <= v_len THEN DBMS_LOB.SUBSTR(p_code, 1, v_idx + 1) ELSE NULL END;
               append_char(v_char);
               
               IF v_char = '''' AND v_next = '''' THEN
                  append_char(v_next);
                  v_idx := v_idx + 2;
                  CONTINUE;
               ELSIF v_char = '''' THEN
                  v_idx := v_idx + 1;
                  EXIT;
               END IF;
               v_idx := v_idx + 1;
            END LOOP;
            IF prepare_token THEN PIPE ROW (v_pipe_rec); END IF;
            CONTINUE;

         -----------------------------------------------------------------------
         -- STATE: SPECIAL SIGN CHARACTERS
         -----------------------------------------------------------------------
         ELSIF INSTR(':=<>!+-*/^|&.(),[];', v_char) > 0 THEN
            IF prepare_token THEN PIPE ROW (v_pipe_rec); END IF;
            v_tok_type := 'SPECIAL_CHARACTER';
            
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
            IF prepare_token THEN PIPE ROW (v_pipe_rec); END IF;
            CONTINUE;

         -----------------------------------------------------------------------
         -- STATE: NUMERIC LITERALS
         -----------------------------------------------------------------------
         ELSIF v_char >= '0' AND v_char <= '9' THEN
            IF NVL(v_tok_type, 'X') <> 'NUMBER_LITERAL' THEN
               IF prepare_token THEN PIPE ROW (v_pipe_rec); END IF;
               v_tok_type := 'NUMBER_LITERAL';
            END IF;
            append_char(v_char);
            v_idx := v_idx + 1;
            CONTINUE;

         -----------------------------------------------------------------------
         -- STATE: WHITESPACE (spaces, tabs, newlines)
         -----------------------------------------------------------------------
         ELSIF v_char = ' ' OR v_char = CHR(9) OR v_char = CHR(10) OR v_char = CHR(13) THEN
            IF NVL(v_tok_type, 'X') <> 'WHITESPACE' THEN
               IF prepare_token THEN PIPE ROW (v_pipe_rec); END IF;
               v_tok_type := 'WHITESPACE';
            END IF;
            append_char(v_char);
            v_idx := v_idx + 1;
            CONTINUE;

         -----------------------------------------------------------------------
         -- STATE: WORDS (Identifiers or Keywords)
         -----------------------------------------------------------------------
         ELSE
            IF NVL(v_tok_type, 'X') <> 'WORD' THEN
               IF prepare_token THEN PIPE ROW (v_pipe_rec); END IF;
               v_tok_type := 'WORD';
            END IF;
            append_char(v_char);
            v_idx := v_idx + 1;
            CONTINUE;
         END IF;

      END LOOP;

      -- Flush final trailing token securely from the top-level block
      IF prepare_token THEN 
         PIPE ROW (v_pipe_rec); 
      END IF;
      
      DBMS_LOB.FREETEMPORARY(v_tok_buf);
      RETURN;
   END tokenize_code;
-- 
   FUNCTION tokens_to_clob(p_tokens IN parser_token_col) 
   RETURN CLOB 
   IS
      v_result CLOB;
   BEGIN
      IF p_tokens IS NULL OR p_tokens.COUNT = 0 THEN
         RETURN NULL;
      END IF;

      DBMS_LOB.CREATETEMPORARY(v_result, TRUE);

      -- Query the collection ordered by the sequence to guarantee code integrity
      FOR r IN (
         SELECT tok_text_normal, tok_text_long 
         FROM TABLE(p_tokens) 
         ORDER BY tok_seq
      ) LOOP
         IF r.tok_text_normal IS NOT NULL THEN
            DBMS_LOB.WRITEAPPEND(v_result, LENGTH(r.tok_text_normal), r.tok_text_normal);
         ELSIF r.tok_text_long IS NOT NULL THEN
            -- Safely append the CLOB token field to our result CLOB
            DBMS_LOB.APPEND(v_result, r.tok_text_long);
         END IF;
      END LOOP;

      RETURN v_result;
   END tokens_to_clob;

END;
/
