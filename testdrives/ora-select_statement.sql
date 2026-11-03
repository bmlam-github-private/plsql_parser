VAR source_key	VARCHAR2 
VAR grammar 	CLOB  
VAR package_name		VARCHAR2 
VAR test_compile_status	VARCHAR2 
VAR test_code_1			VARCHAR2 






SET SERVEROUTPUT on 

BEGIN 
	:source_key := upper( trim ( 'ora_select_statement' ) )
	;
	:package_name :=  upper( 'pkg_'||:source_key );
    DBMS_output.put_line( 'source_key: '||upper( :source_key ) );
	:grammar := q'[
# 2026.11.03: Removed arrow brackets and quote SQL keywords
#
select_statement ::= [with_clause] query_block { set_operator  query_block} [ order_by_clause ] [for_update_clause]
;
with_clause ::= "WITH" with_item {"," with_item}
;
with_item ::= identifier [ "(" column_list ")" ] "AS" "("  subquery  ")"
;
set_operator  ::= "UNION" ["ALL"]
              | "INTERSECT"
              | "MINUS"
;
subquery  ::= query_block { set_operator  query_block}
;
query_block ::= "SELECT" [ "DISTINCT" | "UNIQUE" | "ALL" ]
                select_list    
                "FROM" table_reference_list
                [where_clause ]
                [group_by_clause]
                [having_clause]
                [hierarchical_query_clause]
;
select_list    ::= select_item {"," select_item}
;
select_item ::= arith_expression [alias] | "*"
;
alias ::= identifier 
;
table_reference_list ::= table_reference {"," table_reference}
;
table_reference ::= table_factor {join_clause}
;
table_factor ::= table_name  [ alias ]
               | "("  subquery  ")" [alias]
;
join_clause ::= join_type "JOIN" table_factor "ON" condition
                | join_type "JOIN" table_factor
;				
# NATURAL JOIN is not considered yet! 
join_type ::= "INNER"
              | "LEFT" ["OUTER"]
              | "RIGHT" ["OUTER"]
              | "FULL"  ["OUTER"]
              | "CROSS"
;
where_clause  ::= "WHERE" condition
;
group_by_clause ::= "GROUP" "BY" group_by_list
;
group_by_list ::= group_by_item {"," group_by_item}
;
group_by_item ::= arith_expression
                | "ROLLUP" "(" expression_list ")"
                | "CUBE" "(" expression_list ")"
;
having_clause ::= "HAVING" condition
;
hierarchical_query_clause ::= "START" "WITH" condition
                              "CONNECT" "BY" ["NOCYCLE"] condition
;
order_by_clause  ::= "ORDER" "BY" order_by_list
;
order_by_list ::= order_by_item {"," order_by_item}
;
order_by_item ::= arith_expression ["ASC" | "DESC"] ["NULLS" "FIRST" | "NULLS" "LAST"]
;
for_update_clause ::= "FOR" "UPDATE" [ "OF" column_list ]
                     ["NOWAIT" | "WAIT" number | "SKIP" "LOCKED" ]
;
column_list ::= identifier {"," identifier}
;
condition ::= logical_term {"OR" logical_term}
;
logical_term ::= logical_factor {"AND" logical_factor}
;
logical_factor ::= ["NOT"] logical_predicate
;
logical_predicate ::= comparison
                  | between_predicate
                  | in_predicate
                  | exists_predicate
                  | like_predicate
                  | is_null_predicate
;
comparison ::= arithmetic_expr comp_op arithmetic_expr ["(+)"]
;
comp_op ::= "=" | "!=" | "<>" | "<" | ">" | "<=" | ">="
;
between_predicate ::= arithmetic_expr ["NOT"] "BETWEEN" arithmetic_expr "AND" arithmetic_expr
;
in_predicate ::= arithmetic_expr ["NOT"] "IN" "(" (expression_list |  subquery ) ")"
;
exists_predicate ::= "EXISTS" "("  subquery  ")"
;
like_predicate ::= arithmetic_expr ["NOT"] "LIKE" arithmetic_expr
;
is_null_predicate ::= arithmetic_expr "IS" ["NOT"] "NULL"
;
arithmetic_expr ::= term { ( "+" | "-" ) term }*
;
term ::= factor { ( "*" | "/" ) factor }*
;
factor ::= literal
           | column_reference
           | function_call
           | case_expression
           | "(" arith_expression ")"
           | "("  subquery  ")"
