

-- creating retirement_titles table
SELECT employees.emp_no , 
	   employees.first_name, 
	   employees.last_name,
	   titles.title, 
	   titles.from_date, 
	   titles.to_date
INTO retirement_titles   
FROM employees 
INNER JOIN titles ON employees.emp_no = titles.emp_no
WHERE (employees.birth_date BETWEEN '1952/1/1' AND '12/31/1955')
ORDER BY emp_no; 


-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) emp_no,
first_name,
last_name,
title
INTO rt_uniq
FROM retirement_titles 
ORDER BY emp_no ASC, to_date DESC;



-- retrieve number of employees to retire by their most recent job title
SELECT COUNT(title), title 
INTO retiring_titles
FROM rt_uniq
GROUP BY title 
ORDER BY COUNT(title) DESC;


-- create Mentorship Eligibility table

SELECT DISTINCT ON (employees.emp_no)employees.emp_no,
       employees.first_name,
	   employees.last_name,
	   employees.birth_date,
	   employees_info.from_date,
	   employees_info.to_date,
	   titles.title
INTO mentorship_eli
FROM employees
INNER JOIN employees_info ON employees.emp_no = employees_info.emp_no
INNER JOIN titles ON employees.emp_no = titles.emp_no
WHERE (employees.birth_date BETWEEN '1965/1/1' AND '12/31/1965')
AND (employees_info.to_date = '9999/01/01')
ORDER BY emp_no;


SELECT title, COUNT(*) FROM mentorship_eli
GROUP BY title
