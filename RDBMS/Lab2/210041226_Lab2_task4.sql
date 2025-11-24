CREATE OR REPLACE PROCEDURE update_account_balances IS
    days_elapsed NUMBER;
    interest_amt NUMBER;
BEGIN

    UPDATE Accounts a
    SET a.Balance = a.Balance + ((a.Balance * ap.interestRate) / 100),
        a.LastDateofInterest = SYSDATE
    FROM AccountProperties ap
    WHERE a.ID = ap.ID 
    AND ap.GP = 1;

 
    UPDATE Accounts a
    SET a.Balance = a.Balance + ((a.Balance * ap.interestRate * 30) / 100),
        a.LastDateofInterest = SYSDATE
    FROM AccountProperties ap
    WHERE a.ID = ap.ID
    AND ap.GP = 2;

    
    UPDATE Accounts a
    SET a.Balance = a.Balance + ((a.Balance * ap.interestRate * 365) / 100),
        a.LastDateofInterest = SYSDATE
    FROM AccountProperties ap
    WHERE a.ID = ap.ID
    AND ap.GP = 3;

END update_account_balances;
/
