CREATE TABLE DEPT (  ------------ SQL Assignment Database
    DEPTNO INT PRIMARY KEY,
    DNAME VARCHAR(255),
    LOC VARCHAR(255)
);


CREATE TABLE EMP (
    EMPNO INT PRIMARY KEY,
    ENAME VARCHAR(255),
    JOB VARCHAR(255),
    MGR INT,
    HIREDATE DATE,
    SAL INT,
    COMM INT,
    DEPTNO INT,
    FOREIGN KEY (DEPTNO) REFERENCES DEPT(DEPTNO)
);


INSERT INTO DEPT (DEPTNO, DNAME, LOC) VALUES
(10, 'ACCOUNTING', 'NEW YORK'),
(20, 'RESEARCH', 'DALLAS'),
(30, 'SALES', 'CHICAGO'),
(40, 'OPERATIONS', 'BOSTON');

SELECT * FROM DEPT


INSERT INTO EMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO) VALUES
(7369, 'SMITH', 'CLERK', 7902, '1980-12-17', 800, NULL, 20),
(7499, 'ALLEN', 'SALESMAN', 7698, '1981-02-20', 1600, 300, 30),
(7521, 'WARD', 'SALESMAN', 7698, '1981-02-22', 1250, 500, 30),
(7566, 'JONES', 'MANAGER', 7839, '1981-04-02', 2975, NULL, 20),
(7654, 'MARTIN', 'SALESMAN', 7698, '1981-09-28', 1250, 1400, 30),
(7698, 'BLAKE', 'MANAGER', 7839, '1981-05-01', 2850, NULL, 30),
(7782, 'CLARK', 'MANAGER', 7839, '1981-06-09', 2450, NULL, 10),
(7788, 'SCOTT', 'ANALYST', 7566, '1982-12-09', 3000, NULL, 20),
(7839, 'KING', 'PRESIDENT', NULL, '1981-11-17', 5000, NULL, 10),
(7844, 'TURNER', 'SALESMAN', 7698, '1981-09-08', 1500, 0, 30),
(7876, 'ADAMS', 'CLERK', 7788, '1983-01-12', 1100, NULL, 20),
(7900, 'JAMES', 'CLERK', 7698, '1981-12-03', 950, NULL, 30),
(7902, 'FORD', 'ANALYST', 7566, '1981-12-03', 3000, NULL, 20),
(7934, 'MILLER', 'CLERK', 7782, '1982-01-23', 1300, NULL, 10);


SELECT * FROM EMP
SELECT * FROM DEPT




--1) Display all the employees who are getting 2500 and excess salaries in department 20.




SELECT * FROM EMP
WHERE SAL >=2500 AND DEPTNO = 20

--2) Display all the managers working in 20 & 30 department

SELECT * FROM EMP
WHERE JOB='MANAGER'
AND DEPTNO IN (20,30)

--3) Display all the managers who don’t have a manager(DONT HAVE CLARITY ON QUESTION)

SELECT * FROM EMP
WHERE JOB = 'MANAGER' 
AND MGR IS NULL;

--4) Display all the employees who are getting some commission with their
--designation is neither MANANGER nor ANALYST

SELECT * FROM EMP
WHERE COMM IS NOT NULL AND
JOB NOT IN ('MANAGER','ANALYST')

--5)Display all the ANALYSTs whose name doesn’t ends with ‘S’ 

SELECT * FROM EMP
WHERE JOB = 'ANALYST' AND
NOT ENAME LIKE '%S' -- END WITH 

SELECT * FROM EMP
WHERE JOB = 'MANAGER' AND
NOT ENAME LIKE 'S%'  -- START WITH

--6)Display all the employees whose naming is having letter ‘E’ as the last but one character

SELECT * FROM EMP
WHERE ENAME LIKE '%E_'

--- IN QUESTION WE NEED TO FINDS OUT THE BEFORE ONE LETTER OF THE ENAME ENDING
--(VALLEY NAME NEED TO IGNORE 'Y')

--7) Display all the employees who total salary is more than 2000.
--(Total Salary = Sal + Comm)

SELECT * FROM EMP
WHERE (SAL + COALESCE(COMM,0))>2000;

COALESCE --used to handle the Null values. The null values are replaced with user-defined values

--In this query, the COALESCE(COMM, 0) function is used to handle the case where 
--the COMM column might be NULL (if an employee doesn't have a commission).
--It replaces NULL with 0, so the total salary calculation is correct.

--8)Display all the employees who are getting some commission in department 20 & 30

