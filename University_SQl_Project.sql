create database university_system;
use university_system;
create table STUDENT(
ST_ID INT PRIMARY KEY,
ST_NAME VARCHAR(100),
GRADUATION_STATE ENUM('GRADUATED','UNDERGRADUATED'),
ST_LEVEL ENUM('1','2','3','4','5','6','7'),
ST_DEGREE INT
);
CREATE TABLE PROFESSOR(
PR_ID INT PRIMARY KEY,
PR_NAME VARCHAR(100),
DEP_ID int,
QUES_ID int
);
CREATE TABLE DEPARTMENT(
DEP_ID INT PRIMARY KEY,
DEP_NAME VARCHAR(100),
FAC_ID int
);
	
create table faculty(
STUDENT_ID int,
FAC_ID int primary key,
FAC_NAME varchar(100)
);    
ALTER TABLE PROFESSOR ADD FOREIGN KEY (DEP_ID) REFERENCES DEPARTMENT(DEP_ID);
ALTER TABLE DEPARTMENT ADD foreign key (FAC_ID) references faculty(FAC_ID);

CREATE TABLE COURSE(
COURSE_ID INT PRIMARY KEY,
COURSE_NAME varchar(100),
DEP_ID int
);
ALTER TABLE COURSE ADD FOREIGN KEY (DEP_ID) REFERENCES DEPARTMENT(DEP_ID);

CREATE TABLE EXAM(
EX_ID  INT ,
EX_DURATION int,
EX_DATE DATE ,
RESULT_ID INT ,
primary key (EX_ID,RESULT_ID)
);

CREATE TABLE QUES_BANK(
QUES_ID INT,
MARKS INT,
CORRECT_ANSWER TEXT
);

create table exam_development(
PR_ID INT ,
EX_ID INT,
QUES_ID INT,
primary key (PR_ID,EX_iD)
);
ALTER TABLE QUES_BANK ADD PRIMARY KEY (QUES_ID);
alter table exam_development add foreign key (QUES_ID) REFERENCES QUES_BANK(QUES_ID);

CREATE TABLE access_answer(
COURSE_ID INT,
ST_ID INT,
EX_ID INT,
EMAIL TEXT,
PASS VARCHAR(20),
RESULT INT,
RESULT_ID INT,
PRIMARY KEY(ST_ID,EX_ID,RESULT_ID)
);
 alter table access_answer add foreign key  (EX_ID) references EXAM(EX_ID);
 alter table access_answer add foreign key  (ST_ID) references STUDENT(ST_ID);


CREATE TABLE EVALUATION(
ST_ID INT,
PR_ID INT,
COURSE_ID INT,
COMMENT TEXT,
PRIMARY KEY(ST_ID,PR_ID,COURSE_ID)
);

CREATE table PROFESSOR_DEVELOPE(
PR_ID INT primary key,
QUES_ID INT,
 FOREIGN KEY(QUES_ID) REFERENCES QUES_BANK(QUES_ID)
);

CREATE table PROFESSOR_COURSE(
PR_ID INT,
COURSE_ID INT,
PRIMARY KEY(PR_ID,COURSE_ID),
FOREIGN KEY(COURSE_ID) REFERENCES COURSE(COURSE_ID)
);

INSERT INTO STUDENT VALUES 
(1, 'John Doe', 'UNDERGRADUATED', '1', 85),
(2, 'Jane Smith', 'GRADUATED', '4', 90),
(3, 'Alice Johnson', 'GRADUATED', '3', 92),
(4, 'Bob Brown', 'UNDERGRADUATED', '2', 78),
(5, 'Charlie White', 'GRADUATED', '5', 88);

INSERT INTO PROFESSOR VALUES 
(1, 'Dr. Smith', 1, 101),
(2, 'Dr. Adams', 2, 102),
(3, 'Dr. Thompson', 1, 103),
(4, 'Dr. Lee', 3, 104),
(5, 'Dr. Green', 2, 105);
INSERT INTO faculty VALUES 
(1, 1, 'Faculty of Engineering'),
(2, 2, 'Faculty of Science'),
(3, 3, 'Faculty of Arts');

