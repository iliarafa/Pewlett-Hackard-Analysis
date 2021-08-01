
-- creating table of current salaries for retiring employees

SELECT  rt_u.emp_no,
    	rt_u.first_name, 
  		rt_u.last_name,
   		rt_u.title, 
		salaries.salary
INTO retiring_salaries
FROM rt_uniq as rt_u
JOIN salaries ON rt_u.emp_no = salaries.emp_no
JOIN retirement_titles ON rt_u.emp_no = retirement_titles.emp_no
WHERE retirement_titles.to_date = '9999/01/01'
ORDER BY emp_no;


SELECT * FROM retiring_salaries
WHERE salary > 70000 AND title = 'Senior Staff'
ORDER BY salary

SELECT * FROM retiring_salaries
WHERE salary > 70000 AND title = 'Senior Engineer'
ORDER BY salary

SELECT * FROM retiring_salaries
WHERE salary > 70000 AND title = 'Staff'
ORDER BY salary

SELECT * FROM retiring_salaries
WHERE salary > 70000 AND title = 'Engineer'
ORDER BY salary

-- average salary per title 
SELECT title, cast(AVG(salary) as money) FROM retiring_salaries
GROUP BY title







