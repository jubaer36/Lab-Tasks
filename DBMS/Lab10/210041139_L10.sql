--Warmup Query 1--
Set Serveroutput ON; 
Declare 
    v_name varchar2(20);
Begin 
    v_name := '&name';

DBMS_OUTPUT.PUT_LINE('Name is: ' || v_name);

END;

/ --Warmup Query 2--
Declare v_id varchar2(20);

Begin v_id := '&ID';

DBMS_OUTPUT.PUT_LINE('ID Length is: ' || Length(v_id));

END;

/ --Warmup Query 3--
Declare v_num1 NUMBER;

v_num2 NUMBER;

Begin v_num1 := '&n1';

v_num2 := '&n2';

DBMS_OUTPUT.PUT_LINE('Product is: ' || v_num1 * v_num2);

END;

/ --warmup Query 4--
Declare v_time1 TIMESTAMP;

Begin v_time1 := sysdate;

DBMS_OUTPUT.PUT_LINE('Date is: ' || v_time1);

END;

/ --warmup Query 5--
Declare v_num1 NUMBER;

d_type varchar2(20);

Begin v_num1 := '&v_num1';

if v_num1 = Round(v_num1) then d_type := 'Whole Number';

else d_type := 'Fraction';

end if;

DBMS_OUTPUT.PUT_LINE('Type is: ' || d_type);

END;

/ --warmup Query 6--
CREATE
OR REPLACE PROCEDURE check_composite_number (p_number IN NUMBER) IS v_count NUMBER := 0;

BEGIN FOR i IN 2..sqrt(p_number) LOOP IF MOD(p_number, i) = 0 THEN v_count := v_count + 1;

END IF;

END LOOP;

IF v_count > 0 THEN DBMS_OUTPUT.PUT_LINE(p_number || ' is a composite number.');

ELSE DBMS_OUTPUT.PUT_LINE(p_number || ' is not a composite number.');

END IF;

END check_composite_number;

/ DECLARE v_number NUMBER;

BEGIN v_number := '&v_number';

check_composite_number(v_number);

END;

--movie query 1--
CREATE
OR REPLACE PROCEDURE get_top_rated_movies(p_limit NUMBER) IS BEGIN FOR movie_data IN (
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

/ --movie query 2--
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

/ --movie query 3--
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

/ BEGIN find_oscar_nominees;

END;

/ / --movie query 4--
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