INSERT INTO DEPARTMENT VALUES 
(1, 'Computer Science', 1),
(2, 'Mathematics', 2),
(3, 'Physics', 3);


INSERT INTO QUES_BANK VALUES 
(101, 10, 'A'),
(102, 15, 'B'),
(103, 20, 'C'),
(104, 25, 'D'),
(105, 10, 'A');

INSERT INTO PROFESSOR VALUES 
(1, 'Dr. Smith', 1, 101),
(2, 'Dr. Adams', 2, 102),
(3, 'Dr. Thompson', 1, 103),
(4, 'Dr. Lee', 3, 104),
(5, 'Dr. Green', 2, 105);

INSERT INTO COURSE VALUES 
(1, 'Data Structures', 1),
(2, 'Calculus I', 2),
(3, 'Quantum Physics', 3),
(4, 'Algorithms', 1),
(5, 'Linear Algebra', 2);
INSERT INTO EXAM VALUES 
(1, 120, '2024-06-01', 11),
(2, 90, '2024-06-05', 12),
(3, 180, '2024-06-10', 13);



select * from student;
select * from department;
select * from access_answer;
select * from examques_bank;
show tables;

SELECT TABLE_NAME, COLUMN_NAME, DATA_TYPE, IS_NULLABLE, COLUMN_KEY
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'university_system';



-- The following queries: -
-- Write a query that enables the students to view their results per course
    select ST_NAME,COURSE_NAME,access_answer from
    student join access_answer 
    on student.ST_ID = access_answer.ST_ID
    join 
    course 
    on course.COURSE_ID= access_answer.COURSE_ID;
    
SELECT 
    ST_NAME ,
    COURSE_NAME ,
    RESULT
FROM 
    STUDENT
JOIN 
    access_answer ON STUDENT.ST_ID = access_answer.ST_ID
JOIN 
    COURSE on course.COURSE_ID= access_answer.COURSE_ID;

-- Write a query that enables the head of department to see evaluation of each course and professor.
select PR_NAME,COURSE_NAME,PR_ID
from evaluation join course
on course.COURES_ID = evaluation.COURES_ID
join professor
on professor.PR_ID = evaluation.PR_ID;

SELECT 
    P.PR_NAME AS Professor_Name, 
    C.COURSE_NAME AS Course_Name, 
    P.PR_ID AS Professor_ID
FROM 
    EVALUATION E
JOIN 
    COURSE C ON C.COURSE_ID = E.COURSE_ID
JOIN 
    PROFESSOR P ON P.PR_ID = E.PR_ID;


  
-- Write a query that enables you to get top 10 high scores per course
SELECT 
    C.COURSE_NAME AS Course_Name,
    A.ST_ID AS Student_ID,
    A.RESULT AS Score
FROM 
    ACCESS_ANSWER A
JOIN 
    COURSE C ON A.COURSE_ID = C.COURSE_ID
WHERE 
    A.RESULT IS NOT NULL
    AND (SELECT COUNT(*) 
         FROM ACCESS_ANSWER A2 
         WHERE A2.COURSE_ID = A.COURSE_ID AND A2.RESULT > A.RESULT) < 10
ORDER BY 
    C.COURSE_NAME, A.RESULT DESC;


-- Write a query to get the highest evaluation professor from the set of professors teaching the same course
SELECT 
    C.COURSE_NAME AS Course_Name,
    P.PR_NAME AS Professor_Name,
    MAX(E.COMMENT) AS Highest_Evaluation_Comment
FROM 
    EVALUATION E
JOIN 
    PROFESSOR P ON E.PR_ID = P.PR_ID
JOIN 
    COURSE C ON E.COURSE_ID = C.COURSE_ID
GROUP BY 
    C.COURSE_NAME, P.PR_NAME
ORDER BY 
    C.COURSE_NAME;
