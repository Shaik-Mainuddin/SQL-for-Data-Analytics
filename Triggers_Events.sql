-- TRIGGERS and EVENTS:

USE parks_and_recreation;

SELECT *
FROM employee_salary;

-- TRIGGER :

DELIMITER $$
CREATE TRIGGER emp_insert2
	AFTER INSERT ON employee_salary
    FOR EACH ROW
BEGIN
    INSERT INTO employee_demographics(employee_id,first_name,last_name)
    VALUES(NEW.employee_id,NEW.first_name,NEW.last_name);
END $$
DELIMITER ;

INSERT INTO employee_salary(employee_id,first_name,last_name,occupation,salary,dept_id)
VALUES(13,'Mainuddin','Shaik','Data Science',65000,2),
(14,'Saniya','Shaik','Commerce',50000,2);

SELECT *
FROM employee_salary;

SELECT *
FROM employee_demographics;

-- EVENT :

DELIMITER $$
CREATE EVENT delete_retirees
ON SCHEDULE EVERY 30 SECOND
DO
BEGIN
	DELETE
    FROM employee_demographics
    WHERE age >= 60;
END $$
DELIMITER ;

SELECT *
FROM employee_demographics;