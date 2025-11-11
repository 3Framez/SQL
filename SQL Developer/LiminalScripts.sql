-- A database is a collection of objects and the most important object within a database are tables
-- oracle is a software installed on a server, these server has multiple databases 
--When a database is queried it first, evaluates the source (FROM clause) of the data, and then the WHERE clause (filteration), and then the SELECT clause 
--Database processes the FROM clause first, and then the WHERE for further filtering, and lastly the SELECT clause
--Syntax error vs Logical error

-- SELECT * FROM EMP;

SELECT *
FROM EMP
WHERE COMM IS NULL
AND JOB = 'MANAGER'
AND SAL > 2500;

-- 
SELECT * 
FROM EMP 
WHERE SAL BETWEEN 5000 AND 1000

--
SELECT * 
FROM EMP 
WHERE DEPTNO IN (20, 30)

-- wildcards
SELECT * 
FROM EMP
WHERE JOB LIKE '%GER' 

-- renaming columns
SELECT ENAME AS "EMPLOYEE NAME" 
FROM EMP 


-- concatinating columns together with words 
SELECT ENAME || ' MAKES $' || SAL || ' PER MONTH ' AS "NAME AND SALARY"
FROM EMP

-- ORDER BY clause to sort an entire recrod by a single column 
SELECT ENAME, SAL
FROM EMP
ORDER BY SAL DESC, ENAME ASC


--QUESTIONS 1
SELECT * FROM SUPPLIER WHERE STATE IN ('GEORGIA', 'CALIFORNIA')
SELECT * FROM SUPPLIER WHERE SUPPLIER_NAME LIKE '%wo%' OR SUPPLIER_NAME LIKE '%I&' OR SUPPLIER_NAME LIKE '%i%'
SELECT * FROM SUPPLIER WHERE TOTAL_SPENT BETWEEN 80000 AND 37000
SELECT SUPPLIER_NAME, STATE FROM SUPPLIER WHERE STATE IN ('GEORGIA', 'ALASKA') AND (SUPPLIER_ID = 100 OR SUPPLIER_ID > 600) AND (TOTAL_SPENT = 220000 OR TOTAL_SPENT < 100000)
FALSE --SQL is case insensitive 
FALSE --Database processes the FROM clause first, and then the WHERE for further filtering, and lastly the SELECT clause
TRUE
TRUE
FALSE
--QUESTIONS 2
SELECT CONCAT(CONCAT(NAME, ' HAS THE POPULATION OF '), POPULATION) FROM CITY WHERE COUNTRYCODE = 'cbd'
SELECT CONCAT(CONCAT(SUBSTR(LOWER(DISTRICT),1,3),'-'),SUBSTR(LOWER(DISTRICT),-3,3)) FROM EMP
-2
SELECT MONTHS_BETWEEN(LAST_DAY(TO_DATE('15-JAN-12', 'DD-MM-YY')) + 1, TO_DATE('01-APR-12', 'DD-MM-YY')) FROM DUAL
FALSE --chronological order (small to big) gives a negative number

FALSE --it can take numbers and dates as parameters as well
TRUE

B --they always return a value
A
TRUE
TRUEISH --it works only on number, date and string data types





SELECT * 
FROM EMP
WHERE JOB LIKE '%RES%'
AND (JOB LIKE '%NAG%'
OR JOB LIKE '%LES%');





--SINGLE ROW FUNCTIONS operates on each row individually and returns one result per row

--Character based SR functions (UPPER/LOWER/CONCAT) as they work on strings. TO_CHAR is a conversion based SR function

--Concatenation
SELECT CONCAT(' MY NAME IS ', ENAME) AS "EMPLOYEE NAMES"
FROM EMP

--Lower Case and Upper Case 
SELECT LOWER(ENAME) 
FROM EMP

SELECT CONCAT(CONCAT(CONCAT(LOWER(ENAME), UPPER(' is the name ')),LOWER(' AND THEIR JOB IS ')), JOB) AS "NAMES AND JOBS"
FROM EMP

SELECT *
FROM EMP
WHERE JOB = UPPER('Manager')

-- order by lenth of names
SELECT ENAME, LENGTH(ENAME) AS "LENGTH OF NAME" FROM EMP
ORDER BY "LENGTH OF NAME" DESC


--Give me the hiredates of employees that began in the beginning of the year
SELECT ENAME, HIREDATE, TRUNC(HIREDATE, 'MONTH')
FROM EMP
WHERE TRUNC(HIREDATE, 'YEAR') = '01/01/1981'
--Using TO_CHAR to change date and salary format
SELECT ENAME, TO_CHAR(HIREDATE, 'DDTH - MONTH - YYYY') AS "DATE OF HIRE", TO_CHAR(SAL, '$99,999.99') AS SALARY
FROM EMP

--testing functions on the DUAL table

