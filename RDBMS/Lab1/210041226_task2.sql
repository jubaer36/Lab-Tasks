CREATE OR REPLACE PROCEDURE addSpaces(normal_string IN VARCHAR2) IS
    spaced_string VARCHAR2(200);
BEGIN 
    spaced_string := SUBSTR(normal_string, 1, 1);

    FOR i IN 2..LENGTH(normal_string) LOOP
        spaced_string := spaced_string || ' ' || SUBSTR(normal_string, i, 1);
    END LOOP;

    DBMS_OUTPUT.PUT_LINE('Spaced String: ' || spaced_string);
END;
/

CREATE OR REPLACE PROCEDURE palindromeChecker(normal_string IN VARCHAR2) IS
    reversed_string VARCHAR2(200);
    i PLS_INTEGER;
BEGIN
    reversed_string := '';

    FOR i IN REVERSE 1..LENGTH(normal_string) LOOP
        reversed_string := reversed_string || SUBSTR(normal_string, i, 1);
    END LOOP;

    IF normal_string = reversed_string THEN
        DBMS_OUTPUT.PUT_LINE('Palindrome');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Not a Palindrome');
    END IF;
END;
/

SET SERVEROUTPUT ON;

EXEC addSpaces('racecar');
EXEC palindromeChecker('racecar');
/
