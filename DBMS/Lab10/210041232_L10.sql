SET SERVEROUTPUT ON;


--1. Warm-up:
--(a) Print your name.
BEGIN
DBMS_OUTPUT.PUT_LINE ( 'Rafid Ahmed');
END ;
/
--(b) Take your student ID as input and print its length.
DECLARE
    ID NUMBER;
BEGIN 
    ID:=&id;
    DBMS_OUTPUT.PUT_LINE('Length of if =' || id);
END;
/
--(c)Take two numbers as input and print their product.
DECLARE
    NUM1 NUMBER;
    NUM2 NUMBER;
BEGIN 
    NUM1:=&num1;
    NUM2:=&num2;
    DBMS_OUTPUT.PUT_LINE('Product of 2 numbers =' || (num1*num2));
END;
/

--(d) Print the current system time in 12-hour format.
DECLARE
    today DATE;
BEGIN 
    today:=sysdate;
    DBMS_OUTPUT.PUT_LINE('Current time (12 Hr format) = ' || 
    TO_CHAR(today, 'DD-MON-YY HH12:MI:SS'));
END;
/

--(e) Take a number as input and print whether it is a whole number or a fraction.
DECLARE 
  num NUMBER; 
BEGIN 
  num := &num; -- User input

  -- Check if the number is a whole number or a fraction
  IF num = TRUNC(num) THEN 
    DBMS_OUTPUT.PUT_LINE('The number ' || num || ' is a whole number.'); 
  ELSE 
    DBMS_OUTPUT.PUT_LINE('The number ' || num || ' is a fraction.'); 
  END IF; 
END; 
/

--(f) Write a procedure that takes a number as an argument and prints whether it is a com-
CREATE OR REPLACE PROCEDURE CheckComposite(num NUMBER)
IS isComposite BOOLEAN :=false;
BEGIN 
    FOR i IN 2..TRUNC(SQRT(num)) loop
      IF MOD(num,i) = 0 THEN
        isComposite:=TRUE;
        EXIT;
      END IF;

    end loop;
    --Display Result
    IF isComposite THEN
        DBMS_OUTPUT.PUT_LINE('The number is composite');
    ELSE
        DBMS_OUTPUT.PUT_LINE('The number is not composite');
    END IF;
END;
/

--call function
begin
    CheckComposite(12);
end;
/


--2. Consider the following schema for a movie database:

--(a) Write a procedure to find the N top-rated movies and their details (Top-rated means top highest average rating). The procedure will take N as input and print the details up to N movies. If N is greater than the number of movies, then it will print an error message.

CREATE OR REPLACE PROCEDURE TopRatedMovies(N IN NUMBER) 
AS
  cursor top_rated IS
    SELECT 
      M.MOV_ID,
      M.MOV_TITLE,
      M.MOV_YEAR,
      M.MOV_LANGUAGE,
      M.MOV_RELEASEDATE,
      M.MOV_COUNTRY,
      AVG(R.REV_STARS) AS AVg_RATING
    FROM
      MOVIE M
      JOIN RATING R ON M.MOV_ID = R.MOV_ID
    GROUP BY
      M.MOV_ID, M.MOV_TITLE, M.MOV_YEAR, M.MOV_LANGUAGE, M.MOV_RELEASEDATE, M.MOV_COUNTRY 
    ORDER BY
      AVg_RATING DESC;

    
    movie_count NUMBER :=0;
  BEGIN 
    FOR movie_info IN top_rated loop
      EXIT WHEN movie_count>=N;
      DBMS_OUTPUT.PUT_LINE('Movie ID: ' || movie_info.MOV_ID);
      DBMS_OUTPUT.PUT_LINE('Title: ' || movie_info.MOV_TITLE);
      DBMS_OUTPUT.PUT_LINE('Year: ' || movie_info.MOV_YEAR);
      DBMS_OUTPUT.PUT_LINE('Language: ' || movie_info.MOV_LANGUAGE);
      DBMS_OUTPUT.PUT_LINE('Release Date: ' || TO_CHAR(movie_info.MOV_RELEASEDATE, 'DD-MON-YYYY'));
      DBMS_OUTPUT.PUT_LINE('Country: ' || movie_info.MOV_COUNTRY);
      DBMS_OUTPUT.PUT_LINE('Average Rating: ' || TO_CHAR(movie_info.AVg_RATING, 'FM99990.00'));
      DBMS_OUTPUT.PUT_LINE('-------------------------------------');
      movie_count := movie_count + 1;
      
      end loop;
    IF movie_count < N THEN
      DBMS_OUTPUT.PUT_LINE('Error: There are fewer than ' || N || ' movies in the database.');
    END IF;
END;
/

--calling 
begin
  TopRatedMovies(5);
end;
/

