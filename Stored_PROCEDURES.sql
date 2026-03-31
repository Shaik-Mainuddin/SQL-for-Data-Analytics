-- Stored PROCEDURES :

-- PROCEDURE procedure_name() , BEGIN , END , DELIMETER $$

USE parks_and_recreation;

SELECT *
FROM employee_salary;

-- Example 1

DELIMITER $$
CREATE PROCEDURE example1()
BEGIN
	SELECT *
    FROM employee_salary
    WHERE salary >= 50000;
END $$
DELIMITER ;

CALL example1();

-- Example 2 with parameters

DELIMITER $$
CREATE PROCEDURE example2(param_emp_id TINYINT)
BEGIN
	SELECT employee_id,first_name,last_name,salary
    FROM employee_salary
    WHERE employee_id = param_emp_id
    ;
END $$
DELIMITER ;

CALL example2(6);