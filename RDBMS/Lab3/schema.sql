CREATE TABLE Customers (
    Customer_ID NUMBER PRIMARY KEY,
    Customer_Name VARCHAR2(100),
    Date_of_Birth DATE,
    Address_ID NUMBER,
    Subscription_ID NUMBER
);
 
CREATE TABLE Addresses (
    Address_ID NUMBER PRIMARY KEY,
    Division VARCHAR2(50),
    District VARCHAR2(50)
);
 
CREATE TABLE Subscriptions (
    Subscription_ID NUMBER PRIMARY KEY,
    Subscriber_Type VARCHAR2(10),
    Subscriber_Level VARCHAR2(10),
    Lifetime_Usage NUMBER
);
 
INSERT INTO Addresses 
VALUES (1, 'Dhaka', 'Dhaka');
 
INSERT INTO Addresses 
VALUES (2, 'Khulna', 'Jessore');
 
INSERT INTO Addresses 
VALUES (3, 'Chittagong', 'Comilla');
 
INSERT INTO Addresses 
VALUES (4, 'Dhaka', 'Gazipur');
 
INSERT INTO Addresses 
VALUES (5, 'Sylhet', 'Sylhet');

INSERT INTO Addresses 
VALUES (6, 'Dhaka', 'Narayanganj');
 
INSERT INTO Addresses 
VALUES (7, 'Sylhet', 'Sunamganj');
 
INSERT INTO Subscriptions 
VALUES (1, 'Prepaid', 'Silver', 5000);
 
INSERT INTO Subscriptions 
VALUES (2, 'Postpaid', 'Gold', 20000);
 
INSERT INTO Subscriptions 
VALUES (3, 'Prepaid', 'Bronze', 3000);
 
INSERT INTO Subscriptions 
VALUES (4, 'Postpaid', 'Platinum', 40000);

INSERT INTO Subscriptions 
VALUES (5, 'Postpaid', 'Gold', 20000);
 
INSERT INTO Subscriptions 
VALUES (7, 'Prepaid', 'Bronze', 3000);
 
INSERT INTO Subscriptions 
VALUES (8, 'Postpaid', 'Platinum', 40000);
 
INSERT INTO Subscriptions 
VALUES (6, 'Prepaid', 'Silver', 7000);
 
INSERT INTO Customers 
VALUES (1, '  john Doe', TO_DATE('1990-05-10', 'YYYY-MM-DD'), 1, 1);
 
INSERT INTO Customers 
VALUES (2, 'Jane smith  ', TO_DATE('1985-12-25', 'YYYY-MM-DD'), 2, 2);
 
INSERT INTO Customers 
VALUES (3, 'ahmed khan', TO_DATE('1975-07-15', 'YYYY-MM-DD'), 3, 3);
 
INSERT INTO Customers 
VALUES (4, 'lisa Rahman', TO_DATE('1992-03-09', 'YYYY-MM-DD'), 4, 4);
 
INSERT INTO Customers 
VALUES (5, 'Samiul Islam', TO_DATE('1988-11-19', 'YYYY-MM-DD'), 5, 5);
INSERT INTO Customers 
VALUES (6, 'AHMEDDD BAN', TO_DATE('1975-03-15', 'YYYY-MM-DD'), 6, 3);
 
INSERT INTO Customers 
VALUES (7, 'Blisa Rahman', TO_DATE('1996-03-09', 'YYYY-MM-DD'), 6, 4);
 
INSERT INTO Customers 
VALUES (8, 'Miul Islam', TO_DATE('1984-11-19', 'YYYY-MM-DD'), 1, 5);

commit;