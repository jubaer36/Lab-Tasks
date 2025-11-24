SET SERVEROUTPUT ON;

DECLARE
  s NUMBER := 20;
  primes VARCHAR2(4000);

  FUNCTION prime_generator(s IN NUMBER)
  RETURN VARCHAR2 IS
    sum_of_primes NUMBER := 0;
    current_number NUMBER := 2;
    result VARCHAR2(4000) := '';
  
    -- Function to check if a number is prime
    FUNCTION is_prime(n IN NUMBER) RETURN BOOLEAN IS
      i NUMBER;
    BEGIN
      IF n < 2 THEN
        RETURN FALSE;
      END IF;
      FOR i IN 2..FLOOR(SQRT(n)) LOOP
        IF n MOD i = 0 THEN
          RETURN FALSE;
        END IF;
      END LOOP;
      RETURN TRUE;
    END is_prime;
  
  BEGIN
    -- Looping to find primes and sum them
    WHILE sum_of_primes + current_number <= s LOOP
      IF is_prime(current_number) THEN
        -- Adding the prime number to the result string
        result := result || current_number || ', ';
        sum_of_primes := sum_of_primes + current_number;
      END IF;
      current_number := current_number + 1;
    END LOOP;

  
    RETURN result;
  END prime_generator;

BEGIN
  -- Calling the prime_generator function and displaying the result
  primes := prime_generator(s);
  DBMS_OUTPUT.PUT_LINE('Primes: ' || primes);
END;
/
