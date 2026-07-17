SET SERVEROUTPUT ON;









DECLARE
	procedure p1 
	AS 
		v_crumb Breadcrumb := Breadcrumb();
	BEGIN 
		DBMS_OUTPUT.PUT_LINE('At line '||$$plsql_line); 
	END p1;
	-- 
	procedure p2 
	AS 
		v_crumb Breadcrumb := Breadcrumb();
	BEGIN 
		DBMS_OUTPUT.PUT_LINE('At line '||$$plsql_line); 
		p1; 
	END p2;
BEGIN
  DBMS_OUTPUT.PUT_LINE('Starting plsql block ...'); -- Line 6
    
  p2;
  DBMS_OUTPUT.PUT_LINE('plsql block  finished.'); -- Line 14
END;
/