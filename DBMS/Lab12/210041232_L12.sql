drop table Balance cascade constraints;
drop table Transaction cascade constraints;
drop table Account cascade constraints;
drop table AccountProperty cascade constraints;

create table AccountProperty
(
	ID int,
	Name varchar2(20),
	ProfitRate number,
	GracePeriod int,
	constraint pkAP primary key (ID)
);
create table Account
(
	ID int,
	Name varchar2(20),
	AccCode int,
	OpeningDate date,
	LastDateInterest date,
	constraint pk_account primary key (ID),
	constraint fk_account foreign key (AccCode) references AccountProperty(ID)
);
create table Transaction
(
	TID int primary key,
	AccNo int,
	Amount number,
	TransactionDate date,
	constraint fk_transaction foreign key(AccNo) references Account(ID)
);
create table Balance
(
	AccNo int,
	PrincipalAmount number,
	ProfitAmount number,
	constraint fk_balance foreign key (AccNo) references Account(ID),
	constraint pk_balance primary key (AccNo)
);

insert into AccountProperty values (2002, 'Monthly', 2.8, 1);
insert into AccountProperty values (3003, 'Quarterly', 4.2, 4);
insert into AccountProperty values (4004, 'Biyeraly', 6.8, 6);
insert into AccountProperty values (5005, 'Yearly', 8, 12);

insert into Account values (10,'Rafid', 2002, '12-NOV-2017', '12-JAN-2022');
insert into Account values (12, 'Faheem', 3003, '12-NOV-2018', '12-JAN-2021');
insert into Account values (14, 'Taimum', 4004, '12-NOV-2019', '12-DEC-2022');

insert into Transaction values(1, 10, 1000, '10-JAN-2023');
insert into Transaction values(2, 12, 1000, '11-JAN-2023');
insert into Transaction values(3, 14, 1000, '12-JAN-2023');

insert into Balance values (10, 500, 50);
insert into Balance values (12, 700, 50);
insert into Balance values (14, 600, 50);


--Task 1
CREATE SEQUENCE serial
    START WITH 1
    INCREMENT BY 1
    MINVALUE 1
    MAXVALUE 999999
    CACHE 20;

CREATE OR REPLACE FUNCTION ACCOUNT_ID_GENERATOR(NAME IN VARCHAR2,ACC_CODE IN INT,Opening_Date in DATE) 
RETURN varchar2
AS
    ac_name varchar2(20);
    ac_code varchar2(20);
    o_date varchar2(20);
    serial_no varchar2(20);

BEGIN
    ac_code:= to_char(ACC_CODE);
    ac_name:= substr(NAME,1,3);
    o_date:= to_char(Opening_Date,'YYYYMMDD');
    serial_no:=to_char(serial.nextval);

    return ac_code|| o_date||'.'||ac_name||'.'|| serial_no;
END;
/
DECLARE 
    result varchar2(100);
begin
    result := ACCOUNT_ID_GENERATOR('Rafid', 32, TO_DATE('12-NOV-2017', 'DD-MON-YYYY'));
    DBMS_OUTPUT.PUT_LINE(result);
end;
/

--Task 2

delete from Account;
delete from Balance;
delete from Transaction;

Alter table Balance drop constraint fk_balance;
Alter table Transaction drop constraint fk_transaction;
Alter table Account drop constraint pk_account;

--Task 3

CREATE OR REPLACE TRIGGER account_id_trigger
BEFORE INSERT ON Account
FOR EACH ROW
BEGIN 
    :NEW.Account_id := ACCOUNT_ID_GENERATOR(:NEW.Name, :NEW.AccCode,:NEW.OpeningDate);
END;
/

--Task 4

CREATE OR REPLACE TRIGGER balance_trigger
AFTER INSERT ON Account
FOR EACH ROW
BEGIN
    INSERT INTO Balance VALUES (:NEW.Account_id, 5000, 0);
END;
/


--Task 5

CREATE OR REPLACE TRIGGER transaction_trigger
AFTER INSERT ON Transaction
FOR EACH ROW
BEGIN
    UPDATE Balance
    SET PrincipalAmount=PrincipalAmount+ :NEW.Amount
    WHERE AccNo = :NEW.AccNo;
END;
/