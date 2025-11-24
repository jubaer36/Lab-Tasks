
drop table Depts cascade constraints;
drop table Students cascade constraints;
drop table Employees cascade constraints;


CREATE TABLE Depts (
    NAME VARCHAR(255) PRIMARY KEY,
    LOCATION VARCHAR(255),
    SIZE VARCHAR2(10)
);

-- Students Table
CREATE TABLE Students (
    ID INT PRIMARY KEY,
    NAME VARCHAR(255),
    CGPA FLOAT,
    DEPT VARCHAR(255),
    FOREIGN KEY (DEPT) REFERENCES Depts(NAME)
);

-- Employees Table
CREATE TABLE Employees (
    ID INT PRIMARY KEY,
    NAME VARCHAR(255),
    DEPT VARCHAR(255),
    JOININGDATE DATE,
    FOREIGN KEY (DEPT) REFERENCES Depts(NAME)
);

