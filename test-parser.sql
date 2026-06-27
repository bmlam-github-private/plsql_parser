sta "C:\Users\Bon-Minh Lam\plsql_parser\supporting_objects\lam\tables\parser_grammar_rules.sql"

sta "C:\Users\Bon-Minh Lam\plsql_parser\scratch_pad\gemini_dynamic_generator.sql"


sta "C:\Users\Bon-Minh Lam\plsql_parser\supporting_objects\lam\packages\parser_rule_util-def.sql"
sta "C:\Users\Bon-Minh Lam\plsql_parser\supporting_objects\lam\packages\parser_grammar_gen-def.sql"

sta "C:\Users\Bon-Minh Lam\plsql_parser\supporting_objects\lam\packages\parser_rule_util-impl.sql"
sta "C:\Users\Bon-Minh Lam\plsql_parser\supporting_objects\lam\packages\parser_grammar_gen-impl.sql"

select parser_grammar_gen.fn_get_parser_package_code( p_source => 'MANUAL_TEST' )  from dual
;
--rename parser_grammar_rules to parser_grammar_rule_ebnf
;
SELECT *
fROM parser_grammar_rule_simple 
where 1=1
-- lhs_root = '<<variable_or_function>>'
order by lhs 
;
select *
from parser_alt_token
WHERE 1=1
  and lower( lhs ) like '%assignm%'
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
select
 r.lhs, 
t.*
, length( t.content ) len 
--, dump( t.content ) dump 
from parser_grammar_rules r
CROSS JOIN 
table ( parser_grammar_gen.tokenize_rhs_refined ( r.rhs ) ) t
--where r.lhs = '<block>'

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

declare 
    x parser_grammar_rule_simple_col;
BEGIN 
    x := parser_rule_util. fn_ebnf_clob_to_simple ( 
    '<term>::=<factor> { ( "*" | "/" ) <factor> }*'
    , p_source => upper('manual_test') ) 
    ;
END ;
/

set serveroutput on size 1000000
;
DECLARE 
    x parser_alt_token_col;
    gram_clob   CLOB;
BEGIN 
    parser_rule_util. pr_set_global ( p_key=> 'max_nesting', p_value => 199 );
    parser_rule_util. pr_set_global ( p_key=> 'nesting_dump_loop', p_value => 9 );
    SELECT content 
    INTO gram_clob 
    FROM temp_clob
    where remarks = 'plsql_excluding_SQL'
    ;
    x := 
--select * from table ( 
--parser_rule_util. fn_ebnf_clob_to_simple 
    parser_rule_util. fn_grammar_clob_to_rule_tokens 
    (  p_clob => gram_clob
        , p_source => 'manual_test'  
        , p_persist => TRUE 
        , p_max_nesting => 999 
        )
-- if "select"        )
    ;
END;
/