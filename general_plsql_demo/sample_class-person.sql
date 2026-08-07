REM as example syntax of CLASS 
CREATE OR REPLACE TYPE person_obj AS OBJECT (
    -- Attributes
    name VARCHAR2(100),
    age  NUMBER,
    sex  VARCHAR2(10),

    -- Custom Constructor Function Signature
    CONSTRUCTOR FUNCTION person_obj(
        p_name IN VARCHAR2,
        p_age  IN NUMBER,
        p_sex  IN VARCHAR2
    ) RETURN SELF AS RESULT,

    -- Print Method Signature
    MEMBER PROCEDURE print_details
);
/

CREATE OR REPLACE TYPE BODY person_obj AS

    -- Custom Constructor Implementation
    CONSTRUCTOR FUNCTION person_obj(
        p_name IN VARCHAR2,
        p_age  IN NUMBER,
        p_sex  IN VARCHAR2
    ) RETURN SELF AS RESULT IS
    BEGIN
        -- Assign values to the object attributes (SELF)
        SELF.name := UPPER(p_name); -- Example logic: normalize name to uppercase
        SELF.age  := p_age;
        SELF.sex  := UPPER(p_sex);
        
        RETURN;
    END person_obj;

    -- Print Method Implementation
    MEMBER PROCEDURE print_details IS
    BEGIN
        DBMS_OUTPUT.PUT_LINE('--- Person Details ---');
        DBMS_OUTPUT.PUT_LINE('Name : ' || SELF.name);
        DBMS_OUTPUT.PUT_LINE('Age  : ' || SELF.age);
        DBMS_OUTPUT.PUT_LINE('Sex  : ' || SELF.sex);
    END print_details;

END;
/

SET SERVEROUTPUT ON;

DECLARE
    -- Instantiate using our custom constructor
    v_person person_obj := person_obj(p_name=>'Jane Doe', p_age=>29, p_sex=> 'Female');
BEGIN
    -- Call the print method
    v_person.print_details;
END;
/