SET SERVEROUTPUT ON;
-- 1(a)
DECLARE
    USERNAME VARCHAR2(10);
BEGIN 
    USERNAME := '&username';
    DBMS_OUTPUT.PUT_LINE(USERNAME);
END;
/

-- 1(b)
DECLARE
    SID VARCHAR2(10);
BEGIN 
    SID := '&sid';
    DBMS_OUTPUT.PUT_LINE(Length(SID));
END;
/

-- 1(c)
DECLARE
    VAL1 NUMBER;
    VAL2 NUMBER;
BEGIN 
    VAL1 := '&val1';
    VAL2 := '&val2';
    DBMS_OUTPUT.PUT_LINE('PRODUCT OF TWO NUMBERS: ' || VAL1*VAL2);
END;
/
-- 1(d)

DECLARE 
    CurrentSystemTime VARCHAR2(20) := TO_CHAR(sysdate , 'HH12:MI:SS');
BEGIN
    DBMS_OUTPUT.PUT_LINE('CURRENT SYSTEM TIME: '|| CurrentSystemTime);
END;
/
-- 1(e)

DECLARE
    NumType VARCHAR2(10);
    InputNumber NUMBER;
BEGIN 
    InputNumber:= '&inputnumber';
    IF InputNumber = Round(InputNumber) THEN NumType := 'WHOLE';
    ELSE NumType := 'FRACTION';
    END IF;
    DBMS_OUTPUT.PUT_LINE(NumType || ' NUMBER');
END;
/

-- 1(f)
CREATE OR REPLACE PROCEDURE check_composite_num(InputValue IN NUMBER) IS
    isComposite NUMBER:=0;
    i NUMBER:= 2;
BEGIN
    FOR i IN 2 .. ROUND(sqrt(InputValue)) LOOP
        IF MOD(InputValue , i) = 0 THEN 
            isComposite := 1;
            EXIT;
        ELSE isComposite := 0;
        END IF;
    END LOOP;
    IF isComposite = 1 THEN DBMS_OUTPUT.PUT_LINE('COMPOSITE NUMBER');
    ELSE DBMS_OUTPUT.PUT_LINE('PRIME NUMBER');
    END IF;
END;
/
DECLARE
BEGIN
    check_composite_num(5);
END;
/

-- 2(a)
CREATE OR REPLACE PROCEDURE get_top_rated_movies(p_limit NUMBER) 
IS 
BEGIN 
FOR movie_data IN (
    SELECT
        *
    FROM
        (
            SELECT
                m.MOV_ID,
                m.MOV_TITLE,
                m.MOV_YEAR,
                m.MOV_LANGUAGE,
                m.MOV_RELEASEDATE,
                m.MOV_COUNTRY,
                AVG(r.REV_STARS) AS avg_rating
            FROM
                MOVIE m
                JOIN RATING r ON m.MOV_ID = r.MOV_ID
            GROUP BY
                m.MOV_ID,
                m.MOV_TITLE,
                m.MOV_YEAR,
                m.MOV_LANGUAGE,
                m.MOV_RELEASEDATE,
                m.MOV_COUNTRY
            ORDER BY
                avg_rating DESC
        )
    WHERE
        ROWNUM <= p_limit
) LOOP DBMS_OUTPUT.PUT_LINE(
    'Movie ID: ' || movie_data.MOV_ID || ', Title: ' || movie_data.MOV_TITLE || ', Year: ' || movie_data.MOV_YEAR || ', Release Date: ' || movie_data.MOV_RELEASEDATE || ', Country: ' || movie_data.MOV_COUNTRY || ', Avg Rating: ' || movie_data.avg_rating
);

END LOOP;

END get_top_rated_movies;

/ DECLARE v_limit NUMBER;

BEGIN v_limit := '&v_limit';

get_top_rated_movies(v_limit);

END;
/

-- 2(B)
CREATE
OR REPLACE FUNCTION movie_status(p_mov_id NUMBER) RETURN VARCHAR2 IS v_status VARCHAR2(20);

v_total_actor NUMBER := 0;

BEGIN
SELECT
    COUNT(*) INTO v_total_actor
FROM
    CASTS
WHERE
    MOV_ID = p_mov_id;

IF v_total_actor = 1 THEN v_status := 'Solo';

ELSE v_status := 'Ensemble';

END IF;

RETURN v_status;

END movie_status;

/ 
-- 2(C)

CREATE
OR REPLACE PROCEDURE find_oscar_nominees IS BEGIN FOR director_rec IN (
    SELECT
        DISTINCT d.dir_id,
        d.dir_firstname,
        d.dir_lastname
    FROM
        director d
        JOIN direction dir ON d.dir_id = dir.dir_id
        JOIN rating r ON dir.mov_id = r.mov_id
    GROUP BY
        d.dir_id,
        d.dir_firstname,
        d.dir_lastname
    HAVING
        AVG(r.rev_stars) >= 7
        AND COUNT(DISTINCT r.rev_id) > 10
) LOOP DBMS_OUTPUT.PUT_LINE(
    'Director ID: ' || director_rec.dir_id || ', Name: ' || director_rec.dir_firstname || ' ' || director_rec.dir_lastname
);

END LOOP;

END find_oscar_nominees;
/ 
BEGIN 
find_oscar_nominees;
END;

/ 
-- 2(D)
CREATE
OR REPLACE FUNCTION get_avg_rating(p_mov_title VARCHAR2) RETURN NUMBER IS m_rating NUMBER;

BEGIN
SELECT
    avg(REV_STARS) INTO m_rating
FROM
    MOVIE m,
    rating r
WHERE
    m.MOV_TITLE = p_mov_title
    and m.MOV_ID = r.MOV_ID;

RETURN m_rating;

END get_avg_rating;

/ CREATE
OR REPLACE FUNCTION get_category(p_mov_title VARCHAR) RETURN VARCHAR2 IS v_category VARCHAR2(20);

r_year NUMBER;

m_rating NUMBER;

BEGIN
SELECT
    m.MOV_YEAR INTO r_year
FROM
    movie m
WHERE
    m.MOV_TITLE = p_mov_title;

SELECT
    get_avg_rating(p_mov_title) INTO m_rating
FROM
    dual;

IF r_year >= 1950
AND r_year <= 1959
AND m_rating > 6.5 THEN v_category := 'Fantastic Fifties';

ELSIF r_year >= 1960
AND r_year <= 1969
AND m_rating > 6.7 THEN v_category := 'Sweet Sixties';

ELSIF r_year >= 1970
AND r_year <= 1979
AND m_rating > 6.9 THEN v_category := 'Super Seventies';

ELSIF r_year >= 1980
AND r_year <= 1989
AND m_rating > 7.1 THEN v_category := 'Ecstatic Eighties';

ELSIF r_year >= 1990
AND r_year <= 1999
AND m_rating > 7.3 THEN v_category := 'Neat Nineties';

ELSE v_category := 'Garbage';

END IF;

RETURN v_category;

END get_category;

/ COMMIT;