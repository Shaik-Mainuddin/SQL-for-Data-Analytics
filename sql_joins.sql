USE parks_and_recreation;

-- INNER JOIN,LEFT JOIN,RIGHT JOIN

SELECT *
FROM employee_demographics AS dem
RIGHT JOIN employee_salary AS sal
	ON dem.employee_id = sal.employee_id
;

-- SELF JOIN

SELECT emp1.first_name AS name_santa,
emp1.salary AS santa_salary,
emp2.first_name,
emp2.salary
FROM employee_salary AS emp1
INNER JOIN employee_salary AS emp2
	ON emp1.employee_id + 1 = emp2.employee_id
;

-- Multiple JOIN

SELECT *
FROM employee_demographics AS dem
INNER JOIN employee_salary AS sal
	ON dem.employee_id = sal.employee_id
INNER JOIN parks_departments as pd
	ON pd.department_id = sal.dept_id
;

-- UNION

SELECT first_name,last_name
FROM employee_demographics AS dem
UNION
SELECT first_name,last_name
FROM employee_salary AS sal
;
