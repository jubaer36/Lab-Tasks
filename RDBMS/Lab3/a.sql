SELECT * FROM (SELECT Customer_Name, Customer_ID , Lifetime_Usage 
FROM Customers C , Subscriptions S
WHERE C.Subscription_ID = S.Subscription_ID
ORDER BY Lifetime_Usage DESC) WHERE ROWNUM <=5;


SELECT C.Customer_Name, C.Date_of_Birth, A.District, A.Division
FROM Customers C,  Subscriptions S , Addresses A
WHERE C.Subscription_ID = S.Subscription_ID
AND C.Address_ID = A.Address_ID AND
S.Lifetime_Usage > (
    SELECT AVG(Lifetime_Usage)
    FROM Subscriptions
    WHERE Subscriber_Type = 'Prepaid' AND Subscriber_Level = 'Silver');


SELECT COUNT(*) FROM (SELECT C.Customer_Name, C.Date_of_Birth, A.District, A.Division
FROM Customers C,  Subscriptions S , Addresses A
WHERE C.Subscription_ID = S.Subscription_ID
AND C.Address_ID = A.Address_ID AND
S.Lifetime_Usage > (
    SELECT AVG(Lifetime_Usage)
    FROM Subscriptions
    WHERE Subscriber_Type = 'Prepaid' AND Subscriber_Level = 'Silver'
) AND A. Division = 'Dhaka');

SELECT COUNT(*) AS Customer_Count
FROM Customers C
JOIN Subscriptions S
ON C.Subscription_ID = S.Subscription_ID
JOIN Addresses A
ON C.Address_ID = A.Address_ID
WHERE S.Lifetime_Usage > (
    
    SELECT AVG(Lifetime_Usage)
    FROM Subscriptions
    WHERE Subscriber_Type = 'Prepaid' AND Subscriber_Level = 'Silver')
AND A.Division = 'Dhaka';

SELECT CONCAT('Mr./Ms. ', Customer_Name) AS Full_Name
FROM Customers;

SELECT INITCAP(Customer_Name) AS Capitalized_Name
FROM Customers;

SELECT Customer_Name, INSTR(Customer_Name, 'an')
FROM Customers
WHERE INSTR(Customer_Name, 'an') > 0;

SELECT LOWER(Customer_Name) AS Lowercase_Name
FROM Customers;

SELECT Customer_Name, LENGTH(Customer_Name) AS Name_Length
FROM Customers;
SELECT LPAD(Customer_Name, 15, '*') AS Padded_Name
FROM Customers;
