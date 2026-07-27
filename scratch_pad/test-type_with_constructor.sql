CREATE OR REPLACE TYPE test_token_rec AS OBJECT (
    c1 NUMBER,
    c2 VARCHAR2(10),
    c3 DATE,
    
    -- Custom constructor for legacy 2-parameter instantiations
    CONSTRUCTOR FUNCTION test_token_rec (
        p_c1 IN NUMBER,
        p_c2 IN VARCHAR2
    ) RETURN SELF AS RESULT
);
/








CREATE OR REPLACE TYPE BODY test_token_rec AS
    CONSTRUCTOR FUNCTION test_token_rec (
        p_c1 IN NUMBER,
        p_c2 IN VARCHAR2
    ) RETURN SELF AS RESULT IS
    BEGIN
        SELF.c1 := p_c1;
        SELF.c2 := p_c2;
        SELF.c3 := NULL; -- Explicitly set c3 to NULL
        RETURN;
    END;
END;
/
