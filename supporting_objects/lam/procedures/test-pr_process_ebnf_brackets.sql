SET SERVEROUTPUT ON 
DECLARE 
	v_testname				VARCHAR2(200);
	v_subrule_prefix		VARCHAR2(200);
	v_lhs_root      		VARCHAR2(200);
	v_source        		VARCHAR2(200);
	v_bracket_type 		VARCHAR2(200) ;--   ROUND_BRK, CURLY_BRK or SQUARE_BRK
	v_open_idx 			NUMBER   ;-- index of open bracket 
	v_close_idx 		NUMBER	 ;-- index of close bracket 
	v_sequence 			NUMBER ;	
	v_brk_suffix_map_json 	VARCHAR2(1000);
	v_rhs_tokens  		sys.odciVarchar2List ;
	v_work_rules  		parser_grammar_rule_simple_col ;
	--
	 FUNCTION fn_format_grammar_rule 
	( p_rule parser_grammar_rule_simple_rec 
	) RETURN VARCHAR2 AS 
	BEGIN 
	  RETURN p_rule.lhs || ' ::= ' || p_rule.rhs || 
			 ' [Root: ' || p_rule.lhs_root || 
			 ', Subrule: ' || TO_CHAR(p_rule.subrule_no) || 
			 ', Source: ' || p_rule.source || ']';
	END fn_format_grammar_rule;
	-- 
	PROCEDURE run_test ( p_testname VARCHAR2 )
	AS 
		v_old_rhs 			VARCHAR2(1000);
		v_new_rhs 			VARCHAR2(1000);
	BEGIN 
		dbms_output.put_line ( lpad ('*', 60 , '**' ) );
		dbms_output.put_line ( ' Test '|| p_testname );
		dbms_output.put_line ( lpad ('*', 60 , '**' ) );
		-- prepare old v_rhs_tokens for outpt 
		SELECT LISTAGG(COLUMN_VALUE, ' ') WITHIN GROUP (ORDER BY ROWNUM)
		INTO v_old_rhs
		FROM TABLE( v_rhs_tokens )
		;
		dbms_output.put_line( 'v_old_rhs: '|| v_old_rhs );
		--
		pr_process_1_bracket_pair 
		( p_subrule_prefix		=> v_subrule_prefix		
		 ,p_lhs_root      		=> v_lhs_root      		
		 ,p_source        		=> v_source        		
		 ,p_bracket_type 		=> v_bracket_type 			
		 ,p_open_idx 			=> v_open_idx 				
		 ,p_close_idx 			=> v_close_idx 			
		 ,p_sequence 			=> v_sequence 				
		 ,p_brk_suffix_map_json => v_brk_suffix_map_json 	
		 ,pio_rhs_tokens  		=> v_rhs_tokens  			
		 ,pio_work_rules  		=> v_work_rules  			
		) ;
		-- prepare new v_rhs_tokens for outpt 
		SELECT LISTAGG(COLUMN_VALUE, ' ') WITHIN GROUP (ORDER BY ROWNUM)
		INTO v_new_rhs
		FROM TABLE( v_rhs_tokens )
		;
		dbms_output.put_line( 'v_new_rhs: '|| v_new_rhs );
		--
		dbms_output.put_line( 'v_work_rules.count: '|| v_work_rules.count );
		dbms_output.put_line( 'new workrule: '|| fn_format_grammar_rule( v_work_rules( v_work_rules.last ) ) );
	END run_test;
BEGIN 	
	v_lhs_root      		:= 'root' ; 
	v_source        		:= 'source' ; 
	-- 
	v_bracket_type 			:= 'SQUARE_BRK' ; 
	v_testname := 'test 1 ' || v_bracket_type ;
	v_subrule_prefix		:= 'sub1' ; 
	v_rhs_tokens  			:= 			sys.odciVarchar2List(
			'{', 'a'
			, '[', 'b', '(', 'c', 'DANGLING', ')', ']'
			, '}'
			); 
	v_open_idx 				:= 3; 
	v_close_idx 			:= 9 ; 
	v_sequence 				:= 9 ; 
	v_brk_suffix_map_json 	:= '{ "ROUND_BRK": "_grp_", "CURLY_BRK": "_lst_", "SQUARE_BRK": "_opt_" }' ; 
	v_work_rules  			:= parser_grammar_rule_simple_col() ; 
	-- 
	run_test( v_testname );
	--
	v_bracket_type 			:= 'ROUND_BRK' ; 
	v_testname := 'test 2' || v_bracket_type ;
	v_subrule_prefix		:= 'sub2' ; 
	v_rhs_tokens  			:= 	parser_rule_util.dbx_tokenize_rhs( v_work_rules( v_work_rules.last ).rhs ); 
	v_open_idx 				:= 3; 
	v_close_idx 			:= 6; 
	v_sequence 				:= v_sequence + 1 ; 
	v_brk_suffix_map_json 	:= '{ "ROUND_BRK": "_g_", "CURLY_BRK": "_l_", "SQUARE_BRK": "_o_" }' ; 
	-- v_work_rules  			:= parser_grammar_rule_simple_col() ; 
	-- 
	run_test( v_testname );
	--
END;
/	