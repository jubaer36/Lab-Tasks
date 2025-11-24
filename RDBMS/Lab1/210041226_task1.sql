CREATE TABLE Users (
    Username VARCHAR2(50),
    Password_Length NUMBER
);
INSERT INTO Users (Username, Password_Length) VALUES ('User1', 4);
INSERT INTO Users (Username, Password_Length) VALUES ('User2', 7);
INSERT INTO Users (Username, Password_Length) VALUES ('User3', 6);
INSERT INTO Users (Username, Password_Length) VALUES ('User4', 8);

COMMIT;

SET SERVEROUTPUT ON;

DECLARE
    highest_password_length NUMBER;
    permutations NUMBER := 1;
BEGIN
    -- Find the highest password length
    SELECT MAX(Password_Length)
    INTO highest_password_length
    FROM Users;

    -- Calculate permutations for the highest password length
    FOR i IN 0..highest_password_length - 1 LOOP
        permutations := permutations * (52 - i);
    END LOOP;

    -- Output the result
    DBMS_OUTPUT.PUT_LINE('Highest Password Length: ' || highest_password_length);
    DBMS_OUTPUT.PUT_LINE('Permutations to crack the password: ' || permutations);
END;
/
