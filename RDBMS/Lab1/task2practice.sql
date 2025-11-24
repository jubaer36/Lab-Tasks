CREATE OR REPLACE FUNCTION IsPrimeNumber(x NUMBER) 
    RETURN BOOLEAN 
IS
    divBy NUMBER:= 2;
BEGIN 
    IF x < 2 THEN  RETURN FALSE;
    END IF;
    WHILE divBy <= sqrt(x) LOOP     
        IF MOD(x , divBy) = 0 THEN RETURN FALSE;
        END IF;
        divBy := divBy + 1;
    END LOOP;
    RETURN TRUE;  
END;
/
        

CREATE OR REPLACE PROCEDURE PrintPrimes(x NUMBER)
AS  
    sum_of_primes NUMBER := 0;
    current_number NUMBER := 2;
BEGIN
    WHILE sum_of_primes <= x LOOP
        if IsPrimeNumber(current_number) THEN
            sum_of_primes := sum_of_primes + current_number;
            DBMS_OUTPUT.PUT_LINE('Prime Number: ' || current_number);
        END IF;
        current_number := current_number + 1;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('Sum of Primes: ' || sum_of_primes);
END;
/
    


EXECUTE PrintPrimes(20);
-- Alternatively:
-- BEGIN
--   PrintPrimes(20);
-- END;
-- /



