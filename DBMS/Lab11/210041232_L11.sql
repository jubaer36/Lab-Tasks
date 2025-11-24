--1. Write a procedure to that will take a mov_title and show the require time (–hour –minute) to play that movie in a cinema hall. Let say, there will be an intermission of 15 minutes after each 70 minutes only if the remaining time of the movie is greater than 30 minutes.

CREATE OR REPLACE PROCEDURE RequiredTime(title in VARCHAR2) AS
hours NUMBER;
minutes NUMBER;
time NUMBER;
BEGIN
  SELECT MOV_TIME INTO time
  FROM MOVIE
  WHERE MOV_TITLE = title;

    IF (MOD(time,70))>30 THEN
    time:=TRUNC((time/70))*15+time;
    END IF;
    hours:=TRUNC(time/60);
    minutes:=MOD(time,60);
    DBMS_OUTPUT.PUT_LINE('Required time to play "' || title || '": ' || hours || ' hours ' || minutes || ' minutes');
end;
/
DECLARE
title VARCHAR2(100);
BEGIN
DBMS_OUTPUT.PUT_LINE('Enter movie title :');
title:='&title';
RequiredTime(title);
END;
/


--2. Write a procedure to find the N top-rated movies (average rev_stars of a movie is higher than other movies). The procedure will take N as input and print the mov_title upto N movies. If N is greater then the number of movies, then it will print an error message.
CREATE OR REPLACE PROCEDURE TopRatedMovies(N IN NUMBER) 
AS
    titles VARCHAR2(50);
    avg_stars NUMBER:=0;
    movie_count NUMBER;
    mov_rank NUMBER;
  BEGIN
   
    SELECT COUNT(DISTINCT MOV_ID) INTO movie_count
    FROM MOVIE ;
    IF movie_count < N THEN
      DBMS_OUTPUT.PUT_LINE('Error: There are fewer than ' || N || ' movies in the database.');
      RETURN;
    END IF;
    FOR movie_info IN (
      SELECT m.MOV_TITLE, AVG(r.REV_STARS) AS AVG_STARS
      FROM MOVIE m
      JOIN Rating r on m.MOV_ID=r.MOV_ID
      GROUP BY m.MOV_TITLE
      ORDER BY AVG(r.REV_STARS) DESC
    )
    loop
      mov_rank:=mov_rank +1;
      DBMS_OUTPUT.PUT_LINE('Rank ' || mov_rank || ':');
      DBMS_OUTPUT.PUT_LINE('Title: ' || movie_info.MOV_TITLE);
      DBMS_OUTPUT.PUT_LINE('Average Rating: ' || TO_CHAR(movie_info.AVG_STARS, 'FM99990.00'));
      DBMS_OUTPUT.PUT_LINE('-------------------------------------');
      
      EXIT WHEN mov_rank>=N;
    end loop;  
END;
/


DECLARE
N number;
BEGIN
N:=&N;
TopRatedMovies(N);
END;
/


--3. Suppose, there is a scheme that for each rev_stars greater than or equal to 6, a movie will receive $10. Now write a function to calculate the yearly earning (total earning /year in between current date and release date) of a movie that is obtained from user review.

CREATE OR REPLACE FUNCTION CalculateEarning(title IN VARCHAR2)
RETURN NUMBER AS
  earning NUMBER:=0;
  release_date DATE;
  current_date DATE:= SYSDATE;
  id NUMBER;
  years NUMBER:=0;
BEGIN
    SELECT MOV_ID,MOV_RELEASEDATE INTO id,release_date
    FROM MOVIE
    WHERE MOV_TITLE=title;
    
    SELECT (EXTRACT (YEAR FROM current_date) - EXTRACT(YEAR FROM release_date)) INTO years
    FROM DUAL;
    IF years = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Warning: Years is zero.Years made 1');
        years := GREATEST(years, 1);
    END IF;
    SELECT COUNT(*) *10 INTO earning
    FROM RATING 
    WHERE MOV_ID=id
    AND REV_STARS>=6;
    earning := earning/years;
    RETURN earning;
END;
/


DECLARE
    title VARCHAR2(50);
    earning NUMBER;
BEGIN
    title := '&title';
    earning := CalculateEarning(title);
    DBMS_OUTPUT.PUT_LINE('Yearly Earning for Movie ' || title || ': $' || TO_CHAR(earning, 'FM99990.00'));
