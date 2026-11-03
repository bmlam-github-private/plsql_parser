--DROP TYPE plsql_ast_node_col;









CREATE OR REPLACE FORCE TYPE plsql_ast_node_rec 
AS OBJECT 
(  node_id         NUMBER 
  ,parent_node_id  NUMBER 
  ,node_type       VARCHAR2(100) 
  ,node_value      CLOB 
  ,sibling_order   NUMBER 
  ,source_line     NUMBER                         -- Start line
  ,source_col      NUMBER                         -- Start column
  ,end_line        NUMBER                         -- End line (for highlighting/ranges)
  ,end_col         NUMBER                         -- End column
);
/
--
CREATE OR REPLACE FORCE TYPE plsql_ast_node_col AS TABLE OF plsql_ast_node_rec
;
/