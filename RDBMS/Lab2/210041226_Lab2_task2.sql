

DROP TABLE transactions;
DROP TABLE loan_type;

CREATE TABLE transactions (
    User_ID INT,
    Amount NUMBER(10, 2),
    T_Date DATE
);


CREATE TABLE loan_type (
    Scheme INT,
    Installment_Number INT,
    Charge NUMBER(5, 2),
    Min_Trans NUMBER(15, 2)
);


INSERT INTO transactions (User_ID, Amount, T_Date)
VALUES (101, 500000, TO_DATE('2023-01-01', 'YYYY-MM-DD'));

INSERT INTO transactions (User_ID, Amount, T_Date)
VALUES (102, 1200000, TO_DATE('2023-02-15', 'YYYY-MM-DD'));

INSERT INTO transactions (User_ID, Amount, T_Date)
VALUES (101, 1800000, TO_DATE('2023-03-10', 'YYYY-MM-DD'));

INSERT INTO transactions (User_ID, Amount, T_Date)
VALUES (103, 700000, TO_DATE('2023-04-20', 'YYYY-MM-DD'));

INSERT INTO loan_type (Scheme, Installment_Number, Charge, Min_Trans)
VALUES (1, 30, 5, 2000000); 

INSERT INTO loan_type (Scheme, Installment_Number, Charge, Min_Trans)
VALUES (2, 20, 10, 1000000); 

INSERT INTO loan_type (Scheme, Installment_Number, Charge, Min_Trans)
VALUES (3, 15, 15, 500000); 




CREATE OR REPLACE FUNCTION get_loan_scheme(p_user_id IN NUMBER) RETURN NUMBER
IS
    total_transactions NUMBER := 0;
    loan_scheme NUMBER := 0;

    CURSOR c_loan_types IS
        SELECT scheme, min_trans
        FROM loan_type
        ORDER BY min_trans DESC; 
BEGIN
    SELECT SUM(amount)
    INTO total_transactions
    FROM transactions
    WHERE user_id = p_user_id;

    FOR loan IN c_loan_types LOOP
        IF total_transactions >= loan.min_trans THEN
            loan_scheme := loan.scheme; 
            EXIT;
        END IF;
    END LOOP;
    
    RETURN loan_scheme;
END;
/

