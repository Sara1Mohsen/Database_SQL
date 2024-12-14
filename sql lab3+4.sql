drop table employee;

create table employee(
ssn int primary key not null,
fname varchar(50),
lname varchar(50),
B_Date date,
Address text,
salary int,
gender  enum('m','f'),
superssn int ,
Dno int not null
);

Alter table employee
modify column Address text;
INSERT INTO employee (fname, lname, ssn, B_Date, Address, gender, salary, superssn,Dno) 
VALUES
('Ahmed', 'Ali', '112233', '1965-01-01', '15 Ali fahmy St.Giza', 'm', 1300, '223344','10'),
('Kamel', 'Mohamed', '223344', '1970-10-15', '38 Mohy el dien abo el Ezz St.Cairo', 'm', 1800, '321654','10'),
('Hanaa', 'Sobhy', '123456', '1973-03-18', '38 Abdel Khalik Tharwat St. Downtown.Cairo', 'f', 800, '223344','10'),
('Amr', 'Omran', '321654', '1963-09-14', '44 Hilopolis.Cairo', 'm', 2500, NULL ,'10'),
('Noha', 'Mohamed', '968574', '1975-02-01', '55 Orabi St. El Mohandiseen .Cairo', 'f', 1600, '321654','20'),
('Edward', 'Hanna', '512463', '1972-08-19', '18 Abaas El 3akaad St. Nasr City.Cairo', 'M', 1500, '321654','30'),
('Mariam', 'Adel', '669955', '1982-06-12', '269 El-Haram st. Giza', 'F', 750, '512463','20'),
('Maged', 'Raoof', '521634', '1980-04-06', '18 Kholosi st.Shobra.Cairo', 'M', 1000, '968574','30');


create table Departments(
Dname varchar(50),
Dnum int primary key,
MGRSSN int,
MGRStart date
);
INSERT INTO Departments (Dname, Dnum, MGRSSN, MGRStart)
VALUES
('DP1', 10, '223344', '2005-01-01'),
('DP2', 20, '968574', '2006-03-01'),
('DP3', 30, '512463', '2006-06-01');



create table Works_for(
ESSN Varchar(20),
Pno int,
Hours int,
primary key( ESSN ,Pno));

INSERT INTO Works_for (ESSN, Pno, Hours)
VALUES
('223344', 100, 10),
('223344', 200, 10),
('223344', 300, 10),
('112233', 100, 40),
('968574', 400, 15),
('968574', 700, 15),
('968574', 300, 10),
('669955', 400, 20),
('223344', 500, 10),
('669955', 700, 7),
('669955', 300, 10),
('512463', 500, 10),
('512463', 600, 25),
('521634', 500, 10),
('521634', 600, 20),
('521634', 300, 6),
('521634', 400, 4);

create table Project (
 Pname VARCHAR(50),
 Pnumber INT PRIMARY KEY,
 Pnumber VARCHAR(100),
 City VARCHAR(50),
 Dnum INT);
 
INSERT INTO Project (Pname, Pnumber, Plocation, City, Dnum)
VALUES
('AL Solimaniah', 100, 'Cairo_Alex Road', 'Alex', 10),
('Al Rabwah', 200, '6th of October City', 'Giza', 10),
('Al Rawdah', 300, 'Zaied City', 'Giza', 10),
('Al Rowad', 400, 'Cairo_Faiyom Road', 'Giza', 20),
('Al Rehab', 500, 'Nasr City', 'Cairo', 30),
('Pitcho American', 600, 'Maady', 'Cairo', 30),
('Ebad El Rahman', 700, 'Ring Road', 'Cairo', 20);

CREATE TABLE Dependent (
    ESSN VARCHAR(9),   
    Dependent_name VARCHAR(100), 
    gender enum('m','f'),            
    B_Date DATE,
    primary key(ESSN,Dependent_name)
);
INSERT INTO Dependent (ESSN, Dependent_name, gender, B_Date)
VALUES
('112233', 'Hala Saied Ali', 'F', '1970-10-18'),
('223344', 'Ahmed Kamel Shawki', 'M', '1998-03-27'),
('223344', 'Mona Adel Mohamed', 'F', '1975-04-25'),
('321654', 'Ramy Amr Omran', 'M', '1990-01-26'),
('321654', 'Omar Amr Omran', 'M', '1993-03-30'),
('321654', 'Sanaa Gawish', 'F', '1973-05-16'),
('512463', 'Sara Edward', 'F', '2001-09-15'),
('512463', 'Nora Ghaly', 'F', '1976-06-22');

show tables;
select * from employee;

select fname,lname,salary,Dnum from employee,Departments;

select ssn ,fname ,lname from employee where salary >1000;



ALTER TABLE employee
DROP COLUMN Dno;
ALTER TABLE employee
ADD Dno INT NOT NULL;



select * from employee;
select * from Departments;


ALTER TABLE employee
ADD CONSTRAINT Dno
FOREIGN KEY (Dno) REFERENCES Departments(Dnum);

alter table Departments
add constraint MGRSSN
foreign key (MGRSSN) references employee(ssn);

alter table Project 
	add constraint Dnum
foreign key (Dnum) references Departments(Dnum);
 

alter table Works_for
add constraint Pno
foreign key(Pno) references Project(Pnumber);



alter table employee 
add constraint superssn
foreign key (superssn) references employee(ssn);

ALTER TABLE Works_for
ADD CONSTRAINT fk_works_for_project
FOREIGN KEY (Pno) REFERENCES Project(Pnumber);

-- 3 quary 
-- Display the employees Id, name who earns more than 10000 LE annually. 