END;
/


--4. Write a function, that given a genre (gen_id) will return genre status, additionally the review  count and average rating of that genre.

CREATE OR REPLACE FUNCTION GET_GENRE_STATUS(G_ID IN NUMBER)
RETURN VARCHAR2
IS
AVG_ALL_RATE NUMBER;
AVG_ALL_REV NUMBER;
GEN_COUNT NUMBER;
REV_COUNT NUMBER;
MY_GEN_RATE NUMBER;
MY_GEN_COUNT NUMBER;
STATUS VARCHAR2(50);
BEGIN
SELECT AVG(REV_STARS) INTO AVG_ALL_RATE FROM RATING;
SELECT COUNT(DISTINCT GEN_ID) INTO GEN_COUNT FROM MTYPE;
SELECT COUNT(REV_ID) INTO REV_COUNT FROM RATING;
AVG_ALL_REV:=REV_COUNT/GEN_COUNT;

SELECT AVG(REV_STARS), COUNT(REV_ID) INTO MY_GEN_RATE, MY_GEN_COUNT FROM RATING WHERE MOV_ID IN (SELECT MOV_ID FROM MTYPE WHERE GEN_ID = G_ID) ;

IF (MY_GEN_RATE < AVG_ALL_RATE AND MY_GEN_COUNT > AVG_ALL_REV) THEN
        STATUS := 'WIDELY WATCHED';
    ELSIF (MY_GEN_RATE > AVG_ALL_RATE AND MY_GEN_COUNT < AVG_ALL_REV) THEN
        STATUS := 'HIGHLY RATED';
    ELSIF (MY_GEN_RATE > AVG_ALL_RATE AND MY_GEN_COUNT > AVG_ALL_REV) THEN
        STATUS := 'PEOPLE''S FAVOURITE';
    ELSE
        STATUS := 'SO SO';
    END IF;
    RETURN 'Status: ' || STATUS || ' | Review Count: ' || TO_CHAR(MY_GEN_COUNT,'FM99990.00') || ' | Average Rating: ' || TO_CHAR(MY_GEN_RATE,'FM99990.00');
END;
/

DECLARE
    result VARCHAR2(200);
    genre_id NUMBER := 1010; 
BEGIN
    result := GET_GENRE_STATUS(genre_id);
    DBMS_OUTPUT.PUT_LINE(result);
END;
/



--5. Write a function, that given two dates will return the most frequent genre of that time (according to movie count) along with the count of movies under that genre which had been released in the given time range .

CREATE OR REPLACE FUNCTION MOST_FREQUENT_GENRE(start_date IN DATE, end_date IN DATE)
RETURN VARCHAR2
IS
    MOST_FREQ_GENRE VARCHAR2(50);
    MOVIE_COUNT NUMBER;
BEGIN
    SELECT
        GEN_TITLE,
        MOVIE_COUNT
    INTO
        MOST_FREQ_GENRE,
        MOVIE_COUNT
    FROM(
        SELECT 
        GENRES.GEN_TITLE,
        COUNT(MOVIE.MOV_ID) AS MOVIE_COUNT
        FROM MOVIE
        JOIN MTYPE ON MOVIE.MOV_ID = MTYPE.MOV_ID
        JOIN GENRES ON MTYPE.GEN_ID = GENRES.GEN_ID
    WHERE
        MOVIE.MOV_RELEASEDATE BETWEEN start_date AND end_date
    GROUP BY
        GENRES.GEN_TITLE
    ORDER BY
        MOVIE_COUNT DESC
    )
    WHERE ROWNUM=1;

    -- Return the result
    RETURN 'Most Frequent Genre: ' || MOST_FREQ_GENRE || ' | Movie Count: ' || TO_CHAR(MOVIE_COUNT);
    EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 'No movies found in the given time range';
END;
/

DECLARE
    result VARCHAR2(100);
    start_date DATE := TO_DATE('1900-08-03', 'YYYY-MM-DD'); 
    end_date DATE := TO_DATE('1900-11-07', 'YYYY-MM-DD');
BEGIN
    result := MOST_FREQUENT_GENRE(start_date, end_date);
    DBMS_OUTPUT.PUT_LINE(result);
END;
/
