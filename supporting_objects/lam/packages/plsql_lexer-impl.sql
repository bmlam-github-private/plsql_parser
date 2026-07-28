CREATE OR REPLACE PACKAGE BODY plsql_lexer AS

FUNCTION code_to_basic_tokens
( pi_code IN CLOB
) RETURN parser_token_col PIPELINED 
IS
        v_pos          NUMBER := 1;
        v_match_pos    NUMBER;
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
			--dbms_output.put_line( $$PLSQL_UNIT||':'||$$PLSQL_LINE||' v_seq:'|| v_seq||' p_type:'|| p_type||' p_text:'|| dbms_lob.substr( p_text, 40, 1) );

            v_char_len := DBMS_LOB.GETLENGTH(p_text);
            v_rec := parser_token_rec(tok_seq=> v_seq, tok_type=> p_type, tok_char_cnt=> v_char_len, tok_text_normal=> NULL, tok_text_long=> NULL);
            
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
        v_len := DBMS_LOB.GETLENGTH(pi_code);
        
        WHILE v_pos <= v_len LOOP
            v_char := DBMS_LOB.SUBSTR(pi_code, 1, v_pos);
            v_next_char := DBMS_LOB.SUBSTR(pi_code, 1, v_pos + 1);
            
            -- 1. Skip and consume Whitespaces
            IF v_char IN (CHR(32), CHR(9), CHR(10), CHR(13)) THEN
                -- Optionally emit whitespace tokens or silently drop them. 
                -- We skip them here to focus purely on code semantics.
                v_pos := v_pos + 1;
                CONTINUE;
            END IF;

            -- 2. Multi-line Block Comments (/* ... */)
            IF v_char = '/' AND v_next_char = '*' THEN
                v_end_pos := DBMS_LOB.INSTR(pi_code, '*/', v_pos + 2);
                IF v_end_pos = 0 THEN v_end_pos := v_len + 1; ELSE v_end_pos := v_end_pos + 2; 
				END IF;
                PIPE ROW( consume_token('BLOCK_COMMENT', DBMS_LOB.SUBSTR(pi_code, v_end_pos - v_pos, v_pos)) );
                v_pos := v_end_pos;
                CONTINUE;
            END IF;

            -- 3. Line Comments (-- ...)
            IF v_char = '-' AND v_next_char = '-' THEN
                v_end_pos := DBMS_LOB.INSTR(pi_code, CHR(10), v_pos + 2);
                IF v_end_pos = 0 THEN v_end_pos := v_len + 1; ELSE v_end_pos := v_end_pos + 1; 
				END IF;
                PIPE ROW( consume_token('LINE_COMMENT', DBMS_LOB.SUBSTR(pi_code, v_end_pos - v_pos, v_pos)) );
                v_pos := v_end_pos;
                CONTINUE;
            END IF;

            -- 4. Alternative Quoting Mechanism / Q-notation (q'[...]' or q'!...!')
            IF LOWER(v_char) = 'q' AND v_next_char = '''' THEN
                v_q_delim := DBMS_LOB.SUBSTR(pi_code, 1, v_pos + 2);
                -- Resolve matching pairs for braces/brackets
                v_q_end_delim := CASE v_q_delim 
                                    WHEN '[' THEN ']'
                                    WHEN '{' THEN '}'
                                    WHEN '(' THEN ')'
                                    WHEN '<' THEN '>'
                                    ELSE v_q_delim 
                                 END;
                
                v_end_pos := DBMS_LOB.INSTR(pi_code, v_q_end_delim || '''', v_pos + 3);
                IF v_end_pos = 0 THEN 
                    v_end_pos := v_len + 1; 
                ELSE 
                    v_end_pos := v_end_pos + 2; 
                END IF;
                
                PIPE ROW( consume_token('STRING_LITERAL_Q', DBMS_LOB.SUBSTR(pi_code, v_end_pos - v_pos, v_pos)) );
                v_pos := v_end_pos;
                CONTINUE;
            END IF;

            -- 5. Standard String Literals ('...') with escaped single quotes ('')
            IF v_char = '''' THEN
                v_end_pos := v_pos + 1;
                LOOP
                    v_end_pos := DBMS_LOB.INSTR(pi_code, '''', v_end_pos);
                    IF v_end_pos = 0 THEN
                        v_end_pos := v_len + 1;
                        EXIT;
                    ELSIF DBMS_LOB.SUBSTR(pi_code, 1, v_end_pos + 1) = '''' THEN
                        -- Escaped quote found, jump past it and keep seeking
                        v_end_pos := v_end_pos + 2;
                    ELSE
                        v_end_pos := v_end_pos + 1;
                        EXIT;
                    END IF;
                END LOOP;
                
                PIPE ROW( consume_token('STRING_LITERAL', DBMS_LOB.SUBSTR(pi_code, v_end_pos - v_pos, v_pos)) );
                v_pos := v_end_pos;
                CONTINUE;
            END IF;

            -- 6. Numeric Literals (Including decimals)
			v_match_pos := REGEXP_INSTR ( pi_code, '[0-9]+(\.[0-9]+)?([eE][+-]?[0-9]+)?', v_pos);
            --dbms_output.put_line ( $$PLSQL_UNIT||':'||$$PLSQL_LINE||' v_match_pos:'|| v_match_pos );
			IF v_match_pos	= v_pos  
			THEN 
				v_match := 	REGEXP_SUBSTR(pi_code, '[0-9]+(\.[0-9]+)?([eE][+-]?[0-9]+)?', v_pos);
				IF v_match IS NOT NULL THEN
					v_next_char := dbms_lob.substr( pi_code, 1, v_pos + length( v_match ) );
					IF v_next_char IS NOT NULL 
					  AND v_next_char NOT IN (
						-- whitespaces 
						CHR(32), CHR(9), CHR(10), CHR(13),
						-- special chars 
						  CHR(33), -- ! Exclamation mark
						  CHR(34), -- " Double quote
						  CHR(35), -- # Number sign / Hash
						  CHR(36), -- $ Dollar sign
						  CHR(37), -- % Percent sign
						  CHR(38), -- & Ampersand
						  CHR(39), -- ' Single quote / Apostrophe
						  CHR(40), -- ( Left parenthesis
						  CHR(41), -- ) Right parenthesis
						  CHR(42), -- * Asterisk
						  CHR(43), -- + Plus sign
						  CHR(44), -- , Comma
						  CHR(45), -- - Hyphen / Minus
						  CHR(46), -- . Full stop / Period
						  CHR(47), -- / Slash / Solidus
						  CHR(58), -- : Colon
						  CHR(59), -- ; Semicolon
						  CHR(60), -- < Less-than sign
						  CHR(61), -- = Equals sign
						  CHR(62), -- > Greater-than sign
						  CHR(63), -- ? Question mark
						  CHR(64), -- @ At sign
						  CHR(91), -- [ Left square bracket
						  CHR(92), -- \ Backslash
						  CHR(93), -- ] Right square bracket
						  CHR(94), -- ^ Caret / Circumflex
						  CHR(95), -- _ Underscore
						  CHR(96), -- ` Grave accent / Backtick
						  CHR(123),-- { Left curly bracket
						  CHR(124),-- | Vertical bar / Pipe
						  CHR(125),-- } Right curly bracket
						  CHR(126) -- ~ Tilde
						)
					THEN 
						RAISE_APPLICATION_ERROR( -20001, 'Numeric literals followed by illegal character. Position: '||v_pos||' assumed literal: "'||v_match ||'" followed by: "'||v_next_char||'"' );
						--dbms_output.put_line( 'Numeric literals followed by illegal character. Position: '||v_pos||' assumed literal: "'||v_match ||'" followed by: "'||v_next_char||'"' );
					ELSE 
						PIPE ROW( consume_token('NUMBER_LITERAL', v_match) );
						v_pos := v_pos + LENGTH(v_match);
						CONTINUE;
					END IF; 		-- check v_next_char 
				END IF; 		-- check match numeric literal 
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
            v_match := REGEXP_SUBSTR(pi_code, '[a-zA-Z_][a-zA-Z0-9_#$]*', v_pos);
            --dbms_output.put_line ( $$PLSQL_UNIT||':'||$$PLSQL_LINE||' pos:'|| lpad(to_char(v_pos),4, ' ') ||' code at currpos:'|| substr(pi_code, v_pos, 30)  );
            --dbms_output.put_line ( $$PLSQL_UNIT||':'||$$PLSQL_LINE||' match: '|| v_match );
			IF v_match IS NOT NULL THEN
                PIPE ROW( consume_token('WORD', v_match) );
                v_pos := v_pos + LENGTH(v_match);
                CONTINUE;
            END IF;
			-- 
			RAISE_APPLICATION_ERROR( -20001, 'Lexer cannot classify input from position '||v_pos||' text: "'||dbms_lob.substr(pi_code, 30, v_pos )||'..."' );

            -- Fallback block for unrecognized solitary symbols to prevent hanging loops
            v_pos := v_pos + 1;
        END LOOP;
        
        RETURN;
   END code_to_basic_tokens;
--
   FUNCTION basic_tokens_to_clob(pi_tokens IN parser_token_col)
   RETURN CLOB
   IS
      v_result CLOB;
   BEGIN
      IF pi_tokens IS NULL OR pi_tokens.COUNT = 0 THEN
         RETURN NULL;
      END IF;

      DBMS_LOB.CREATETEMPORARY(v_result, TRUE);

      -- Query the collection ordered by the sequence to guarantee code integrity
      FOR r IN (
         SELECT tok_text_normal, tok_text_long
         FROM TABLE(pi_tokens)
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
END basic_tokens_to_clob;
-- 
PROCEDURE pr_to_tokens_of_lang_plsql 
	( pi_basic_tokens 		IN	parser_token_col 
	 ,pi_grammar_source 	IN 	VARCHAR2 
	 ,pi_remove_comment		IN 	NUMBER DEFAULT 0 
	 ,po_lang_tokens 		OUT parser_token_col 
	) 
	AS
		v_tok_new parser_token_rec; 
		v_reserved_keywords  	sys.re$name_array ;
		v_text_normed VARCHAR2(4000 CHAR);
		-- 
		FUNCTION is_keyword 
		( pi_text			IN	VARCHAR2
		 ,po_text_normed	OUT	VARCHAR2
		)
		RETURN BOOLEAN 
		AS 
		BEGIN 
			po_text_normed := upper( pi_text ); 
			IF po_text_normed LIKE '"%"' THEN 
				po_text_normed := substr( 2, v_text_normed, length( po_text_normed )-2 );
			END IF;
			FOR i IN 1 .. v_reserved_keywords.COUNT 
			LOOP 
				IF po_text_normed = v_reserved_keywords(i)
				THEN 
					RETURN TRUE; 
				END IF; 
			END LOOP;
			--
			RETURN FALSE; 
		END is_keyword;
	-- 
	BEGIN 	-- pr_to_tokens_of_lang_plsql 
		po_lang_tokens := parser_token_col();
		-- 
		SELECT DISTINCT substr( symbol, 2, length( symbol ) -2 ) reserved_words
		BULK COLLECT 
		INTO v_reserved_keywords
		FROM parser_alt_token 
		WHERE 1=1
		  AND source = pi_grammar_source 
		  AND regexp_like ( symbol, '^"[A-Z_]+"$' )
		;
		-- 
		FOR i IN 1 .. pi_basic_tokens.count 
		LOOP 
			v_tok_new := pi_basic_tokens(i); 
			-- we just copy the token as is. Now adjust whatever that is sensible 
			CASE 
			WHEN pi_basic_tokens(i).tok_type = 'WORD' 
			THEN 
				IF is_keyword ( pi_basic_tokens(i).tok_text_normal, po_text_normed=> v_text_normed ) THEN 
					v_tok_new.tok_type := 'KEYWORD';
					v_tok_new.tok_value := '"'||v_text_normed||'"';
				ELSE 
					v_tok_new.tok_type := '<identifier>'; -- is this correct? 
					v_tok_new.tok_value := v_text_normed;
				END IF;
				po_lang_tokens.extend; po_lang_tokens( po_lang_tokens.count ) := v_tok_new;
			WHEN pi_basic_tokens(i).tok_type IN ( 'SPECIAL_CHAR', 'SPECIAL_CHAR_DBL' )
			THEN 
				v_tok_new.tok_value := v_tok_new.tok_text_normal;
				po_lang_tokens.extend; po_lang_tokens( po_lang_tokens.count ) := v_tok_new;
			WHEN pi_basic_tokens(i).tok_type IN ( 'LINE_COMMENT', 'BLOCK_COMMENT' )
			THEN 
				IF pi_remove_comment > 0 THEN 
					po_lang_tokens.extend; po_lang_tokens( po_lang_tokens.count ) := v_tok_new;
				END IF;
			WHEN pi_basic_tokens(i).tok_type IN ( 'STRING_LITERAL', 'STRING_LITERAL_Q', 'NUMBER_LITERAL' )
			THEN 
				po_lang_tokens.extend; po_lang_tokens( po_lang_tokens.count ) := v_tok_new;
			END CASE; 
		END LOOP;
		--
		--dbms_output.put_line ( $$PLSQL_UNIT||':'||$$PLSQL_LINE||' tokens out:'|| po_lang_tokens.count );
	END pr_to_tokens_of_lang_plsql;
--
FUNCTION code_to_lang_tokens
	( pi_code 			IN CLOB
	 ,pi_grammar_source IN VARCHAR2
	 ,pi_remove_comment	IN 	NUMBER DEFAULT 0 
	) RETURN parser_token_col
AS 
	v_basic_tokens 	parser_token_col;  
	v_return 		parser_token_col;  
BEGIN 
    SELECT  
		parser_token_rec(tok_seq=> tok_seq
		 ,tok_type=> tok_type
		 ,tok_char_cnt=> tok_char_cnt
		 ,tok_text_normal=> tok_text_normal
		 ,tok_text_long=> tok_text_long
		 )
	BULK COLLECT INTO v_basic_tokens 
    FROM TABLE ( 
        plsql_lexer.code_to_basic_tokens ( pi_code => pi_code 	)
		);
	-- convert basic to lang-specific 
	pr_to_tokens_of_lang_plsql 
	( pi_basic_tokens 		=> v_basic_tokens
	 ,pi_grammar_source 	=> pi_grammar_source
	 ,pi_remove_comment		=> pi_remove_comment 
	 ,po_lang_tokens 		=> v_return 
	);
	-- 
	RETURN v_return; 
END code_to_lang_tokens;
-- 	
END plsql_lexer;
/