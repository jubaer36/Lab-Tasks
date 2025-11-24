DECLARE
  current_year NUMBER;
  start_of_decade NUMBER;
BEGIN
  -- Getting the current year
  current_year := EXTRACT(YEAR FROM SYSDATE);

  -- Checking if the current year is the starting year of a new decade
  IF MOD(current_year, 10) = 0 THEN
    DBMS_OUTPUT.PUT_LINE('Yes Current Year '|| TO_CHAR(current_year) || ' is the starting of a new decade');
  ELSE
    DBMS_OUTPUT.PUT_LINE('No Current Year '|| TO_CHAR(current_year) || ' is not the starting of a new decade');
  END IF;

  -- Calculating the start of the current decade
  start_of_decade := current_year - MOD(current_year, 10);

  DBMS_OUTPUT.PUT_LINE('The start of the current decade is the ' || TO_CHAR(start_of_decade) || 's');
END;
/
