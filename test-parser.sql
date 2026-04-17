sta "/Users/bmlam/Library/Mobile Documents/com~apple~CloudDocs/github_2_privat/plsql_parser/supporting_objects/lam/tables/parser_source_module.sql"

sta "/Users/bmlam/Library/Mobile Documents/com~apple~CloudDocs/github_2_privat/plsql_parser/supporting_objects/lam/procedures/pr_parser_add_alt_tokens.sql"

sta "/Users/bmlam/Library/Mobile Documents/com~apple~CloudDocs/github_2_privat/plsql_parser/supporting_objects/lam/tables/parser_alt_tokens.sql"

sta "/Users/bmlam/Library/Mobile Documents/com~apple~CloudDocs/github_2_privat/plsql_parser/supporting_objects/lam/packages/parser_grammar_gen-impl.sql" 

sta "/Users/bmlam/Library/Mobile Documents/com~apple~CloudDocs/github_2_privat/plsql_parser/supporting_objects/lam/functions/bnf_to_insert_stmts.sql" 

set serveroutput on
select parser_grammar_gen.get_parser_code_v2  from dual
;
select parser_grammar_gen.get_parser_package_code( 'XXX')  from dual
;
select content
, bnf_to_insert_stmts ( content )
from test_clob 
where id = 1
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
select 
 length( t.rhs ) len_rhs
,t.*
from parser_grammar_rules t
where 1=1
--  and instr ( lower(lhs), 'block' ) > 0
  and instr ( lower(rhs), '|' ) > 0
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
from table ( parser_grammar_gen.tokenize_rhs_refined ( 'SELECT * | update table foo' ) )
;
declare 
    v_tokens parser_rule_token_col;
    c_rhs VARCHAR2( 1000 ) := 
        '"DECLARE" <declaration_section> "BEGIN" <executable_section> ["EXCEPTION" <exception_section>] "END" [<identifier>] ";"
          | "BEGIN" <executable_section> ["EXCEPTION" <exception_section>] "END" [<identifier>] ";"' 
          ;
begin 
    v_tokens := parser_grammar_gen.tokenize_rhs_refined ( c_rhs );
    pr_parser_add_alt_tokens ( p_lhs=> 'BLOCK', p_tokens  => v_tokens);
end;
/