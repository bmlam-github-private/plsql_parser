sta "C:\Users\Bon-Minh Lam\bmlam\my_tools_READONLY\extract_from_dba_source.sql" package_body plsql_lexer lam 

sta "C:\Users\Bon-Minh Lam\plsql_parser\supporting_objects\lam\packages\test-generated-parser.sql"

sta "C:\Users\Bon-Minh Lam\plsql_parser\scratch_pad\gemini_dynamic_generator.sql"

sta "C:\Users\Bon-Minh Lam\plsql_parser\supporting_objects\lam\packages\generated_code\20260717_plsql_excluding_sql-impl.sql"

select parser_grammar_gen.fn_get_parser_package_code( p_source => 'MANUAL_TEST' , p_spec_body_mask=> 2 )  from dual
;
--rename parser_grammar_rules to parser_grammar_rule_ebnf
;
SELECT *
fROM parser_grammar_rule_simple 
where 1=1
-- lhs_root = '<<variable_or_function>>'
order by lhs 
;
select source, count(1)
from parser_alt_token 
where 1=1
--  and source = 'PLSQL_EXCLUDING_SQL'
  and regexp_like ( symbol, '^"[A-Z_]+"$' )
group by source
;
-- c_rules from parser_grammar_rule . fn_get_parser_package_code 
		WITH dist_lhs AS ( 
			SELECT DISTINCT lhs 
			FROM parser_alt_token 
			WHERE source = upper( trim( 'plsql_excluding_sql' ) ) 
		) 
		SELECT lhs 
			, parser_grammar_gen. fn_norm_as_proc_name ( p_input=> lhs ) lhs_procname 
			, row_number() OVER ( PARTITION BY NULL ORDER BY lhs ) 	as seq 
			, count(*) OVER ( PARTITION BY NULL ORDER BY lhs ) 		as tot 
		FROM dist_lhs
		ORDER BY lhs
;
-- c_alternatives from parser_grammar_rule . fn_get_parser_package_code 
        SELECT *
--        DISTINCT t1.symbol
        FROM parser_alt_token t1
        WHERE 1=1
--        and lhs = cp_lhs 
         AND source = 'PLSQL_EXCLUDING_SQL'
         AND symbol like '<%>'
--  and ( lhs like '%statment%' or symbol like '%statement%' )
AND not exists ( select 1 from parser_alt_token t2 where t2.lhs = t1.symbol )         
--        ORDER BY null
--        , lhs,
--        alt_no
        ;


--update parser_alt_token set source = 'PLSQL_EXCLUDING_SQL'
;
WITH agg AS ( 
select t.*
    , count(1) over (partition by lhs, alt_no, position ) occ 
from parser_alt_token t
--from v_parser_alt_token
WHERE 1=1
--  and lower( lhs ) like '%%'
--  and lower( symbol) like '%decla%'
--  and source = upper( trim( 'PLSQL_EXCLUDING_SQL' ) ) 
--order by lhs, alt_no, position 
)
select * from agg where occ > 1 
;
SELECT t.*
, dbms_lob.getlength( content ) len 
from temp_clob t
where 1=1
;
insert into temp_clob ( remarks, content ) select 'mini_test', dbms_lob.substr( content, 1000 ) from temp_clob where remarks = 'plsql_excluding_SQL' 
;
select 
 length( t.rhs ) len_rhs
,t.*
from parser_grammar_rule_ebnf t
where 1=1
  and rhs like '%factor%'
--  and ( instr ( lower(lhs), 'expression>' ) > 0
--      or instr ( lower(rhs), '<expression>' ) > 0
--      )
--  and instr( comments, 'dedicated_to_expression ' ) > 0 
order by rule_id desc 
  ;
