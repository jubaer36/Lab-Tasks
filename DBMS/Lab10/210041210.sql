-- 1. Warm-up:
-- (a) Print your name.
set serveroutput on size 1000000
begin
    dbms_output.put_line('Shufan Shahi');
end;
/

-- (b) Take your student ID as input and print its length.
declare
    student_id varchar2(20);
begin
    student_id := '&student_id';
    dbms_output.put_line(length(student_id));
end;
/

-- (c) Take two numbers as input and print their product.

declare
    num1 number;
    num2 number;
begin
    num1:='&num1';
    num2:='&num2';
    dbms_output.put_line('Product is '||num1*num2);
end;
/

-- (d) Print the current system time in 12-hour format.
declare
    myTime varchar2(20);
begin
    myTime := to_char(sysdate,'hh:mi:ss am');
    dbms_output.put_line('Current time is '|| myTime);
end;
/

-- (e) Take a number as input and print whether it is a whole number or a fraction.
declare
    num1 number;
begin
    num1 := '&num1';

    if round(num1) = num1 then
        dbms_output.put_line('It is a whole number');
    else
        dbms_output.put_line('It is a fraction');
    end if;
end;
/

-- (f) Write a procedure that takes a number as an argument and prints whether it is a com-posite number or not.
declare
    procedure checkcomposite(myNumber number)
    is
    is_composite boolean := false;
    begin
        if myNumber>1 then
            for i in 2..myNumber-1 loop
                if mod(myNumber,i) = 0
                    then
                    is_composite:= true;
                    exit;
                end if;
            end loop;
        end if;
        if is_composite then
            dbms_output.put_line('It is a composite number');
        else
            dbms_output.put_line('Not a composite number');
        end if;
    end checkcomposite;
begin
    checkcomposite(17);
    checkcomposite(14);
end;
/

-- 2. Consider the following schema for a movie database:
-- (a) Write a procedure to find the N top-rated movies and their details (Top-rated means top
-- highest average rating). The procedure will take N as input and print the details up to
-- N movies. If N is greater than the number of movies, then it will print an error message.
declare
    v_num number;

    myException exception;

    procedure top_rated_movies(n in number) is
    begin
        declare
            tot_rows number;
        begin
            select count(*)
            into tot_rows
            from(
                select avg(rating.rev_stars) as averageR,rating.mov_id
                from rating
                group by rating.mov_id
                order by avg(rating.rev_stars)
            );

            if n>tot_rows then
                raise myException;
            end if;

            for movie_list in (
                select *
                from(
                    select
                        movie.mov_id,
                        movie.mov_title,
                        movie.mov_year,
                        movie.mov_language,
                        avg(rating.rev_stars) as avg_rating
                    from movie,rating
                    where movie.mov_id = rating.mov_id
                    group by movie.mov_id, movie.mov_title, movie.mov_year, movie.mov_language
                    order by avg(rating.rev_stars) desc
                )
                where rownum <= n
            )
            loop
                dbms_output.put_line('movie id: ' || movie_list.mov_id);
                dbms_output.put_line('title: ' || movie_list.mov_title);
                dbms_output.put_line('year: ' || movie_list.mov_year);
                dbms_output.put_line('language: ' || movie_list.mov_language);
                dbms_output.put_line('average rating: ' || to_char(movie_list.avg_rating, 'fm90.0'));
                dbms_output.put_line('------------------------');
            end loop;
        exception
            when myException then
                dbms_output.put_line('Error n is to big');
        end;
    end top_rated_movies;
begin
    v_num := to_number('&n');
    top_rated_movies(v_num);
end;
/

-- (b) Write a function to find the movie status (“Solo”, “Ensemble”). If the total number of
-- actors/actresses in a movie is 1, then the status should be “Solo”, else it should be “En-
-- semble”. The function will take the title of the movie as input as input and return the
-- status.
create or replace function myStatus(movie_title in varchar2)
return varchar2 is
    the_status varchar2(20);
    tot_actors number;
begin
    select count(c.act_id)
    into tot_actors
    from movie m, casts c
    where m.mov_id = c.mov_id and m.mov_title = movie_title;

    if tot_actors = 1 then
        the_status := 'solo';
    else
        the_status := 'ensemble';
    end if;

    return the_status;
exception
    when no_data_found then
        return 'movie not found';
    when others then
        return 'error';
end myStatus;
/

declare
    v_status varchar2(20);

begin
    v_status := myStatus('Beyond the Sea');
    dbms_output.put_line('movie status: ' || v_status);
end;
/

-- (c) Write a procedure to find the possible nominees for the Oscars. A director is eligible for
-- an Oscar if at least one of their movies has an average rating of at least 7. Also, the movie
-- should be reviewed by more than 10 reviewers.
create or replace procedure find_nominees is
begin
    for dir_list in(
        select distinct d.dir_id,d.dir_firstname,d.dir_lastname
        from director d, movie m, rating r,direction di
        where d.dir_id = di.dir_id and di.mov_id = m.mov_id and m.mov_id = r.mov_id
        group by d.dir_id, d.dir_firstname, d.dir_lastname
        having avg(r.rev_stars) >= 7 and count(distinct r.rev_id) >10
    )
    loop
        dbms_output.put_line('director id: ' || dir_list.dir_id);
        dbms_output.put_line('name: ' || dir_list.dir_firstname || ' ' || dir_list.dir_lastname);
        dbms_output.put_line('------------------------');
    end loop;
end find_nominees;
/
begin
    find_nominees;
end;
/
-- (d) Write a function that will take the title of the movie as input and find the movie category
-- based on Table 1.
create or replace function getmoviecategory(p_movie_title in varchar2) return varchar2 is
    v_category varchar2(20);
    v_release_year number;
    v_avg_rating number;

begin
    select
        m.mov_year,
        avg(r.rev_stars) as avg_rating
    into
        v_release_year,
        v_avg_rating
    from
        movie m
    join
        rating r on m.mov_id = r.mov_id
    where
        m.mov_title = p_movie_title
    group by
        m.mov_year;

    if v_avg_rating > 7.3 then
        v_category := 'neat nineties';
    elsif v_avg_rating > 7.1 then
        v_category := 'ecstatic eighties';
    elsif v_avg_rating > 6.9 then
        v_category := 'super seventies';
    elsif v_avg_rating > 6.7 then
        v_category := 'sweet sixties';
    elsif v_avg_rating > 6.5 then
        v_category := 'fantastic fifties';
    else
        v_category := 'garbage';
    end if;

    return v_category;

exception
    when no_data_found then
        return 'movie not found';
    when others then
        return 'error';
end getmoviecategory;
/

declare
    v_category varchar2(20);
begin
    v_category := getmoviecategory('Titanic');
    dbms_output.put_line('movie category: ' || v_category);
end;
/