select ssn as employees_Id,
concat(fname,'' ,lname) as name,
salary * 12 as annually_sal
 from employee where salary * 12 >10000 ;
 
 -- quary 4
 -- Display the names and salaries of the female employees  
select salary ,concat(fname,'' ,lname) as name
from employee where gender = 'f';

--  quary 6
-- Display each department id, name which managed by a manager with id equals 968574.

select  Dnum , Dname from Departments where MGRSSN = "968574"; 

-- quary 7
-- Display the ids, names and locations of  the projects which controlled with department 10. 
select Pnumber ,Pname, concat(Plocation,' , ', city) as location from Project
where Dnum = 10;

-- quary 8
-- 8. Display all the projects names, locations and the department which is responsible about it.
select Project.Pname ,Project.Plocation ,
Departments.Dname AS Responsible_Department
from  Project inner join Departments on 
Project.Dnum = Departments.Dnum;

-- 9. If you know that the company policy is to pay an annual


select concat(fname,'' ,lname) as name,
(salary*12*0.10) as "ANNUAL COMM" from employee;


-- 1. Insert your personal data to the employee table as a new employee in department number 30, SSN = 102672, Superssn = 112233. 
insert into employee (ssn ,superssn,Dno) values 
(102672 ,112233 ,30);
-- 2
insert into employee (ssn ,superssn,Dno,salary) values 
(102660 ,null ,30 ,null);
--  3
INSERT INTO Departments (Dnum, MGRSSN, Dname, MGRStart) 
VALUES (100, 112233, 'DEPTI', '2006-11-01');

-- 4

update Departments 
set MGRSSN = 968574 where Dnum = 100;

update Departments
set MGRSSN = 112233 where Dnum = 20;

update employee
set superssn = 112233 where ssn =102660;



-- Lab 4

-- 1. Display the Department id, name and id and the name of its manager.
select departments.Dname,departments.Dnum, employee.ssn ,
concat(fname ,'',lname) as fullname from employee join departments
on employee.ssn = departments.MGRSSN;


-- 2. Display the name of the departments and the name of the projects under its control.

select departments.Dname,project.Pname from
departments join project on departments.Dnum=project.Dnum;

-- 3. Display the full data about all the dependence associated with the name of the employee they depend on him/her.
select * from dependent join employee on employee.ssn =dependent.ESSN;


-- 4. Display the full data of the employees who is managing any of the company's departments.
select * from employee join departments on departments.MGRSSN=employee.ssn;

-- 5. Display the Id, name and location of the projects in Cairo or Alex city.
select project.Pname , project.Plocation ,project.Pnumber from project 
where project.Plocation in ('nasr city' ,'Alex city');


-- 6. Display the Projects full data of the projects with a name starts with "a" letter.
select * from project where project.Pname like 'a%';


-- 7. display all the employees in department 30 whose salary from 1000 to 2000 LE monthly
select * from employee join departments 
on employee.Dno = departments.Dnum
where departments.Dnum = 30 and  employee.salary between 1000 and 2000;


select * from Departments;

-- 8. Retrieve the names of all employees in department 10 who works more than or equal10 hours per week on "AL Rabwah" project.
-- select concat(fname, '',lname ) from employee join works_for
-- on employee.ssn = works_for.ESSN
-- join project on project.Pno = works_for.Pno
-- where employee.Dno=10 and works_for.Hours =10 and project.Pname ='AL Rabwah';
 

-- 9. Find the names of the employees who directly supervised with Kamel Mohamed.

SELECT 
    CONCAT(emp.fname, ' ', emp.lname) AS "name"
FROM 
    employee emp
JOIN 
    employee supervisor ON emp.superssn = supervisor.ssn
WHERE 
    supervisor.fname = 'Kamel' AND supervisor.lname = 'Mohamed';


SELECT 
    CONCAT(e.fname, ' ', e.lname) AS employee_name
FROM 
    employee e
JOIN 
    employee supervisor ON e.superssn = supervisor.ssn
WHERE 
    supervisor.fname = 'Kamel' AND supervisor.lname = 'Mohamed';




SELECT e.fname AS "First Name", e.lname AS "Last Name" FROM employee e WHERE employee.superssn = (
SELECT ssn FROM employee WHERE fname = 'Kamel' AND lname = 'Mohamed' );



-- 10. For each project, list the project name and the total hours per week (for all employees) spent on that project.
select * from works_for ;
select sum(works_for.Hours) from works_for 
group by project.Pname , project.Pnumber;


SELECT p.Pname AS "Project Name", SUM(w.Hours) AS "Total Hours Per Week" FROM project p
JOIN works_for w ON p.Pnumber = w.Pno
GROUP BY p.Pname
;

-- 11. Retrieve the names of all employees who work in every project sorted.

select distinct concat(fname, '' ,lname )
as "all_employees" ,project.Pname from employee 
join project on
employee.Dno = project.Dnum
order by pname;



-- 12. Display the data of the department which has the smallest employee ID over all employees' ID.
select * from departments join employee
on departments.Dnum = employee.Dno
where employee.ssn= (select min(ssn)from employee);


-- 13. For each department, retrieve the department name and the maximum, minimum and average salary of its employees.


select departments.Dname ,max(employee.salary) as maxsal ,
min(employee.salary) as minsal , avg(employee.salary)

from departments join employee
on departments.Dnum = employee.Dno 
group by departments.Dname;


-- 14. List the last name of all managers who have no dependents.


select lname from employee where
employee.ssn in (select employee.superssn)
and ssn not in (select dependent.ESSN from dependent);

select employee.Lname as Manager_Last_Name
from Employee 
join Departments  on employee.SSN = departments.MGRSSN
left join Dependent  on employee.SSN = dependent.ESSN
where dependent.ESSN;