--(b) Write a function to find the movie status (“Solo”, “Ensemble”). If the total number of actors/actresses in a movie is 1, then the status should be “Solo”, else it should be “En-semble”. The function will take the title of the movie as input as input and return the status.

CREATE OR REPLACE FUNCTION MovieStatus(title IN VARCHAR2) RETURN  VARCHAR2
AS
  status VARCHAR2(20);
  actor_count NUMBER;
  BEGIN 
    SELECT COUNT(*) INTO actor_count
    FROM CASTS c 
    WHERE c.MOV_ID =(SELECT MOV_ID FROM MOVIE WHERE MOV_TITLE=TITLE);
    
    IF actor_count =1 THEN
      STATUS := 'Solo' ;
    ELSE
      STATUS := 'Ensemble';
    END IF;
    RETURN status;
  
END;
/
--calling 
begin
 DBMS_OUTPUT.PUT_LINE(MovieStatus('The Theory of Everything')); 
end;
/

--(c) Write a procedure to find the possible nominees for the Oscars. A director is eligible for an Oscar if at least one of their movies has an average rating of at least 7. Also, the movie should be reviewed by more than 10 reviewers.
CREATE OR REPLACE PROCEDURE FindOscarNominees AS
BEGIN
  FOR director_data IN (
    SELECT
      d.DIR_ID,
      d.DIR_FIRSTNAME,
      d.DIR_LASTNAME,
      m.MOV_ID,
      m.MOV_TITLE,
      r.AVg_RATING,
      r.REVIEWER_COUNT
    FROM
      DIRECTOR d
      JOIN DIRECTION dir ON d.DIR_ID = dir.DIR_ID
      JOIN MOVIE m ON dir.MOV_ID = m.MOV_ID
      LEFT JOIN (
        SELECT
          r.MOV_ID,
          AVG(r.REV_STARS) AS AVg_RATING,
          COUNT(DISTINCT r.REV_ID) AS REVIEWER_COUNT
        FROM RATING r
        GROUP BY r.MOV_ID
        HAVING AVG(r.REV_STARS) >= 7 AND COUNT(DISTINCT r.REV_ID) > 10
      )r ON m.MOV_ID = r.MOV_ID
    WHERE r.MOV_ID IS NOT NULL
  )
  LOOP
    DBMS_OUTPUT.PUT_LINE(
      'Director ID: ' || director_data.DIR_ID ||
      ', Name: ' || director_data.DIR_FIRSTNAME || ' ' || director_data.DIR_LASTNAME ||
      ', Movie ID: ' || director_data.MOV_ID ||
      ', Movie Title: ' || director_data.MOV_TITLE ||
      ', Average Rating: ' || TO_CHAR(director_data.AVg_RATING) ||
      ', Reviewer Count: ' || director_data.REVIEWER_COUNT
    );
    DBMS_OUTPUT.PUT_LINE('-----------------------------------------');
  END LOOP;
END FindOscarNominees;
/
--calling 
BEGIN
  FindOscarNominees;
END;
/


--(d) Write a function that will take the title of the movie as input and find the movie category based on Table 1.

CREATE OR REPLACE FUNCTION GetMovieCategory(movie_title IN VARCHAR2) RETURN VARCHAR2 IS
release_year NUMBER;
avg_rating NUMBER;
movie_category VARCHAR2(20);
BEGIN
  SELECT
    m.MOV_YEAR,AVG(r.REV_STARS) INTO release_year,avg_rating
  FROM movie m
  LEFT JOIN rating r ON m.MOV_ID=r.MOV_ID
  WHERE
  m.MOV_TITLE = movie_title 
  GROUP BY m.MOV_YEAR;

---Determine catagory ---
CASE
    WHEN release_year BETWEEN 1950 AND 1959 AND avg_rating > 6.5 THEN
      movie_category := 'Fantastic Fifties';
    WHEN release_year BETWEEN 1960 AND 1969 AND avg_rating > 6.7 THEN
      movie_category := 'Sweet Sixties';
    WHEN release_year BETWEEN 1970 AND 1979 AND avg_rating > 6.9 THEN
      movie_category := 'Super Seventies';
    WHEN release_year BETWEEN 1980 AND 1989 AND avg_rating > 7.1 THEN
      movie_category := 'Ecstatic Eighties';
    WHEN release_year BETWEEN 1990 AND 1999 AND avg_rating > 7.3 THEN
      movie_category := 'Neat Nineties';
    ELSE
      movie_category := 'Garbage';
END CASE;
RETURN movie_category;
END;
/

--calling
DECLARE
  category VARCHAR2(50);
begin
  category := GetMovieCategory('The Shining'); 

  DBMS_OUTPUT.PUT_LINE('Movie Category: ' || category);
END;
/
