-- creating employees table
CREATE TABLE employees (
	emp_no INT PRIMARY KEY,
	birth_date date,
	first_name VARCHAR,
	last_name VARCHAR,
	gender VARCHAR, 
	hire_date date
);

SELECT emp_no, first_name, last_name FROM employees;

-- creating titles table
CREATE TABLE titles (
	emp_no INT,
	title VARCHAR,
	from_date date,
	to_date date
);


SELECT title, from_date, to_date from titles;

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

SELECT * FROM retirement_titles;

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) emp_no,
first_name,
last_name,
title
INTO rt_uniq
FROM retirement_titles as rt 
ORDER BY emp_no ASC, to_date DESC;

SELECT * FROM rt_uniq;

-- retrieve number of employees to retire by their most recent job title
SELECT COUNT(title), title 
INTO retiring_titles
FROM rt_uniq
GROUP BY title 
ORDER BY COUNT(title) DESC;


SELECT * FROM retiring_titles;

-- create Mentorship Eligibility table

SELECT DISTINCT ON (employees.emp_no)employees.emp_no,
       employees.first_name,
	   employees.last_name,
	   employees.birth_date,
	   employees_info.from_date,
	   employees_info.to_date,
	   titles.title
INTO mentorship_eligibility
FROM employees
INNER JOIN employees_info ON employees.emp_no = employees_info.emp_no
INNER JOIN titles ON employees.emp_no = employees_info.emp_no
WHERE (employees.birth_date BETWEEN '1965/1/1' AND '12/31/1965')
AND (employees_info.to_date = '9999/01/01')
ORDER BY emp_no;

SELECT * FROM mentorship_eligibility
