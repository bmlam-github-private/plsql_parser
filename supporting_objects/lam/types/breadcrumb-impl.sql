CREATE OR REPLACE TYPE BODY Breadcrumb AS
  CONSTRUCTOR FUNCTION Breadcrumb(SELF IN OUT NOCOPY Breadcrumb) RETURN SELF AS RESULT IS
    v_depth PLS_INTEGER := UTL_CALL_STACK.DYNAMIC_DEPTH;
  BEGIN
  /*
    SELF.object_id := DBMS_UTILITY.GET_HASH_VALUE(TO_CHAR(SYSTIMESTAMP), 1, 1000000);
    SELF.created_at := SYSTIMESTAMP;
    
    -- Print the line number of the subprogram that instantiated this object
    DBMS_OUTPUT.PUT_LINE('[Breadcrumb] CONSTRUCTOR invoked at line: ' || 
                         UTL_CALL_STACK.UNIT_LIne(v_depth - 1)
                         ||' of '||UTL_CALL_STACK.CONCATENATE_SUBPROGRAM(
                           UTL_CALL_STACK.SUBPROGRAM(v_depth -1) )
						 );
						 */ 
    RETURN;
  END;

  MEMBER PROCEDURE destroy(SELF IN OUT NOCOPY Breadcrumb) IS
    v_depth PLS_INTEGER := UTL_CALL_STACK.DYNAMIC_DEPTH;
  BEGIN
    -- Print the line number where destroy was explicitly called before scope exit
    null; -- DBMS_OUTPUT.PUT_LINE('[Breadcrumb] DESTRUCTOR invoked at line: ' ||                          UTL_CALL_STACK.UNIT_LIne(v_depth - 1));
  END;
END;
/
