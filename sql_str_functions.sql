USE parks_and_recreation;

-- String Functions

SELECT *
FROM employee_demographics;

-- MIN,MAX,COUNT

SELECT MIN(age),MAX(age)
FROM employee_demographics
;
SELECT first_name,COUNT(first_name)
FROM employee_demographics
;

-- UPPER,LOWER

SELECT first_name,UPPER(first_name)
FROM employee_demographics
;

-- TRIM,LTRIM,RTRIM,SUBSTRING(str,idx_pos,num_chars)

SELECT TRIM('         SKY     ');
SELECT SUBSTRING('MAINUddin',2,4);

-- REPLACE,LOCATE

SELECT first_name,REPLACE(first_name,'A','T')
FROM employee_demographics
;
SELECT first_name,LOCATE('A',first_name)
FROM employee_demographics
;

-- CONCAT

SELECT first_name,last_name,
CONCAT(first_name,' ',last_name) AS full_name
FROM employee_demographics
;