SELECT *
from parser_grammar_rule_ebnf
WHERE source = 'PLSQL_EXCLUDING_SQL'
;
select *
-- r.lhs, 
--t.*
--, length( t.content ) len 
--, dump( t.content ) dump 
from parser_grammar_rules r
--CROSS JOIN 
--table ( parser_grammar_gen.tokenize_rhs_refined ( r.rhs ) ) t
--where r.lhs = '<block>'
where 1=1
;
select *
from user_constraints 
where table_name = 'PARSER_TOKEN'
;
SELECT *
from table ( f_extract_tokens ( 
q'{
CREATE OR REPLACE FUNCTION f_extract_tokens (p_sql IN CLOB)
  RETURN parser_token_col 
  PIPELINED
IS
	c_typ_keyw_or_id	CONSTANT parser_token.token_type%TYPE := 'KEYWORD_OR_IDENT';
	c_typ_comm		CONSTANT parser_token.token_type%TYPE := 'COMMENT';
	c_typ_stm_e		CONSTANT parser_token.token_type%TYPE := 'STMT_END_SIGN';
	c_typ_l_br_r	CONSTANT parser_token.token_type%TYPE := 'LE_BR_RND';
	c_typ_l_br_sq	CONSTANT parser_token.token_type%TYPE := 'LE_BR_SQR';
	c_typ_op		CONSTANT parser_token.token_type%TYPE := 'OPERATOR';
	c_typ_num_lit	CONSTANT parser_token.token_type%TYPE := 'NUM_LITERAL';
	c_typ_r_br_r	CONSTANT parser_token.token_type%TYPE := 'RI_BR_RND';
	c_typ_r_br_sq	CONSTANT parser_token.token_type%TYPE := 'RI_BR_SQR';
	c_typ_str_lit	CONSTANT parser_token.token_type%TYPE := 'STR_LITERAL';
}' 
) )
order by tok_seq
;
select * 
from table ( parser_grammar_gen.tokenize_rhs_refined ( 'SELECT * | update table foo ";"' ) )
;
select f_gen_table_mockups( 'parser_grammar_rule_simple' ) 
from dual
;
   -- Rule 1: Expressions
--    ('<column_expression>', '<term> { ( "+" | "-" ) <term> }*'); 
    -- Rule 2: Terms
--    ('<term>', '<factor> { ( "*" | "/" ) <factor> }*');
    -- Rule 3: Factors
--    ('<factor>', 'identifier | literal | function_call | "(" <column_expression> ")"');

select * from table ( parser_rule_util. fn_1_ebnf_to_simple ( 
    '<term>', '<factor> { ( "*" | "/" ) <factor> }*'
    , p_source => 'manual_test' ) )
;
set serveroutput on 

WITH grama AS ( 
    SELECT content txt 
--    '<term>::=<factor> { ( "*" | "/" ) <factor> }*'
    FROM temp_clob 
    WHERE upper("REMARKS") = upper(:source)
)
SELECT t.*
FROM grama 
CROSS JOIN 
    TABLE ( parser_rule_util. fn_ebnf_clob_to_simple ( 
        grama.txt 
    , p_source => :source 
    ) ) t
    ;

set serveroutput on 
;
--declare x clob; BEGIN 
    select parser_grammar_gen. fn_get_parser_package_code ( p_source => 'PLSQL_EXCLUDING_SQL' , p_spec_body_mask => 2 ) 
--    into x 
    from dual
    ;
--END;
--/

-- result of lexer 
SELECT * 
    FROM TABLE ( 
        plsql_lexer.tokenize_code ( 
       'DECLARE
       v_msg VARCHAR2(100) := q''!It''s a "Q" string delimiter block!''; -- inline comment
       v_num NUMBER := 123.45;
     BEGIN
       /* Multi line block 
          evaluation check */
       IF v_num <> 0 THEN
          DBMS_OUTPUT.PUT_LINE(v_msg);
       END IF;
     END;'
     ||'/*'||rpad( '.', 500, '.' )||'*/'
     ) )
;

sta "C:\Users\Bon-Minh Lam\plsql_parser\supporting_objects\lam\packages\test-generated-parser.sql"