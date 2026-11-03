    PROCEDURE xxx_process_token_brackets(pio_tokens IN OUT token_list) IS
        v_open_idx       NUMBER := 0;
        v_close_idx      NUMBER := 0;
        v_bracket_type   VARCHAR2(1);
        v_level          NUMBER := 0;
        v_inner_tokens   token_list;
        v_new_rule_name  VARCHAR2(100);
        v_new_tokens     token_list;
        v_new_idx        NUMBER := 1;
        v_skip_until     NUMBER := 0;
		-- 
		PROCEDURE ipr_detect_infinite_loop
		AS 
		BEGIN 
			g_curr_nesting_level := 		g_curr_nesting_level + 1;
			IF g_curr_nesting_level >= g_max_nesting - g_nesting_dump_loop_max THEN 
				FOR i IN 1 .. g_nesting_dump_loop_max LOOP 
					dbms_output.put_line ( $$plsql_unit||':'||$$plsql_line
							||' nesting: '||g_curr_nesting_level 
							||' i: '||i 
							||' pio_tokens(i):' || pio_tokens(i)
							||' g_curr_lhs: '|| g_curr_lhs
							||' g_curr_rhs: '|| g_curr_rhs
						);
				END LOOP; 
				--
				IF g_curr_nesting_level = g_max_nesting THEN 
					RAISE_APPLICATION_ERROR( -20001 , 
							$$plsql_unit||':'||$$plsql_line
							||' MAX NESTING LEVEL REACHED: '||g_max_nesting 
							||' nesting: '||g_curr_nesting_level 
							||' g_curr_lhs: '|| g_curr_lhs
							||' g_curr_rhs: '|| g_curr_rhs
						);
				END IF;
			END IF;
		END ipr_detect_infinite_loop;
    BEGIN	-- process_token_brackets
			dbms_output.put_line ( $$plsql_unit||':'||$$plsql_line||' g_curr_nesting_level: '||g_curr_nesting_level	); debug_tokens( p_tokens=> pio_tokens ) ;		
		-- 
        -- Scan tokens to find the first outermost opening bracket sequence
        FOR i IN 1..pio_tokens.COUNT LOOP
			-- dbms_output.put_line ( $$plsql_unit||':'||$$plsql_line||' pio_tokens('||i||'): '||pio_tokens(i)	);		
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
		dbms_output.put_line ( $$plsql_unit||':'||$$plsql_line||' v_level:'|| v_level||' v_bracket_type: '||v_bracket_type||' v_open_idx/v_close_idx: '||v_open_idx||'/'||v_close_idx	);

        -- If an outermost bracket pair was isolated
        IF v_open_idx > 0 THEN
            FOR i IN (v_open_idx + 1)..(v_close_idx - 1) LOOP
                v_inner_tokens(v_inner_tokens.COUNT + 1) := pio_tokens(i);
            END LOOP;
            
			dbms_output.put_line ( $$plsql_unit||':'||$$plsql_line||' nesting: '||g_curr_nesting_level ||' v_bracket_type: "'|| v_bracket_type||'"' );
            v_suffix_ix := v_suffix_ix + 1;

            IF v_bracket_type = '[' THEN
                v_new_rule_name := '<'|| f_trim_angle_brackes(p_lhs) ||'_opt_' || v_suffix_ix || '>';
				dbms_output.put_line ( $$plsql_unit||':'||$$plsql_line
							||' nesting: '||g_curr_nesting_level 
							||' v_new_rule_name: '|| v_new_rule_name
							||' v_suffix_ix: '|| v_suffix_ix
						);
                
                v_working_rules.EXTEND;
                v_working_rules(v_working_rules.LAST).lhs := v_new_rule_name;
                
                -- Store inside parenthetical expression to force Phase 2 to resolve choices cleanly
                v_working_rules(v_working_rules.LAST).tokens(1) := '(';
                FOR i IN 1..v_inner_tokens.COUNT LOOP
                    v_working_rules(v_working_rules.LAST).tokens(i+1) := v_inner_tokens(i);
                END LOOP;
                v_working_rules(v_working_rules.LAST).tokens(v_inner_tokens.COUNT + 2) := '|';
                v_working_rules(v_working_rules.LAST).tokens(v_inner_tokens.COUNT + 3) := c_epsilon;
                v_working_rules(v_working_rules.LAST).tokens(v_inner_tokens.COUNT + 4) := ')';
                
                v_skip_until := v_close_idx;
                
            ELSIF v_bracket_type = '{' THEN
                --Asterix is not part of EBNF, Oracle might use it: IF pio_tokens.EXISTS(v_close_idx + 1) AND pio_tokens(v_close_idx + 1) = '*' 				THEN
				-- optional sequence of tokens which repeats itself 
                    v_new_rule_name := '<'||f_trim_angle_brackes( p_lhs )||'_rep_' || v_suffix_ix || '>';
                    
                    v_working_rules.EXTEND;
                    v_working_rules(v_working_rules.LAST).lhs := v_new_rule_name;
				dbms_output.put_line ( $$plsql_unit||':'||$$plsql_line
							||' nesting: '||g_curr_nesting_level 
							||' v_new_rule_name: '|| v_new_rule_name
							||' v_suffix_ix: '|| v_suffix_ix
						);
                    
                    -- Formulate structural base: ( inner_tokens <rep_n> | ; )
                    v_working_rules(v_working_rules.LAST).tokens(1) := '(';
                    
                    -- If the inner block contains nested alternatives like ( "-" | "+" ), 
                    -- we preserve them intact so Phase 2 can multiply them alongside the trailing <rep_n>
                    FOR i IN 1..v_inner_tokens.COUNT LOOP
                        v_working_rules(v_working_rules.LAST).tokens(i+1) := v_inner_tokens(i);
                    END LOOP;
                    
                    v_working_rules(v_working_rules.LAST).tokens(v_inner_tokens.COUNT + 2) := v_new_rule_name;
                    v_working_rules(v_working_rules.LAST).tokens(v_inner_tokens.COUNT + 3) := '|';
                    v_working_rules(v_working_rules.LAST).tokens(v_inner_tokens.COUNT + 4) := c_epsilon;
                    v_working_rules(v_working_rules.LAST).tokens(v_inner_tokens.COUNT + 5) := ')';
                    
                    v_skip_until := v_close_idx + 1;
                ELSE  -- got round bracket 
					-- Plain group: replace { A }` with ( A ) in place
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
            END IF;
		dbms_output.put_line ( $$plsql_unit||':'||$$plsql_line
							||' nesting: '||g_curr_nesting_level 
							||' v_new_rule_name: '|| v_new_rule_name
						);

            -- Re-stitch the parent rule tokens, injecting the new rule pointer tag
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
            
            -- Recurse to handle any other bracket definitions inside this array block
ipr_detect_infinite_loop;			
            xxx_process_token_brackets(pio_tokens);
        END IF;
    END xxx_process_token_brackets;
