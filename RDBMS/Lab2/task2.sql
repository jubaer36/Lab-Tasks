DROP TABLE transactions;
DROP TABLE loan_type;

CREATE TABLE transactions(
    user_id INT primary key,
    amount NUMBER ,
    t_date DATE
);

CREATE TABLE loan_type(
    scheme INT primary key,
    installment_number NUMBER ,
    charge NUMBER,
    min_trans NUMBER
);

INSERT into transactions (user_id , amount , t_date) 
VALUES(101,50000, TO_DATE('2022-04-12' , 'YYYY-DD-MM'));

INSERT into transactions (user_id , amount , t_date) 
VALUES(102,1200000, TO_DATE('2021-04-12' , 'YYYY-DD-MM'));

INSERT into transactions (user_id , amount , t_date) 
VALUES(103,1800000, TO_DATE('2022-05-2' , 'YYYY-DD-MM'));

INSERT into transactions (user_id , amount , t_date) 
VALUES(104,700000, TO_DATE('2021-04-12' , 'YYYY-DD-MM'));

INSERT INTO loan_type( scheme , installment_number , charge , min_trans )
VALUES (1, 30, 5, 2000000); 

INSERT INTO loan_type (Scheme, Installment_Number, Charge, Min_Trans)
VALUES (2, 20, 10, 1000000); 

INSERT INTO loan_type (Scheme, Installment_Number, Charge, Min_Trans)
VALUES (3, 15, 15, 500000); 

create or replace function getLoanScheme(user_id in INT) RETURN NUMBER 
IS
    loanScheme NUMBER;
    totalTrans NUMBER;
    scheme NUMBER;
    min_trans NUMBER;
    cursor c1 IS
       select loan_type.scheme, loan_type.min_trans from loan_type order by min_trans desc;
BEGIN
    select sum(amount) into totalTrans from transactions where transactions.user_id = user_id;
    open c1;
    loop
        fetch c1 into scheme , min_trans;
        exit when c1%NOTFOUND;
        if totalTrans >= min_trans then
            loanScheme := scheme;
            exit;
        end if;
    END LOOP;
    close c1;
    return loanScheme;
END;
/

BEGIN
    dbms_output.put_line('loan Scheme: '|| getLoanScheme(101));
END;
/






