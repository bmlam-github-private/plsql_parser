CREATE TABLE parser_grammar_rule_ebnf (	-- previous name parser_grammar_rules ! 
     rule_id        NUMBER   GENERATED ALWAYS AS IDENTITY
    ,lhs            VARCHAR2(100)	NOT NULL 
    ,rhs            VARCHAR2(4000)	NOT NULL  
    ,seq            NUMBER
    ,comments       VARCHAR2(4000)	NOT NULL 
)
/

ALTER TABLE parser_grammar_rule_ebnf ADD PRIMARY KEY (rule_id)
/

--ALTER TABLE parser_grammar_rule_ebnf ADD UNIQUE ( lhs, rhs )
--/

ALTER TABLE parser_grammar_rule_ebnf RENAME COLUMN comments TO source
/


set serveroutput on 
BEGIN 
	FOR r IN ( 
		WITH uk_cols AS (
			SELECT cn.table_name, cn.constraint_name
				, listagg( column_name , ',' ) WITHIN GROUP ( ORDER BY position )	AS col_list 
			FROM user_cons_columns col 
			JOIN user_constraints  cn 	ON cn.constraint_name = col.constraint_name 
			WHERE cn.constraint_type 	= 'U' 
			  AND cn.table_name 		= 'PARSER_GRAMMAR_RULE_EBNF'
			GROUP BY cn.table_name, cn.constraint_name
		)
		SELECT constraint_name , table_name 
			, 'ALTER TABLE '||table_name||' DROP CONSTRAINT '||constraint_name 	AS ddl 
		FROM uk_cols 
		WHERE col_list = 'LHS,RHS'
	) LOOP 
		dbms_output.put_line ( r.ddl );
		EXECUTE IMMEDIATE  r.ddl;
	END LOOP;
END;
/

ALTER TABLE parser_grammar_rule_ebnf ADD UNIQUE ( lhs, rhs, source )
/

ALTER TABLE parser_grammar_rule_ebnf ADD CONSTRAINT parser_grammar_rules_lhs_ck CHECK ( lower( trim(lhs) ) = lhs )
/

COMMENT ON TABLE parser_grammar_rule_ebnf IS 
'Populated based on EBNF rules from different sources  
'
/

COMMENT ON COLUMN parser_grammar_rule_ebnf.source IS 
'Possibly sources or major node and children nodes of a PLSQL construct 
'
/

