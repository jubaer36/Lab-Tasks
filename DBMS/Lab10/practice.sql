-- set SERVEROUTPUT ON;
-- declare
-- VName varchar2(30);
-- begin
-- VName := '&name';
-- dbms_output.put_line('watashi o namayoa ' || VName);
-- end;
-- /

-- declare 
-- VID number;
-- begin
-- VID := '&sid';
-- dbms_output.put_line('student id: ' || VID);
-- end;
-- /

-- begin
-- dbms_output.put_line('Current Time: ' || TO_CHAR(sysdate, 'HH12 :MI:SS'));
-- end;
/

create or replace procedure check_composite_number(input in number , isComposite out number)
as
    i number;
    limit number;
begin
    limit := round(sqrt(input));
    isComposite := 0;
    FOR i in 2..limit loop
        if mod(input , i) = 0
         then
            isComposite := 1;
            EXIT;
        end if;
    end loop;
end;
/

CREATE OR REPLACE PROCEDURE FIND_N_TOP_RATED_MOVIES
AS
    N NUMBER;
BEGIN 
    N:='&NUM';
    SELECT * FROM (select  MOVIE.MOV_ID , MOV_TITLE, REV_ID FROM MOVIE,RATING
    WHERE MOVIE.MOV_ID = RATING.MOV_ID ORDER BY REV_ID DESC) WHERE ROWNUM < N;
END;
/