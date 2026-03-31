USE parks_and_recreation;

-- CTE's and TEMPORARY TABLE

SELECT *
FROM employee_salary;

-- Single CTE

WITH CTE_Example AS
(
SELECT dem.first_name,gender,age,salary
FROM employee_demographics AS dem
JOIN employee_salary AS sal
	ON dem.employee_id = sal.employee_id
)
SELECT gender,AVG(salary)
FROM CTE_Example
GROUP BY gender
;

-- Multiple CTE

WITH CTE_Example AS
(
SELECT dem.first_name AS name,gender,age,salary,dept_id
FROM employee_demographics AS dem
JOIN employee_salary AS sal
	ON dem.employee_id = sal.employee_id
),
CTE_Example2 AS
(
SELECT *
FROM parks_departments
)
SELECT dept_id,name,department_name
FROM CTE_Example E1
JOIN CTE_Example2 E2
	ON E1.dept_id = E2.department_id
;

-- TEMPORARY TABLE Example1

CREATE TEMPORARY TABLE example
(
name VARCHAR(50),
age TINYINT,
salary INT
);

INSERT INTO example(name,age,salary)
VALUES('Mainuddin' , 22 , 68000),
('Saniya',20,37000),
('Mubashera',20,40000);

SELECT * FROM example;

-- TEMPORARY TABLE Example2

CREATE TEMPORARY TABLE emp_info
SELECT 
dept_id,first_name AS name ,salary,department_name
FROM employee_salary
JOIN parks_departments
	ON dept_id = department_id;

SELECT *
FROM emp_info;