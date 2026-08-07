CREATE OR REPLACE package TEST_CALL_STACK
AS 
	PROCEDURE level_1 ;
END;
/





CREATE OR REPLACE package BODY TEST_CALL_STACK
AS 
  g_stack_level NUMBER; 
	--
	  PROCEDURE level_2 IS
		PROCEDURE level_3 IS
		  PROCEDURE level_4 IS
			PROCEDURE level_5 IS
			  v_subprogram VARCHAR2(256);
			  v_line       NUMBER;
			  v_current_level NUMBER; 
			  v_padding_leven NUMBER;
			BEGIN
				v_current_level := UTL_CALL_STACK.dynamic_depth();
				DBMS_OUTPUT.put_line('Current nesting level: ' || v_current_level);			  DBMS_OUTPUT.put_line('--- Call Stack ---');

			  -- Dynamic depth 3 = Level 3 subprogram
			  -- Dynamic depth 4 = Level 2 subprogram
			  -- it seems idx starts at 0, while for humans top level start at 1 ! 
			  FOR idx IN REVERSE 1 ..  v_current_level 
			  LOOP
				-- Concatenate unit and subprogram name for readability
				v_subprogram := UTL_CALL_STACK.concatenate_subprogram(
								  UTL_CALL_STACK.subprogram(idx)
								);
				v_line       := UTL_CALL_STACK.unit_line(idx);
				v_padding_leven := v_current_level - idx + 1;
				DBMS_OUTPUT.put_line(
				  lpad('->',  v_padding_leven*2, ' ') || 
				  ' Ln:'     || v_line || 
				  ' :'  || v_subprogram
				);
			  END LOOP;
			END level_5;
		  BEGIN
			level_5;
		  END level_4;
		BEGIN
			g_stack_level := UTL_CALL_STACK.dynamic_depth();
			DBMS_OUTPUT.put_line('Ln'||$$plsql_line||' dynamic_depth: ' || g_stack_level);			  DBMS_OUTPUT.put_line('--- Call Stack ---');
		  level_4;
		END level_3;
	  BEGIN
		level_3;
	  END level_2;
--
	PROCEDURE level_1 IS
	BEGIN
	  level_2;
	END level_1;
END;	
/

SET SERVEROUTPUT ON 
begin 	test_call_stack.level_1; end;
/