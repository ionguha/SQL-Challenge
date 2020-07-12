-- ###### Data Analysis Section ##############
-- __________________________________________________________________
-- 1. List the following details of each employee: employee number, 
--    last name, first name, gender, and salary.
-- ------------------------------------------------------------------
-- View information from employees table
SELECT * FROM employees LIMIT 10;
-- View information from salaries table
SELECT * FROM salaries LIMIT 10;
-- Create the query
SELECT e.emp_no AS "Employee Number",
	   e.last_name AS "Last Name",
       e.first_name AS "First Name",
	   e.gender AS "Gender", 
	   s.salary AS "Salary"
FROM employees AS e
INNER JOIN salaries AS s
ON e.emp_no = s.emp_no;
--________________________________________________________
-- 2. List employees who were hired in 1986.
-- -------------------------------------------------------
SELECT e.emp_no AS "Employee Number",
	   e.last_name AS "Last Name",
	   e.first_name AS "First Name"
FROM employees AS e
WHERE EXTRACT(YEAR FROM hire_date) = 1986;

--__________________________________________________________________________
-- 3. List the manager of each department with the following information: 
--    department number, department name, the manager's employee number, 
--    last name, first name, and start and end employment dates.
-- --------------------------------------------------------------------------
-- View information from dept_manager table
SELECT * FROM dept_manager LIMIT 10;
-- View information from departments table
SELECT * FROM departments LIMIT 10;
-- View information from employees table
SELECT * FROM employees LIMIT 10;
-- Create the query
SELECT m.dept_no AS "Department Number", 
	   d.dept_name AS "Department Name",
	   m.emp_no AS " Manager employee number",
	   e.last_name AS "Last Name",
	   e.first_name AS "First Name",
	   m.from_date AS "Start Date", 
	   m.to_date AS "End Date"
FROM employees AS e
	INNER JOIN dept_manager AS m
	ON e.emp_no = m.emp_no
		INNER JOIN departments AS d
		ON m.dept_no = d.dept_no;

--___________________________________________________________________________
-- 4. List the department of each employee with the following information: 
--    employee number, last name, first name, and department name.
-- --------------------------------------------------------------------------
-- Create the query ---
SELECT e.emp_no AS "Employee Number", 
	   e.last_name AS "Last Name",
	   e.first_name AS "First Name",
	   d.dept_name AS "Department Name"
FROM employees AS e
	INNER JOIN dept_emp AS de
	ON e.emp_no = de.emp_no
		INNER JOIN departments AS d
		ON de.dept_no = d.dept_no;
		
--____________________________________________________________	
-- 5. List all employees whose first name is "Hercules" and 
--    last names begin with "B."
-- -----------------------------------------------------------
-- Create the query ---
SELECT e.emp_no AS "Employee Number", 
	   e.last_name AS "Last Name",
	   e.first_name AS "First Name"
FROM employees AS e
WHERE first_name = 'Hercules' AND last_name like 'B%';

--__________________________________________________________________________________
-- 6. List all employees in the Sales department, including their employee number, 
--    last name, first name, and department name.
-- ---------------------------------------------------------------------------------
-- Create the query ---
SELECT e.emp_no AS "Employee Number", 
	   e.last_name AS "Last Name",
	   e.first_name AS "First Name",
	   d.dept_name AS "Department Name"
FROM employees AS e
	INNER JOIN dept_emp AS de
	ON e.emp_no = de.emp_no
		INNER JOIN departments AS d
		ON de.dept_no = d.dept_no
WHERE dept_name = 'Sales';

--_________________________________________________________________________________
-- 7. List all employees in the Sales and Development departments, including their 
--    employee number, last name, first name, and department name.
-- ---------------------------------------------------------------------------------
-- Create the query ---
SELECT e.emp_no AS "Employee Number", 
	   e.last_name AS "Last Name",
	   e.first_name AS "First Name",
	   d.dept_name AS "Department Name"
FROM employees AS e
	INNER JOIN dept_emp AS de
	ON e.emp_no = de.emp_no
		INNER JOIN departments AS d
		ON de.dept_no = d.dept_no
WHERE dept_name = 'Sales' OR dept_name = 'Development';

--__________________________________________________________________________
-- 8. In descending order, list the frequency count of employee last names, 
-- i.e., how many employees share each last name.
-- -------------------------------------------------------------------------
-- Create the query ---
SELECT e.last_name AS "Last Name",
	   count(*) AS "Frequency Count"
FROM employees AS e
GROUP BY "Last Name"
ORDER BY "Frequency Count" DESC;

--Observation:  Only one employee with last name: Foolsday !!-------