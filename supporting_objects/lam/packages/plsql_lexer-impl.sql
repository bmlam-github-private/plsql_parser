CREATE OR REPLACE PACKAGE BODY plsql_lexer AS

    FUNCTION tokenize_code(p_code IN CLOB) RETURN parser_token_col PIPELINED IS
        v_pos          NUMBER := 1;
        v_len          NUMBER;
        v_seq          NUMBER := 1;
        v_match        VARCHAR2(32767);
        v_clob_match   CLOB;
        v_type         VARCHAR2(30);
        
        -- Helper flags and character extractions
        v_char         VARCHAR2(1 CHAR);
        v_next_char    VARCHAR2(1 CHAR);
        v_q_delim      VARCHAR2(1 CHAR);
        v_q_end_delim  VARCHAR2(1 CHAR);
        v_end_pos      NUMBER;
        
        -- Safe insertion helper to separate VARCHAR2 and CLOB fields
        FUNCTION consume_token(p_type IN VARCHAR2, p_text IN CLOB
		) RETURN parser_token_rec
		IS
            v_rec parser_token_rec;
            v_char_len NUMBER;
        BEGIN
            v_char_len := DBMS_LOB.GETLENGTH(p_text);
            v_rec := parser_token_rec(v_seq, p_type, v_char_len, NULL, NULL);
            
            IF v_char_len <= 4000 THEN
                v_rec.tok_text_normal := DBMS_LOB.SUBSTR(p_text, 4000, 1);
            ELSE
                v_rec.tok_text_long := p_text;
            END IF;
            
            --PIPE ROW(v_rec);
            v_seq := v_seq + 1;
			RETURN v_rec;
        END consume_token;

    BEGIN
        v_len := DBMS_LOB.GETLENGTH(p_code);
        
        WHILE v_pos <= v_len LOOP
            v_char := DBMS_LOB.SUBSTR(p_code, 1, v_pos);
            v_next_char := DBMS_LOB.SUBSTR(p_code, 1, v_pos + 1);
            
            -- 1. Skip and consume Whitespaces
            IF v_char IN (CHR(32), CHR(9), CHR(10), CHR(13)) THEN
                -- Optionally emit whitespace tokens or silently drop them. 
                -- We skip them here to focus purely on code semantics.
                v_pos := v_pos + 1;
                CONTINUE;
            END IF;

            -- 2. Multi-line Block Comments (/* ... */)
            IF v_char = '/' AND v_next_char = '*' THEN
                v_end_pos := DBMS_LOB.INSTR(p_code, '*/', v_pos + 2);
                IF v_end_pos = 0 THEN v_end_pos := v_len + 1; ELSE v_end_pos := v_end_pos + 2; 
				END IF;
                PIPE ROW( consume_token('BLOCK_COMMENT', DBMS_LOB.SUBSTR(p_code, v_end_pos - v_pos, v_pos)) );
                v_pos := v_end_pos;
                CONTINUE;
            END IF;

            -- 3. Line Comments (-- ...)
            IF v_char = '-' AND v_next_char = '-' THEN
                v_end_pos := DBMS_LOB.INSTR(p_code, CHR(10), v_pos + 2);
                IF v_end_pos = 0 THEN v_end_pos := v_len + 1; ELSE v_end_pos := v_end_pos + 1; 
				END IF;
                PIPE ROW( consume_token('LINE_COMMENT', DBMS_LOB.SUBSTR(p_code, v_end_pos - v_pos, v_pos)) );
                v_pos := v_end_pos;
                CONTINUE;
            END IF;

            -- 4. Alternative Quoting Mechanism / Q-notation (q'[...]' or q'!...!')
            IF LOWER(v_char) = 'q' AND v_next_char = '''' THEN
                v_q_delim := DBMS_LOB.SUBSTR(p_code, 1, v_pos + 2);
                -- Resolve matching pairs for braces/brackets
                v_q_end_delim := CASE v_q_delim 
                                    WHEN '[' THEN ']'
                                    WHEN '{' THEN '}'
                                    WHEN '(' THEN ')'
                                    WHEN '<' THEN '>'
                                    ELSE v_q_delim 
                                 END;
                
                v_end_pos := DBMS_LOB.INSTR(p_code, v_q_end_delim || '''', v_pos + 3);
                IF v_end_pos = 0 THEN 
                    v_end_pos := v_len + 1; 
                ELSE 
                    v_end_pos := v_end_pos + 2; 
                END IF;
                
                PIPE ROW( consume_token('STRING_LITERAL_Q', DBMS_LOB.SUBSTR(p_code, v_end_pos - v_pos, v_pos)) );
                v_pos := v_end_pos;
                CONTINUE;
            END IF;

            -- 5. Standard String Literals ('...') with escaped single quotes ('')
            IF v_char = '''' THEN
                v_end_pos := v_pos + 1;
                LOOP
                    v_end_pos := DBMS_LOB.INSTR(p_code, '''', v_end_pos);
                    IF v_end_pos = 0 THEN
                        v_end_pos := v_len + 1;
                        EXIT;
                    ELSIF DBMS_LOB.SUBSTR(p_code, 1, v_end_pos + 1) = '''' THEN
                        -- Escaped quote found, jump past it and keep seeking
                        v_end_pos := v_end_pos + 2;
                    ELSE
                        v_end_pos := v_end_pos + 1;
                        EXIT;
                    END IF;
                END LOOP;
                
                PIPE ROW( consume_token('STRING_LITERAL', DBMS_LOB.SUBSTR(p_code, v_end_pos - v_pos, v_pos)) );
                v_pos := v_end_pos;
                CONTINUE;
            END IF;

            -- 6. Numeric Literals (Including decimals)
            v_match := REGEXP_SUBSTR(p_code, '^[0-9]+(\.[0-9]+)?([eE][+-]?[0-9]+)?', v_pos);
            IF v_match IS NOT NULL THEN
                PIPE ROW( consume_token('NUMBER_LITERAL', v_match) );
                v_pos := v_pos + LENGTH(v_match);
                CONTINUE;
            END IF;

            -- 7. Multi-character Special Operators (:=, !=, <>, <=, >=, =>, ||, **)
            IF v_char || v_next_char IN (':=', '!=', '<>', '<=', '>=', '=>', '||', '**') THEN
                PIPE ROW( consume_token('SPECIAL_CHAR_DBL', v_char || v_next_char) );
                v_pos := v_pos + 2;
                CONTINUE;
            END IF;

            -- 8. Single Special Characters (brackets, mathematical signs, punctuations)
            IF v_char IN ('(', ')', '[', ']', '<', '>', '=', '+', '-', '*', '/', ',', ';', '.', ':') THEN
                PIPE ROW( consume_token('SPECIAL_CHAR', v_char) );
                v_pos := v_pos + 1;
                CONTINUE;
            END IF;

            -- 9. Words (Identifiers or Keywords)
            v_match := REGEXP_SUBSTR(p_code, '^[a-zA-Z_][a-zA-Z0-9_#$]*', v_pos);
            IF v_match IS NOT NULL THEN
                PIPE ROW( consume_token('WORD', v_match) );
                v_pos := v_pos + LENGTH(v_match);
                CONTINUE;
            END IF;

            -- Fallback block for unrecognized solitary symbols to prevent hanging loops
            v_pos := v_pos + 1;
        END LOOP;
        
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
-- 
    PROCEDURE pr_to_tokens_of_lang_plsql 
	( pi_tokens 			IN	parser_token_col 
	 ,pi_grammar_source 	IN 	VARCHAR2 
	 ,pi_remove_comment		IN 	BOOLEAN 	DEFAULT FALSE 
	 ,po_tokens 			OUT parser_token_col 
	) 
	AS
		v_return  parser_token_col ;
		v_tok_new parser_token_rec; 
		v_reserved_keywords  	sys.re$name_array ;
		-- 
		FUNCTION is_keyword (
			pi_text		IN	VARCHAR2
		)
		RETURN BOOLEAN 
		AS 
			v_text_normed VARCHAR2(4000 CHAR);
		BEGIN 
			v_text_normed := upper( pi_text ); 
			IF v_text_normed LIKE '"%"' THEN 
				v_text_normed := substr( 2, v_text_normed, length( v_text_normed )-2 );
			END IF;
			FOR i IN 1 .. v_reserved_keywords.COUNT 
			LOOP 
				IF v_text_normed = v_reserved_keywords(i)
				THEN 
					RETURN TRUE; 
				END IF; 
			END LOOP;
			--
			RETURN FALSE; 
		END is_keyword;
	BEGIN 
		select distinct substr( symbol, 2, length( symbol ) -2 ) reserved_words
		BULK COLLECT 
		INTO v_reserved_keywords
		from parser_alt_token 
		where 1=1
		  and source = pi_grammar_source 
		  and regexp_like ( symbol, '^"[A-Z_]+"$' )
		;
		-- 
		FOR i IN 1 .. pi_tokens.count 
		LOOP 
			v_tok_new := parser_token_rec();
			v_tok_new.seq := pi_tokens(i).seq ;
			CASE 
			WHEN pi_tokens = 'WORD' 
				IF is_keyword ( pi_tokens ) THEN 
					v_tok_new.tok_type := 'KEYWORD';
					v_tok_value.tok_type := v_text_normed;
				ELSE 
					v_tok_new.tok_type := '<identifier>'; -- is this correct? 
					v_tok_value.tok_value := v_text_normed;
				END IF;
			END CASE; 
		END LOOP;
		RETURN v_return; 
	END to_tokens_of_lang_plsql;
END plsql_lexer;
/