
SET SERVEROUTPUT ON;

-- Dropping procedures if they exist
BEGIN
  EXECUTE IMMEDIATE 'DROP PROCEDURE calculate_total_marks';
  EXECUTE IMMEDIATE 'DROP PROCEDURE calculate_grade';
  EXECUTE IMMEDIATE 'DROP TABLE students';
EXCEPTION
  WHEN OTHERS THEN
    NULL; 
END;
/


-- Task 3.1
CREATE TABLE students (
  student_id NUMBER PRIMARY KEY,
  student_name VARCHAR2(100),
  attendance NUMBER(5,2),
  quiz NUMBER(5,2),
  mid_term NUMBER(5,2),
  final_exam NUMBER(5,2)
);

INSERT INTO students (student_id, student_name, attendance, quiz, mid_term, final_exam)
VALUES (1, 'A', 8.5, 12, 20, 40);

INSERT INTO students (student_id, student_name, attendance, quiz, mid_term, final_exam)
VALUES (2, 'B', 9, 13, 23, 45);

INSERT INTO students (student_id, student_name, attendance, quiz, mid_term, final_exam)
VALUES (3, 'C', 7.5, 10, 19, 37);

INSERT INTO students (student_id, student_name, attendance, quiz, mid_term, final_exam)
VALUES (4, 'D', 9.5, 14, 24, 47);

INSERT INTO students (student_id, student_name, attendance, quiz, mid_term, final_exam)
VALUES (5, 'E', 8, 11, 22, 43);

COMMIT;

-- Task 3.2
CREATE OR REPLACE PROCEDURE calculate_total_marks IS
  total_marks NUMBER;
  attendance NUMBER;
  quiz NUMBER;
  mid_term NUMBER;
  final_exam NUMBER;
BEGIN
  FOR id IN 1..5 LOOP
    SELECT attendance, quiz, mid_term, final_exam 
    INTO attendance, quiz, mid_term, final_exam 
    FROM students 
    WHERE student_id = id;
    
    -- Calculating total marks
    total_marks := (attendance * 0.10) + 
                   (quiz * 0.15) + 
                   (mid_term * 0.25) + 
                   (final_exam * 0.50);
    
    -- Displaying the student's total marks
    DBMS_OUTPUT.PUT_LINE('Student ID: ' || id || ' Total Marks: ' || total_marks);
  END LOOP;
END;
/

-- Task 3.3
CREATE OR REPLACE PROCEDURE calculate_grade IS
  total_marks NUMBER;
  attendance NUMBER;
  quiz NUMBER;
  mid_term NUMBER;
  final_exam NUMBER;
  grade CHAR(1);
BEGIN
  FOR id IN 1..5 LOOP
    
    SELECT attendance, quiz, mid_term, final_exam 
    INTO attendance, quiz, mid_term, final_exam 
    FROM students 
    WHERE student_id = id;
    
    -- Calculating total marks
    total_marks := (attendance * 0.10) + 
                   (quiz * 0.15) + 
                   (mid_term * 0.25) + 
                   (final_exam * 0.50);
    
    -- Determining the grade
    IF total_marks >= 80 THEN
      grade := 'A';
    ELSIF total_marks >= 70 THEN
      grade := 'B';
    ELSIF total_marks >= 60 THEN
      grade := 'C';
    ELSIF total_marks >= 40 THEN
      grade := 'D';
    ELSE
      grade := 'F';
    END IF;
    
    -- Displaying the student's grade
    DBMS_OUTPUT.PUT_LINE('Student ID: ' || id || ' Grade: ' || grade);
  END LOOP;
END;
/

-- Testing
BEGIN
  calculate_total_marks;
END;
/

BEGIN
  calculate_grade;
END;
/
