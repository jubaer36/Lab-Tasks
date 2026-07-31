select distinct A.ACT_FIRSTNAME , A.ACT_LASTNAME
    from ACTOR A
    where A.ACT_GENDER = 'F' and A.ACT_FIRSTNAME = A.ACT_FIRSTNAME;

select MOVIE.MOV_TITLE from MOVIE 
    where MOVIE.MOV_ID not in (select MOV_ID from RATING);

select TO_CHAR(MOVIE.MOV_RELEASEDATE , 'Month') as RELEASEMONTH , count(*) as M_COUNT
    from MOVIE 
group by TO_CHAR(MOVIE.MOV_RELEASEDATE , 'Month');

select MONTHS_BETWEEN (max,min)/30 from
    (select MIN(MOVIE.MOV_RELEASEDATE) as min, MAX(MOVIE.MOV_RELEASEDATE) as max
            from DIRECTOR natural join MOVIE
            where DIRECTOR.DIR_FIRSTNAME = 'James' and DIRECTOR.DIR_LASTNAME = 'Cameron');

-- 5
select REV_NAME , count(*) from REVIEWER
    natural join RATING
    where REV_STARS = (select MIN(REV_STARS) from RATING)
    group by REV_NAME;

-- 6
select MOVIE.MOV_TITLE, NVL(AVG(RATING.REV_STARS), 0)
FROM MOVIE 
    natural join RATING
    group by MOVIE.MOV_TITLE;

-- 7
select MOVIE.MOV_ID , MOVIE.MOV_TITLE ||  
    case 
        when MOV_YEAR < 1980 then 'old gold'
        when MOV_YEAR between 1980 and 2000 then 'trendy 90s'
        else 'weird 20s'
    end
    from MOVIE;

-- 8
select 
    NVL(ACTOR.ACT_FIRSTNAME || ' '||  ACTOR.ACT_LASTNAME , 'Unknown Actor') as Actor_Name,
    NVL(DIRECTOR.DIR_FIRSTNAME || ' ' ||  DIRECTOR.DIR_LASTNAME , 'Unknown Director') as Dir_Name,
    MOVIE.MOV_TITLE
    from MOVIE left join CASTS
    on MOVIE.MOV_ID = CASTS.MOV_ID
    left join ACTOR on
    ACTOR.ACT_ID = CASTS.ACT_ID
    left join DIRECTION on
    DIRECTION.MOV_ID = MOVIE.MOV_ID
    left join DIRECTOR on
    DIRECTION.DIR_ID = DIRECTOR.DIR_ID;

-- 9
DROP TABLE RATING_DIRECTED_MOVIE CASCADE CONSTRAINTS;
CREATE TABLE RATING_DIRECTED_MOVIE
(
    MOV_ID NUMBER,
    REV_ID NUMBER,
    REV_STARS NUMBER,
    CONSTRAINT PK_RATING_DIR_MOV PRIMARY KEY(MOV_ID, REV_ID),
    CONSTRAINT FK_RATING_DIR_MOV FOREIGN KEY(MOV_ID) REFERENCES MOVIE(MOV_ID),
    CONSTRAINT FK_RATING_DIR_MOV_REVIEWER FOREIGN KEY(REV_ID) REFERENCES REVIEWER(REV_ID)
);
-- 10

insert into RATING_DIRECTED_MOVIE (MOV_ID , REV_ID , REV_STARS)
select R.MOV_ID , R.REV_ID , R.REV_STARS
    from RATING R
    inner join DIRECTION on R.MOV_ID = DIRECTION.DIR_ID;


-- 11
alter table RATING_DIRECTED_MOVIE
add STATUS VARCHAR2(10);

-- 12

update RATING_DIRECTED_MOVIE RDM
set RDM.STATUS = 
    case
        when RDM.REV_STARS > (select avg(RDM.REV_STARS) + 2 from RATING_DIRECTED_MOVIE) then 'Better'
        when RDM.REV_STARS > (select avg(RDM.REV_STARS)- 2 from RATING_DIRECTED_MOVIE) then 'Bad'
        else 'so so'
    end;