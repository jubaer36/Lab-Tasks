SET SERVEROUTPUT ON

//////1(a)////


begin
dbms_output.put_line('Nirjon');
end;
/


/////1-b//////


declare
studentID varchar2(20);
begin  
	studentID := '&student_ID';
	dbms_output.put_line(length(studentID));
end;
/


////1-c/////


declare
	num1 number;
	num2 number;
	answer number;
begin
	num1 := '&number_1';
	num2 := '&number_2';
	answer := num1 * num2;
	dbms_output.put_line(answer);
end;
/


//////1-d/////

declare 
	currentDate varchar2(20) := TO_CHAR (sysdate, 'HH12 :MI:SS');
begin 
	dbms_output.put_line(currentDate);
end;
/


/////1-e/////


DECLARE
  input_number number := '&input_number';
BEGIN
  	IF TRUNC(input_number) = input_number THEN
    	DBMS_OUTPUT.PUT_LINE('whole number');
  	ELSE
    	DBMS_OUTPUT.PUT_LINE('fraction');
  	END IF;
END;
/


/////1-f////


CREATE OR REPLACE PROCEDURE check_composite_num(
    input_number IN NUMBER,
    isComposite OUT NUMBER
) IS
    i NUMBER;
    limitLoop NUMBER := input_number / 2;
BEGIN
    FOR i IN 2 .. limitLoop LOOP
        IF MOD(input_number, i) = 0 THEN
            isComposite := 1;
            EXIT;
        ELSE
            isComposite := 0;
        END IF;
    END LOOP;

    IF isComposite = 0 THEN 
        DBMS_OUTPUT.PUT_LINE('Not Composite');
    ELSE 
        DBMS_OUTPUT.PUT_LINE('Composite');
    END IF;
END;
/



/////2-a////


CREATE OR REPLACE PROCEDURE topratedmovies(N IN NUMBER) IS
    ID NUMBER;
    TITLE VARCHAR2(50);
    M_YEAR NUMBER;
    M_LANGUAGE VARCHAR2(30);
    RELEASEDATE DATE;
    COUNTRY VARCHAR2(30);

    CURSOR top_rated_movies_cur IS
        SELECT q.mov_id, q.mov_title, q.mov_year, q.mov_language, q.mov_releasedate, q.mov_country
        FROM (
            SELECT m.mov_id, m.mov_title, m.mov_year, m.mov_language, m.mov_releasedate, m.mov_country, AVG(r.rev_stars)
            FROM movie m, rating r
            WHERE m.mov_id = r.mov_id
            GROUP BY m.mov_id, m.mov_title, m.mov_year, m.mov_language, m.mov_releasedate, m.mov_country
            ORDER BY AVG(r.rev_stars) DESC
        ) q
        WHERE ROWNUM <= N;

BEGIN
    OPEN top_rated_movies_cur;
    DBMS_OUTPUT.PUT_LINE('ID '     || 'title '     || 'm_year '      || 'm_language '    || 'releasedate '   || 'country '  );
    DBMS_OUTPUT.PUT_LINE('===============================================================================');

    LOOP
        FETCH top_rated_movies_cur INTO ID, TITLE, M_YEAR, M_LANGUAGE, RELEASEDATE, COUNTRY;
        EXIT WHEN top_rated_movies_cur%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(ID || ' ' || TITLE || ' ' || M_YEAR || ' ' || M_LANGUAGE || ' ' || RELEASEDATE || ' ' || COUNTRY);
    END LOOP;

    CLOSE top_rated_movies_cur;
END;
/

DECLARE
    total NUMBER;
    N NUMBER := '&number';
BEGIN
    SELECT COUNT(*) INTO total FROM movie;

    IF (N > total) THEN
        DBMS_OUTPUT.PUT_LINE('ERROR: N is greater than total');
    ELSE
        topratedmovies(N);
    END IF;
END;
/


/////2-b////

CREATE OR REPLACE FUNCTION movie_status(title VARCHAR2)
RETURN VARCHAR2 IS
    status VARCHAR2(20);
    num NUMBER;

BEGIN
    SELECT COUNT(c.act_id)
    INTO num
    FROM movie m, casts c
    WHERE m.mov_id = c.mov_id AND m.mov_title = title
    GROUP BY m.mov_id;

    status := CASE WHEN num = 1 THEN 'Solo' ELSE 'Ensemble' END;

    RETURN status;
END;
/

BEGIN
    DBMS_OUTPUT.PUT_LINE(movie_status('The Theory of Everything'));
END;
/


////2-c////


CREATE OR REPLACE PROCEDURE oscar_nominees(num IN NUMBER := 0) IS
    first_name VARCHAR2(20);
    last_name VARCHAR2(20);

    CURSOR oscar_nominees_cur IS
        SELECT q.fname, q.lname
        FROM (
            SELECT MAX(dr.dir_firstname) fname, MAX(dr.dir_lastname) lname, MAX(dr.dir_ID) id,
                   AVG(rev_stars) tot_avg, COUNT(rev_stars) tot
            FROM director dr, direction dt, rating r 
            WHERE dr.dir_id = dt.dir_id AND dt.mov_id = r.mov_id
            GROUP BY r.mov_id
        ) q
        GROUP BY q.fname, q.lname
        HAVING MAX(q.tot) > 10 AND MAX(tot_avg) >= 7;

BEGIN
    OPEN oscar_nominees_cur;
    DBMS_OUTPUT.PUT_LINE('Oscar Nominees:');
    DBMS_OUTPUT.PUT_LINE('================');
    
    LOOP
        FETCH oscar_nominees_cur INTO first_name, last_name;
        EXIT WHEN oscar_nominees_cur%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(first_name || ' ' || last_name);
    END LOOP;

    CLOSE oscar_nominees_cur;
END;
/

BEGIN
    oscar_nominees();
END;
/


/////2-d///


CREATE OR REPLACE FUNCTION movie_category(title VARCHAR2)
RETURN VARCHAR2 IS
    category VARCHAR2(20);
    avg_rating NUMBER := 0;
    r_date NUMBER := 0;

BEGIN
    SELECT m.mov_year, AVG(r.rev_stars) INTO r_date, avg_rating
    FROM movie m, rating r 
    WHERE m.mov_id = r.mov_id AND m.mov_title = title
    GROUP BY m.mov_year;

    IF (avg_rating > 6.5 AND r_date BETWEEN 1950 AND 1959) THEN
        category := 'Fantastic Fifties';
    ELSIF (avg_rating > 6.7 AND r_date BETWEEN 1960 AND 1969) THEN
        category := 'Sweet Sixties';
    ELSIF (avg_rating > 6.9 AND r_date BETWEEN 1970 AND 1979) THEN
        category := 'Super Seventies';
    ELSIF (avg_rating > 7.1 AND r_date BETWEEN 1980 AND 1989) THEN
        category := 'Ecstatic Eighties';
    ELSIF (avg_rating > 7.3 AND r_date BETWEEN 1990 AND 1999) THEN
        category := 'Neat Nineties';
    ELSE
        category := 'Garbage';
    END IF;

    RETURN category;
END;
/

BEGIN
    DBMS_OUTPUT.PUT_LINE(movie_category('Blade Runner'));
END;
/