SELECT * FROM EMP
WHERE COMM IS NOT NULL AND DEPTNO IN (20,30)

--9)Display all the managers whose name doesn't start with A & S

SELECT * FROM EMP
WHERE JOB='MANAGER' 
AND ENAME NOT LIKE 'A%,S%' 


SELECT * FROM EMP
WHERE JOB='MANAGER' 
AND ENAME NOT LIKE 'A%' AND ENAME NOT LIKE 'S%'

--BOTH ARE SAME

--10) Display all the employees who earning salary not in the range of 2500 and
--5000 in department 10 & 20.

SELECT * FROM EMP
WHERE SAL NOT BETWEEN 2500 AND 5000
AND DEPTNO IN (10,20)




SELECT * FROM EMP

--11) Display job-wise maximum salary.

SELECT MAX(SAL) AS MAXSAL FROM EMP
GROUP BY JOB


--12) Display the departments that are having more than 3 employees under it.

SELECT DEPTNO,COUNT(*) AS EMPLYEECOUNT
FROM EMP
GROUP BY DEPTNO
HAVING COUNT(*)>3


--13) Display job-wise average salaries for the employees whose
--employee number is not from 7788 to 7790.

SELECT JOB,AVG(SAL) AS AVGSALARY 
FROM EMP
WHERE EMPNO  NOT BETWEEN 7788 AND 7790
GROUP BY JOB

--14) Display department-wise total salaries for all the Managers and
--Analysts, only if the average salaries for the same is greater than or equal to 3000

SELECT DEPTNO,SUM(SAL) AS TOTAL_SALARY
FROM EMP
WHERE JOB IN ('MANAGER','ANALYST') 
GROUP BY DEPTNO
HAVING AVG(SAL) <=3000



CREATE TABLE SKILLS (
    ID INT,
    Name VARCHAR(255)
);

INSERT INTO SKILLS (ID, Name) VALUES
(101, 'Oracle'),
(102, 'Oracle'),
(103, 'Oracle'),
(101, 'Oracle'),
(102, 'Java'),
(103, 'Java'),
(101, 'Java'),
(102, 'Java'),
(103, 'Java'),
(101, 'Java'),
(101, 'Java'),
(101, 'Oracle'),
(101, 'VB'),
(102, 'ASP');

SELECT * FROM SKILLS

--15) Select only the duplicate records along-with their count.


SELECT NAME, COUNT(NAME) AS NULL_COUNT 
FROM SKILLS
GROUP BY NAME
HAVING COUNT(NAME) >1

--6) Select only the non-duplicate records\


SELECT DISTINCT Name
FROM SKILLS
WHERE Name NOT IN (
    SELECT Name
    FROM SKILLS
    GROUP BY Name
    HAVING COUNT(*) > 1
);

--17) Select only the duplicate records that are duplicated only once. 

SELECT Name, COUNT(*) AS DuplicateCount
FROM SKILLS
GROUP BY Name
HAVING COUNT(*) = 2;

SELECT * FROM SKILLS

--18) Select only the duplicate records that are not having the id=101.

SELECT Name, COUNT(*) AS DuplicateCount
FROM SKILLS
WHERE ID <> 101
GROUP BY Name
HAVING COUNT(*) > 1;



--19)Display all the employees who are earning more than all the managers.

SELECT * FROM EMP

SELECT ENAME 
FROM EMP
WHERE SAL > ALL(SELECT SAL FROM EMP 
				WHERE JOB = 'MANAGER')


--20)Display all the employees who are earning more than any of the managers

SELECT * FROM EMP
WHERE SAL > ANY (SELECT SAL FROM EMP
				WHERE JOB='MANAGER')

--21)Select employee number, job & salaries of all the Analysts who are earning
--more than any of the managers.


SELECT EMPNO,JOB,SAL FROM EMP
WHERE JOB='ANALYST' AND SAL 
> ALL(SELECT SAL FROM EMP WHERE JOB = 'MANAGER')

--22)Select all the employees who work in DALLAS.


SELECT ENAME FROM EMP
WHERE DEPTNO IN (SELECT DEPTNO FROM DEPT WHERE LOC = 'DALLAS')

--23)Select department name & location of all the employees working for CLARK.

