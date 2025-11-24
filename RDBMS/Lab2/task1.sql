DECLARE 
    rows_affected NUMBER;
BEGIN
    UPDATE employees
    SET salary = salary * 1.1
    WHERE designation = 'manager' AND salary < 30000 ;

    rows_affected := sql%rowcount;

    UPDATE employees 
    SET salary = salary * .9 
    WHERE designation = 'assistant manager' AND salary > 20000;

    rows_affected := rows_affected + sql%rowcount;

    dbms_output.put_line('Rows affected: '|| rows_affected);
END;
/