;
function_call ::= identifier "(" [expression_list] ")" [analytic_clause]
;
analytic_clause ::= "OVER" "(" [partition_clause] [ order_by_clause ] ")"
;
partition_clause ::= "PARTITION" "BY" expression_list
;
case_expression ::= "CASE"
                    {"WHEN" condition "THEN" arith_expression}+
                    ["ELSE" arith_expression]
                    "END"
                  | "CASE" arith_expression
                    {"WHEN" arith_expression "THEN" arith_expression}+
                    ["ELSE" arith_expression]
                    "END"
;
decode_function ::= "DECODE" "(" arith_expression "," expression_list ")"
;
nvl_function ::= "NVL" "(" arith_expression "," arith_expression ")"
;
column_reference ::= [identifier "."] identifier
;
table_name  ::= identifier
;
expression_list ::= arith_expression {"," arith_expression}
;
literal ::= number_literal
            | string_literal
            | "NULL"
;			
]';
	--
	:test_code_1 := 'SELECT ename, hiredate, sal * 1.1 new_sal, 
						(SELECT d.name FROM dept d WhERE d.no = e.deptno ) AS dept
					FROM emp e 
					WHERE sal < 10*1000
						';
END;
/

set linesize 200 
print :grammar 



SET SERVEROUTPUT off 
PROMPT converting grammar to rule atl_tokens 
BEGIN 
	pr_refresh_rat_of_grammar 
		( p_grammar 	=> :grammar 
		 ,p_source_key 	=> :source_key
		);
END;
/



PAUSE 		
	


PROMPT Generating code parser package 
DECLARE 	
	v_spec		CLOB; 
	v_body		CLOB; 
BEGIN 
	--
	v_spec := parser_grammar_gen. fn_get_parser_package_code ( 
        p_source => :source_key , p_package_name => :package_name 
        , p_spec_body_mask => 1
		, p_append_slash => 0 
        ) ;
    BEGIN 		
		EXECUTE IMMEDIATE v_spec; 
	EXCEPTION 
		WHEN OTHERS THEN 
			pck_std_log.info ( a_comp => 'TEST-DRIVE-WITH-PAUSE', a_text=> 'Exception on compiling SPEC code (code in next log entry): '||sqlerrm );
			pck_std_log.info_long ( a_comp => 'TEST-DRIVE-WITH-PAUSE', a_text=> v_spec);
			--
dbms_output.enable; 
DBMS_output.put_line ( 'v_spec: '||v_spec );
dbms_output.disable; 
			RAISE; 
	END ;
	--
	v_body := parser_grammar_gen. fn_get_parser_package_code ( 
        p_source => :source_key , p_package_name => :package_name 
        , p_spec_body_mask => 2 
		, p_append_slash => 0 
		, p_root_rule	=> 'expression' 
        ) ;
    BEGIN 		
		EXECUTE IMMEDIATE v_body; 
	EXCEPTION 
		WHEN OTHERS THEN 
			pck_std_log.info ( a_comp => 'TEST-DRIVE-WITH-PAUSE', a_text=> 'Exception on compiling BODY code (code in next log entry): '||sqlerrm );
			pck_std_log.info_long ( a_comp => 'TEST-DRIVE-WITH-PAUSE', a_text=> v_spec);
			--
			RAISE; 
	END ;
	--
END; 
/

PROMPT If no exception, package has been created or replace 
PRINT :package_name 

PAUSE 


SET SERVEROUTPUT ON SIZE 100000 
col spool_file 		new_value spool_file 
col package_name 	new_value package_name

SELECT 'c:\users\Bon-Minh Lam\plsql_parser\test-generated-parser.txt' AS spool_file 
	,:package_name AS package_name 
FROM dual
;

spool "&spool_file" 

Prompt Grammar: 
print :grammar 

Prompt test_code_1: 
print :test_code_1 

PROMPT Testing code parser package 
DECLARE 
	vtab_lexer_token lexer_token_col;
	v_success	BOOLEAN; 
BEGIN 
	vtab_lexer_token := plsql_lexer. code_to_lang_tokens
		( pi_code => :test_code_1
		 ,pi_grammar_source => :source_key 
		);
	--
	&package_name..parse_main    
		( p_token_stream => vtab_lexer_token
		 ,po_success	 => v_success
		 );
	:test_compile_status := 'Test compile success: '|| case v_success WHEN TRUE THEN 'YES' ELSE 'NO' END ;
END;
/		
SPOOL OFF 

PROMPT ***********************************************************************
PROMPT Result spooled to &spool_file
PROMPT ***********************************************************************

PROMPT Test compile status
PRINT :test_compile_status 

