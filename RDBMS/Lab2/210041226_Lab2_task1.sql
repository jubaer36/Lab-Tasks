DECLARE
    rows_affected NUMBER := 0;
BEGIN
    UPDATE employees 
    SET salary = salary * 1.1 
    WHERE designation = 'manager' AND salary < 30000;

    rows_affected := SQL%ROWCOUNT;
    
    UPDATE employees 
    SET salary = salary * 0.9 
    WHERE designation = 'assistant manager' AND salary > 20000;

       rows_affected := rows_affected + SQL%ROWCOUNT;

       DBMS_OUTPUT.PUT_LINE('Total rows affected: ' || rows_affected);
END;
/