drop table Branch cascade constraints;
drop table Client cascade constraints;
drop table Owner cascade constraints;
drop table Employee cascade constraints;
drop table House cascade constraints;
drop table Client_Visit cascade constraints;
drop type loc;
drop type name;



create type loc as object(
    City varchar2(20),
    Street varchar2(10),
    Post_Code number
);
/

create type name as object(
    First_Name varchar2(10),
    Last_Name varchar2(10)
);
/
create table Branch(
    BID varchar2(5) not null,
    Name name,
    Location loc,
    constraint PK_BID PRIMARY KEY(BID)
);



create table Client(
    CID varchar2(10) not null,
    Name name,
    Phone_Number number,
    Email varchar2(20),
    Pref_AC varchar2(10),
    Max_Rent number,
    constraint PK_CID PRIMARY KEY(CID)
);


create table Owner(
    OID varchar2(20) not null,
    Name name,
    Phone_Number number,
    Email varchar2(20),
    Password varchar2(30),
    constraint PK_OID PRIMARY KEY(OID)
);


create table House(
    HID varchar2(20) not null,
    Type varchar2(10) ,
    Rooms number,
    Location loc,
    constraint PK_HID PRIMARY KEY(HID)
);

create table Employee(
    EID varchar2(20) not null,
    Name name,
    Sex CHAR(1),
    DOB DATE,
    Position varchar2(10),
    Salary number,
    constraint PK_EID PRIMARY KEY(EID)
);

--M to M
-- Client and House 
create table Client_Visit(
    HID varchar2(20) not null,
    CID varchar2(20) not null,
    constraint PK_CL PRIMARY key(HID,CID),
    constraint FK_CLa FOREIGN key(CID) references Client(CID),
    constraint FK_CLb FOREIGN key(HID) references House(HID)
);

--1 to M
-- Employee and Branch
alter table Employee add BID varchar2(20);
alter table Employee add constraint FKE_BID FOREIGN KEY(BID) references Branch(BID);

--1 to 1
-- Employee and Client
alter table Employee add CID varchar2(20);
alter table Employee add constraint FKE_CID FOREIGN KEY(CID) references Client(CID);
alter table Employee add constraint UKE_CID unique(CID);


-- House and Branch
alter table House add BID varchar2(20);
alter table House add constraint FKH_BID FOREIGN KEY(BID) references Branch(BID);



-- House and Employee
alter table House add EID varchar2(20);
alter table House add constraint FKH_EID FOREIGN KEY(EID) references Employee(EID);
alter table House add constraint UKH_EID unique(EID);

-- House and Owner
alter table House add OID varchar2(20);
alter table House add constraint FKH_OID FOREIGN KEY(OID) references Owner(OID);


-- Client and Branch
alter table Client add BID varchar2(20);
alter table Client add constraint FKC_BID FOREIGN KEY(BID) references Branch(BID);
