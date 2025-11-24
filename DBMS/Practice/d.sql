select dName , LOCATION from Depts
where dName like 'C%' and '%E';

select Employees.Name , Employees.Designation , nvl(Depts.SIZE,0)
from Employees,Depts where
Employees.Dept = Dept.dname;

select dept , count(SID) as StudentTotal from 
Students , Depts where
Students.dept = Dept.dname
group by dept having StudentTotal >= 400;

select Employees.Name ,workingYear, Employees.Designation from Employees 
where monthsbetween (sysdate, JOININGDATE)/12 as workingYear > 5; 