connect j210041226/cse4308;
drop role Students;
drop role Course_Teacher;
drop role Dept_Head;
drop role Administrator;

drop user viewer;
drop user admin;




create or replace view Advisor_Selection as 
    select instructor.ID , instructor.name , instructor.dept_name 
    from instructor;

select * from Advisor_Selection;

create or replace view Student_Count as
    select Advisor_Selection.name , count(advisor.s_ID) as std_count 
    from Advisor_Selection
    natural join advisor
    group by advisor.i_ID, Advisor_Selection.name;

select * from Student_Count;

create role Students;
create role Course_Teacher;
create role Dept_Head;
create role Administrator;


grant select on advisor to Students;
grant select on course to Students;


grant select on student to Course_Teacher;
grant select on course to Course_Teacher;

grant Course_Teacher to Dept_Head;
grant insert on instructor to Dept_Head;

grant select on department to Administrator;
grant select on instructor to Administrator;
grant update(budget) on department to Administrator;



create user viewer identified by view;
grant create session , resource to viewer;
grant students to viewer;

create user admin identified by admin;
grant create session , resource , create tablespace to admin;
grant Administrator to admin;


connect viewer/view;
select * from j210041226.course;
insert into j210041226.advisor values('324','456');

connect admin/admin;
select * from j210041226.instructor;





