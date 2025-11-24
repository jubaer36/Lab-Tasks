CREATE TABLE Library_Borrowing (
    B_ID NUMBER PRIMARY KEY,
    Name VARCHAR2(100),
    Book_Title VARCHAR2(100),
    Borrow_Date DATE,
    Due_Date DATE,
    Returned_Date DATE
);

INSERT INTO Library_Borrowing (B_ID, Name, Book_Title, Borrow_Date, Due_Date, Returned_Date) VALUES
(1, 'John Doe', 'The Great Gatsby', TO_DATE('2024-08-01', 'YYYY-MM-DD'), TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-20', 'YYYY-MM-DD')),
(2, 'Jane Smith', '1984', TO_DATE('2024-08-10', 'YYYY-MM-DD'), TO_DATE('2024-08-24', 'YYYY-MM-DD'), NULL),
(3, 'Alice Johnson', 'To Kill a Mockingbird', TO_DATE('2024-09-01', 'YYYY-MM-DD'), TO_DATE('2024-09-15', 'YYYY-MM-DD'), TO_DATE('2024-09-16', 'YYYY-MM-DD')),
(4, 'Bob Brown', 'Moby Dick', TO_DATE('2024-08-20', 'YYYY-MM-DD'), TO_DATE('2024-09-03', 'YYYY-MM-DD'), TO_DATE('2024-09-02', 'YYYY-MM-DD')),
(5, 'Charlie Adams', 'The Catcher in the Rye', TO_DATE('2024-09-05', 'YYYY-MM-DD'), TO_DATE('2024-09-19', 'YYYY-MM-DD'), NULL);

CREATE OR REPLACE FUNCTION Calculate_Late_Fee(p_B_ID NUMBER) RETURN NUMBER IS
    v_Late_Fee NUMBER := 0;
    v_Due_Date DATE;
    v_Returned_Date DATE;
    v_Current_Date DATE := SYSDATE;
BEGIN
    SELECT Due_Date, Returned_Date INTO v_Due_Date, v_Returned_Date
    FROM Library_Borrowing
    WHERE B_ID = p_B_ID;

    IF v_Returned_Date IS NULL THEN
        v_Returned_Date := v_Current_Date;
    END IF;

    IF v_Returned_Date > v_Due_Date THEN
        v_Late_Fee := (v_Returned_Date - v_Due_Date) * 1;
    END IF;

    RETURN v_Late_Fee;
END Calculate_Late_Fee;

CREATE OR REPLACE PROCEDURE List_Overdue_Books IS
    v_Current_Date DATE := SYSDATE;
    CURSOR c_Overdue IS
        SELECT Name, Book_Title, Due_Date, 
               CASE 
                   WHEN Due_Date < v_Current_Date THEN (v_Current_Date - Due_Date) 
                   ELSE 0 
               END AS Days_Overdue
        FROM Library_Borrowing
        WHERE Returned_Date IS NULL AND Due_Date < v_Current_Date;

BEGIN
    FOR r IN c_Overdue LOOP
        DBMS_OUTPUT.PUT_LINE(r.Name || ' has not yet returned the book "' || r.Book_Title || '".');
        DBMS_OUTPUT.PUT_LINE('The book is overdue by ' || r.Days_Overdue || ' days.');
    END LOOP;

    FOR r IN (SELECT Name, Book_Title, Due_Date 
              FROM Library_Borrowing 
              WHERE Returned_Date IS NULL AND Due_Date >= v_Current_Date) LOOP
        DBMS_OUTPUT.PUT_LINE(r.Name || ' has not yet returned the book "' || r.Book_Title || '".');
        DBMS_OUTPUT.PUT_LINE('The book is due soon.');
    END LOOP;
END List_Overdue_Books;

SET SERVEROUTPUT ON;

EXEC List_Overdue_Books;