SELECT D.DNAME AS DEPARTMENT_NAME, D.LOC AS DEPARTMENT_LOCATION
FROM EMP E
JOIN DEPT D ON E.DEPTNO = D.DEPTNO
WHERE E.ENAME = 'CLARK';

--24)Select all the departmental information for all the managers

 

SELECT D.* FROM DEPT D
INNER JOIN EMP E ON E.DEPTNO =D.DEPTNO
WHERE E.JOB='MANAGER';

--25)Display the first maximum salary.

SELECT SAL AS SECOND_MAX_SALARY
FROM (
    SELECT SAL, ROW_NUMBER() OVER (ORDER BY SAL DESC) AS RN
    FROM EMP
) AS EMP_SAL

WHERE RN = 1;


--26)Display the SECOND maximum salary.


SELECT SAL AS SECOND_MAX_SALARY
FROM (
    SELECT SAL, ROW_NUMBER() OVER (ORDER BY SAL DESC) AS RN
    FROM EMP
) AS EMP_SAL
WHERE RN = 2;

--27)Display the third maximum salary.

SELECT SAL AS THIRD_MAXSAL
FROM (
		SELECT SAL, ROW_NUMBER() OVER (ORDER BY SAL DESC) AS RN
		FROM EMP
		) AS EMP_SAL

		WHERE RN = 3;

--28)Display all the managers & clerks who work in Accounts and Marketing departments.

SELECT *
FROM EMP
WHERE JOB IN ('MANAGER', 'CLERK')
AND DEPTNO IN (
    SELECT DEPTNO
    FROM DEPT
    WHERE DNAME IN ('ACCOUNTING', 'MARKETING')
);


--29)Display all the salesmen who are not located at DALLAS.

SELECT * FROM EMP
SELECT * FROM DEPT


SELECT *
FROM EMP
WHERE JOB = 'SALESMAN'
AND DEPTNO NOT IN (
    SELECT DEPTNO
    FROM DEPT
    WHERE LOC = 'DALLAS'
);


--30) Get all the employees who work in the same departments as of SCOTT.

SELECT *
FROM EMP
WHERE DEPTNO IN (
    SELECT DEPTNO
    FROM EMP
    WHERE ENAME = 'SCOTT'
);

			
			
--31) Select all the employees who are earning same as SMITH.

SELECT *
FROM EMP
WHERE SAL = (
    SELECT SAL
    FROM EMP
    WHERE ENAME = 'SMITH'
);


--32) Display all the employees who are getting some commission in
--marketing department where the employees have joined only on weekdays

SELECT *
FROM EMP
WHERE JOB = 'SALESMAN'
AND DEPTNO = (
    SELECT DEPTNO
    FROM DEPT
    WHERE DNAME = 'MARKETING'
)
AND DATEPART(WEEKDAY, HIREDATE) BETWEEN 2 AND 6;

--33) Display all the employees who are getting more than the
--average salaries of all the employees.


SELECT *
FROM EMP
WHERE SAL > (
    SELECT AVG(SAL)
    FROM EMP
);



SELECT * FROM EMP
SELECT * FROM DEPT

SELECT * FROM SKILLS

--34)Display all the managers & clerks who work in Accounts and Marketing
--departments.

SELECT EMP.*
FROM EMP
JOIN DEPT ON EMP.DEPTNO = DEPT.DEPTNO
WHERE EMP.JOB IN ('MANAGER', 'CLERK')
AND DEPT.DNAME IN ('ACCOUNTING', 'MARKETING');

--35)Display all the salesmen who are not located at DALLAS.


SELECT EMP.*
FROM EMP
JOIN DEPT ON EMP.DEPTNO = DEPT.DEPTNO
WHERE EMP.JOB = 'SALESMAN'
AND DEPT.LOC <> 'DALLAS';

--36)Select department name & location of all the employees working for CLARK.

SELECT EMP.ENAME,EMP.JOB,DEPT.DNAME,DEPT.LOC FROM EMP--SELF MADE MY OWN 
JOIN DEPT
ON EMP.DEPTNO = DEPT.DEPTNO
WHERE EMP.JOB = 'CLERK'

--37)Select all the departmental information for all the managers

SELECT DEPT.*,EMP.JOB FROM DEPT -- SELF MADE
JOIN EMP ON DEPT.DEPTNO = EMP.DEPTNO
WHERE EMP.JOB = 'MANAGER'

--38)Select all the employees who work in DALLAS.

