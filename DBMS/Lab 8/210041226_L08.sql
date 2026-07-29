
create table Employee(
    EID number(6,0) primary key,
    Name varchar2(30 char),
    DOB date,
    Dept varchar2(20),
    ContactNo number(11,0),
    District varchar2(20),
    foreign key(District)references District(DisName)
);
create table District(
    DisName varchar2(20) primary key,
    Division varchar2(20) ,
    foreign key Division references Division(DivName)
);
create table Division(
    DivName varchar2(20) primary key
);

create table Branch(
    BID number(6,0)primary key,
    BrName varchar2(20),
    District varchar2(20),
    foreign key District references District(DisName)
);
create table Customer(  
    CID number(8,0) primary key,
    Name varchar2(30 char),
    ContactNo number(11,0),
    District varchar2(20),
    foreign key District references District(DisName)
);
create table Item(
    ItemID number(7,0)primary key,
    Name varchar2(20),
    Desc varchar2(60) ,
    Price number(7,0),
    CustomerID number(8,0),
    foreign key CustomerID references Customer(CID)
);

create table Rent(
    duration varchar2(10),
    IID number(7,0),
    EID number(6,0),
    foreign key IID references Item(ItemID),
    foreign key EID references Employee(EID),
    constraint PK_Rent primary key (IID,EID)
)