SELECT * FROM DUAL

SELECT 'PIZZA' AS FOOD, ' WATER ' AS DRINK FROM DUAL

SELECT INITCAP('hello my name is ephraim') FROM DUAL

SELECT LENGTH('EPHRAIM IS ME') FROM DUAL

--substring SUBSTR('*string*', *begining of extraction*, *number of characters to be extracted*)
SELECT SUBSTR('HELLO MY NAME IS ',7,14), LENGTH(SUBSTR('HELLO MY NAME IS ',7,14)) AS "LENGTH OF SUBSTRING" FROM DUAL

--LPAD function adds characters to the left side LPAD(*string*, length of entire string, 'characters you want to add')
SELECT LPAD('HELLO', 10, '$') FROM DUAL

--RTRIM functions trims characters from the right side that you want to remove RTRIM('string','characters you want removed')
SELECT RTRIM('HELLO$$$$$$$$$$', '$') FROM DUAL


-- NUMERIC SRF

--ROUND
SELECT ROUND(100.088,2) FROM DUAL

--TRUNC removes numbers after the decimal point or when paired with a date, reverses the date to the first
SELECT TRUNC(100.088,2) FROM DUAL
SELECT SYSTIMESTAMP, TRUNC(SYSTIMESTAMP) FROM DUAL
SELECT TRUNC(SYSTIMESTAMP, 'MONTH') FROM DUAL  -- truncates the month from current to the first month




-- DATE/TIME FUNCTIONS

-- returns the date of the system
SELECT SYSDATE FROM DUAL
--Returns the date and timestamp
SELECT SYSTIMESTAMP FROM DUAL
-- It goes to the future/past depending on the argument given
SELECT ADD_MONTHS('11/17/2012',-3) FROM DUAL
-- Returns the number of months between 2 dates
SELECT TRUNC(MONTHS_BETWEEN(SYSDATE, '11/17/2012')) FROM DUAL

--TO_CHAR converts dates abd bumbers to a character datatype 
SELECT TO_CHAR(SYSDATE, 'MONTH DAY YEAR' ) FROM DUAL  --Converting the date format to a different date format  
SELECT TO_CHAR(SYSDATE, 'DDTH "OF" MONTH, YYYY' ) FROM DUAL
SELECT TO_CHAR(123, '$999.99' ) FROM DUAL

--TO_DATE converts a string to a date datatype
SELECT TO_DATE('2012-08-27', 'YYYY-MM-DD') FROM DUAL 
SELECT ADD_MONTHS(TO_DATE('2012-08-27', 'YYYY-MM-DD'),2) FROM DUAL -- after its converted to a date data type, you can then use date-type functions like add_months 


-- NVL functions replaces every null value with a given value 
SELECT ENAME, JOB, SAL, NVL(TO_CHAR(COMM), 'NO DATA FOUND') AS COMMISION  --COMM takes numeric and null values, so convert (typecast) to string using TO_CHAR, so the NVL function can take a string replacement
FROM EMP
WHERE EMPNO IN (7839, 7698, 7566, 7654)

--NULLIF(arg1,arg2) to check if a condition is true
SELECT ENAME, LENGTH(ENAME), NULLIF(LENGTH(ENAME), 5) --gives an empty cell where the length of ename = 5
FROM EMP
--for every null value, replace with 'length is equal to 5'
SELECT ENAME, LENGTH(ENAME), NVL(TO_CHAR(NULLIF(LENGTH(ENAME), 5)), 'LENGTH IS EQUAL TO 5') AS "LENGTH OF NAME" --gives an empty cell where the length of ename = 5
FROM EMP

SELECT 'PIZZA' AS FOOD FROM DUAL








-- GROUP ROW FUNCTIONS (cant be used in the WHERE clause unlike SRF), evaluates multiple records (rows) and outputs a single value

SELECT * 
FROM EMP
-- These are all evaluate multiple rows and outputs a single value
SELECT  MAX(SAL), MIN(SAL), SUM(SAL), MAX(COMM), ROUND(AVG(SAL),2), COUNT(*)
FROM EMP
--Higest paid manager 
SELECT MAX(SAL)
FROM EMP
WHERE JOB = 'MANAGER'
--
SELECT MAX(SAL)
FROM EMP
WHERE JOB IN ('MANAGER', 'ANALYST', 'PRESIDENT') --out of the given job titles, which job title has the highest salary

--Total number of salaries divided by the total number of records
SELECT SUM(SAL) / COUNT(*) AS "AVERAGE SALARY"
FROM EMP 
--The average salary of each job title uaing the group by clause. This clause allows you to output more than 1 value in the result set
SELECT JOB, ROUND(AVG(SAL),1) "AVERAGE SALARY", MAX(SAL)
FROM EMP
GROUP BY JOB
ORDER BY "AVERAGE SALARY" DESC
--counts the number of occurences of each job in the table
SELECT COUNT(*), JOB
FROM EMP
GROUP BY JOB
--Having clause is like the where clause that allows further filtering, and its reserved for group row functions. The WHERE clause dont tallow group row functions
SELECT  JOB
FROM EMP
GROUP BY JOB
HAVING COUNT(*) = 2  --which job title has only two employees