SELECT EMP.ENAME FROM EMP
JOIN DEPT ON EMP.DEPTNO= DEPT.DEPTNO
WHERE DEPT.LOC = 'DALLAS'

--39) Delete the records from the DEPT table that don’t have
--matching records in EMP

DELETE FROM DEPT
WHERE DEPTNO NOT IN (
    SELECT D.DEPTNO
    FROM DEPT D
    JOIN EMP E ON E.DEPTNO = D.DEPTNO )

--40)Display all the departmental information for all the existing employees and if
--a department has no employees display it as “No employees”.


SELECT D.DEPTNO, D.DNAME, D.LOC, COALESCE (COUNT(E.EMPNO), 'NO EMPLOYEE') AS EMPLOYEE_COUNT
FROM DEPT D --COALESCE:- RETURN THE ARGUMENT THAT DOES NOT EVALUATE TO A BLANK VALUE, 
--IF ALL ARGUMENTS ARE BLANK,IT WILL RETURNS THE BLANK.
LEFT OUTER JOIN EMP E ON D.DEPTNO = E.DEPTNO
GROUP BY D.DEPTNO, D.DNAME, D.LOC;

--41)Get all the matching & non-matching records from both the tables.

SELECT 
    COALESCE(D.DEPTNO, E.DEPTNO) AS DEPTNO,
    D.DNAME AS DEPARTMENT_NAME,
    D.LOC AS DEPARTMENT_LOCATION,
    E.EMPNO,
    E.ENAME,
    E.JOB,
    E.MGR,
    E.HIREDATE,
    E.SAL,
    E.COMM
FROM DEPT D
FULL OUTER JOIN EMP E
    ON D.DEPTNO = E.DEPTNO
ORDER BY COALESCE(D.DEPTNO, E.DEPTNO);

--42)Get only the non-matching records from DEPT table (matching records
--shouldn’t be selected).

SELECT D.*
FROM DEPT D
LEFT OUTER JOIN EMP E
    ON D.DEPTNO = E.DEPTNO
WHERE E.DEPTNO IS NULL;

--43)Select all the employees name along with their manager names, and if an
--employee does not have a manager, display him as “CEO”.


SELECT
    E.ENAME AS EMPLOYEE_NAME,
    COALESCE(M.ENAME, 'CEO') AS MANAGER_NAME
FROM EMP E
LEFT JOIN EMP M ON E.MGR = M.EMPNO;

--44)Get all the employees who work in the same departments as of SCOTT


SELECT E.ENAME FROM EMP E
JOIN EMP S ON E.DEPTNO = S.DEPTNO
WHERE S.ENAME = 'SCOTT' AND E.ENAME != 'SCOTT'

--45)Display all the employees who have joined before their managers.


SELECT E.ENAME,E.JOB,E.HIREDATE
FROM EMP E
JOIN EMP M ON E.MGR = M.EMPNO
WHERE E.HIREDATE < M.HIREDATE;

--46)List all the employees who are earning more than their managers.

SELECT E.ENAME, E.SAL FROM EMP E
JOIN EMP M ON E.MGR=M.EMPNO
WHERE E.SAL > M.SAL


--47)Fetch all the employees who are earning same salaries.

SELECT E.ENAME,E.SAL FROM EMP E 
JOIN EMP M ON E.SAL=M.SAL
WHERE E.EMPNO!=M.EMPNO 
ORDER BY E.SAL

--48)Select all the employees who are earning same as SMITH.

SELECT E.ENAME,E.SAL FROM EMP E 
JOIN EMP M ON E.SAL=M.SAL
WHERE E.EMPNO !=M.EMPNO AND M.ENAME ='SMITH'
ORDER BY E.SAL

--49) Display employee name , his date of joining, his manager name & his
--manager's date of joining.

SELECT E.ENAME AS EMPNAME,E.HIREDATE AS MHIREDATE,
M.MGR AS MANAGERNAME,
M.HIREDATE AS MHIREDATE 
FROM EMP E 
LEFT JOIN EMP M ON E.MGR= M.EMPNO

SELECT E.ENAME AS EMPLOYEE_NAME,
       E.HIREDATE AS EMPLOYEE_HIREDATE,
       COALESCE (M.ENAME,'N/A') AS MANAGER_NAME,
           M.HIREDATE AS MANAGER_HIREDATE
FROM EMP E
LEFT JOIN EMP M ON E.MGR = M.EMPNO;



SELECT * FROM EMP
SELECT * FROM DEPT







