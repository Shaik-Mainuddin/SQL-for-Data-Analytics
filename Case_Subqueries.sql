USE parks_and_recreation;

-- CASE STATEMENTS : CASE,WHEN,THEN,END

SELECT first_name,age,gender,
CASE
	WHEN age < 35 THEN 'Young'
    WHEN age BETWEEN 35 AND 45 THEN 'Senior'
    ELSE 'Near to DEATH'
END AS age_status
FROM employee_demographics
;

-- SUBQUERIES:

SELECT first_name,last_name
FROM employee_demographics
WHERE employee_id IN(
					SELECT dept_id
                    FROM employee_salary
                    WHERE dept_id = employee_id)
;