--return deptno that have more than 3 employees working in them
SELECT COUNT(*), DEPTNO
FROM EMP
GROUP BY DEPTNO
HAVING COUNT(*) > 3
ORDER BY 1 --meaning order by the first column

SELECT COUNT(*), JOB 
FROM EMP
GROUP BY JOB

--GROUP BY multiple columns 
--For every unique job title with deptno, it outputs 1 value. for example analyst(2 in 20) and salesman (4 in 30)...
--...occur multiple times in deptno 20 and 30, so it gives 1 analyst and 1 salesmane  per deptno...
--...there are 3 occurences of manager with different deptno, so the result is 3 (rows of) managers (1 for each deptno)
SELECT JOB, DEPTNO, COUNT(*)
FROM EMP
GROUP BY JOB, DEPTNO  --RULE OF THUMB: Every column in the select clause (excluding grouping functions ) must be in the group by clause
ORDER BY 3 DESC

--this only displays the job, but groups by job AND deptno, meaning multiple jobs can occur in a single dpetno
SELECT JOB, COUNT(*) --the count displays this relationship, wherein there are 2 analyst in a single deptno, but 3 managers in differnt dpento 
FROM EMP
GROUP BY JOB, DEPTNO --RULE OF THUMB: the group by clause can have additional columns that aren't present in the select clause


-- SUBQUERIES allows flexibility in queries, but they are slower as they're running multiple queries after another 
SELECT *
FROM DEPT
WHERE DEPTNO < (SELECT DEPTNO FROM DEPT WHERE DEPTNO = 30) --output records in which deptno is less than 30
-- the column (deptno) used in the WHERE clause must be present in the subquery otherwise it returns a :too many values error

SELECT LOC
FROM (SELECT * FROM DEPT) -- SELECT *2...give me this* FROM (*1...out of this multitude of data* )

--Relating two seperate tables using SUBQUERIES
SELECT * 
FROM EMP
WHERE DEPTNO IN (SELECT DEPTNO FROM DEPT WHERE LOC  IN ('CHICAGO', 'NEW YORK')) --the DEPTNO is what is common between the two tables and it is used to relate these two tables together
--RULE OF THUMB: ...WHERE DEPTNO = () ; The subquery must return a single value, because of the equality operator

-- SUBQUERY IN THE SELECT CLAUSE
SELECT JOB, ENAME, (SELECT JOB FROM EMP WHERE ENAME = 'KING') --Like subqueries in the where, this subquery must be a single value/single row
FROM EMP

SELECT JOB, ENAME, (SELECT * FROM DUAL) --This subquery works because the DUAL table has a single value
FROM EMP


-- JOINS 

--forming a relationship between two tables based on their common column DEPTNO
SELECT  E.ENAME, E.JOB, E.SAL
--Using aliases on tables like, E,D to help differentiate the source of the columns in the SELECT clause. We dont use AS (only reserved for aliasing  columns)WHERE E.DEPTNO = D.DEPTNO  --omits the DEPTNO 40, as it doesnt exist in the EMP table
AND D.LOC = 'DALLAS'

-- Subquery filtering in the FROM clause using both tables 
SELECT  E.ENAME, E.JOB, E.SAL
FROM (SELECT * FROM EMP WHERE JOB IN ('MANAGER', 'CLERK') ) E, (SELECT * FROM DEPT WHERE LOC = 'DALLAS') D -- 
WHERE E.DEPTNO = D.DEPTNO  

--INNER JOIN
SELECT * 
FROM EMP E INNER JOIN  DEPT D
ON E.DEPTNO = D.DEPTNO 

--RIGHT JOIN/RIGHT OUTER JOIN
SELECT * 
FROM EMP E RIGHT JOIN  DEPT D --giving presidence to the DEPT table. Meaning give me all of the data in the table to the right first, and then the matching rows to the left
ON E.DEPTNO = D.DEPTNO --includes DEPTNO 40

--LEFT JOIN/LEFT OUTER JOIN
SELECT * 
FROM EMP E LEFT JOIN  DEPT D --giving presidence to the EMP table. Meaning give me all of the data in the table to the left first, and then the matching rows to the right
ON E.DEPTNO = D.DEPTNO -- omits the DEPTNO 40, as  there is no relationship

--FULL OUTER JOIN/FULL JOIN
SELECT * 
FROM EMP E FULL JOIN  DEPT D --gives all the data in both tables
ON E.DEPTNO = D.DEPTNO;

SELECT * FROM EMP;

