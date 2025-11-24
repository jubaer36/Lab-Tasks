

drop table students;

CREATE TABLE students(
    student_id NUMBER PRIMARY KEY,
    attendance NUMBER,
    quiz NUMBER,
    mid_term NUMBER,
    final_exam NUMBER
);

INSERT into students(student_id , attendance , quiz , mid_term , final_exam) values(
   1, 8 , 11 , 23, 43
);
INSERT into students(student_id , attendance , quiz , mid_term , final_exam) values(
   2, 8 , 11 , 20, 40
);
INSERT into students(student_id , attendance , quiz , mid_term , final_exam) values(
   3, 6 , 11 , 23, 50
);
INSERT into students(student_id , attendance , quiz , mid_term , final_exam) values(
   4, 8 , 12 , 22, 43
);
INSERT into students(student_id , attendance , quiz , mid_term , final_exam) values(
   5, 6 , 11 , 26, 43
);

SELECT * FROM students;

CREATE OR REPLACE PROCEDURE calculateTotal (student IN Number , total_marks OUT Number ) IS
attendance Number;
quiz NUMBER;
mid_term Number;
final_exam Number;
BEGIN
    SELECT attendance , quiz , mid_term , final_exam 
    into attendance , quiz , mid_term , final_exam 
    from students
    WHERE student = students.student_id;
    
    total_marks:= attendance + quiz + final_exam + mid_term;
END;
/
DECLARE 
    total_marks NUMBER;
BEGIN
    calculateTotal(1,total_marks);
    DBMS_OUTPUT.PUT_LINE('Total Marks: ' || total_marks);
END;
/

create or replace procedure calculateGrade (student IN Number , grade out varchar2) IS
total_marks Number;
BEGIN
    calculateTotal(student , total_marks);
    if total_marks >=90 THEN
        grade := 'A';
    ELSIF total_marks >=80 THEN
        grade := 'B';   
    ELSIF total_marks >=70 THEN
        grade := 'C';
    ELSIF total_marks >=60 THEN
        grade := 'D';
    ELSE
        grade := 'F';
    END IF;
END;
/
DECLARE
    grade varchar2(1);
    BEGIN
        calculateGrade(1,grade);
        DBMS_OUTPUT.PUT_LINE('Grade: ' || grade);
    END;
    /




