CREATE OR REPLACE PACKAGE parser_grammar_gen IS

   FUNCTION get_parser_code_v1 
      (p_package_name   VARCHAR2
      ,p_type           VARCHAR2 DEFAULT 'ALL'
      ) 
   RETURN CLOB
   ;
   FUNCTION first_condition(p_rhs VARCHAR2) RETURN VARCHAR2
   ;
   --
   FUNCTION get_parser_code_v2 
   RETURN CLOB
   ;
END;
/


