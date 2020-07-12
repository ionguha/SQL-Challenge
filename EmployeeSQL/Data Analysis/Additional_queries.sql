-- ###### Additional Data Analysis Section ##############
-- With this interesting database, I decided to investigate further
-- ___________________________________________________________________
-- 9. How long have the managers worked in their current role ?
-- -------------------------------------------------------------------
-- Create the query ---
WITH emp_age_subq AS 
			(SELECT emp_no AS "Employee Number", 
  		 			last_name AS "Last Name",
		 			first_name AS "First Name",
		 			gender AS "Gender",
		 			EXTRACT(YEAR FROM age(hire_date)) AS "Employment Years"
			FROM employees),
	manager_age_subq AS
				(SELECT	emp_no AS "Manager Number",
  				least(DATE_PART('year', to_date::date),DATE_PART('year', '2020-01-01'::date)) - 
 				DATE_PART('year', from_date::date) AS "Managerial Years"
				FROM dept_manager)
SELECT "Last Name", "First Name","Employment Years","Managerial Years"
FROM emp_age_subq
INNER JOIN manager_age_subq ON "Employee Number" = "Manager Number";
--Observations : Hilary Kambil was manager for 29 years out of 32 years in the company

-- __________________________________________________________________________________
-- 10. How many employees per title and on average how long do they work per title ?
-- ----------------------------------------------------------------------------------
SELECT 	title AS "Department Title", 
		count(*) AS "Number of employees",
		ROUND(AVG((least(DATE_PART('year', to_date::date),DATE_PART('year', '2020-01-01'::date)) - 
 		DATE_PART('year', from_date::date)))) AS "Avg. employment years"
FROM titles
GROUP BY "Department Title"
ORDER BY "Avg. employment years" DESC;

-- __________________________________________________________________________________________
-- 11. What is the average salary per title ?
-- -------------------------------------------------------------------------------------------
SELECT 	t.title AS "Department Title", 
	    count(t.emp_no) AS "No. of employees",
		ROUND(AVG(s.salary),2) AS "Average Salary" 
FROM titles AS t
  INNER JOIN salaries AS s
  		ON t.emp_no = s.emp_no
GROUP BY "Department Title"
ORDER BY "Average Salary" DESC;

-- ____________________________________________________________________________
-- 12. Do male managers get more salary on average than female managers ?
-- -----------------------------------------------------------------------------
-- Create the query ---
WITH salary_age_subq AS 
			(SELECT emp_no AS "Employee Salary ID", 
  		 			salary AS "Salary"
			 FROM salaries),
	manager_age_subq AS
				(SELECT	emp_no AS "Manager ID",
  						least(DATE_PART('year', to_date::date),DATE_PART('year', '2020-01-01'::date)) - 
 						DATE_PART('year', from_date::date) AS "Managerial Years"
				FROM dept_manager),
	emp_gender_subq AS
				(SELECT emp_no AS "Employee ID",
						gender AS "Gender"
				 FROM employees)
SELECT 	"Gender", 
		ROUND(AVG("Salary"),2) AS "Average Salary",
		ROUND(AVG("Managerial Years")) AS "Avg. Managerial Years"
FROM emp_gender_subq
	INNER JOIN manager_age_subq ON "Employee ID" = "Manager ID"
		INNER JOIN salary_age_subq ON "Employee ID" = "Employee Salary ID"
GROUP BY emp_gender_subq."Gender";
--Observations : Average manager's salary is lower for female employees than their male counterparts

-- __________________________________________________________________________________________
-- 13. Do male employees get more salary per year on average than their female counterparts ?
-- -------------------------------------------------------------------------------------------
--**** Creating a view table of salary for employees *****
-- Dropping the view table if exists ---
DROP VIEW IF EXISTS salary_emp;
-- Create the query ---
CREATE VIEW salary_emp AS
	WITH salary_subq AS 
			(SELECT emp_no AS "Employee Salary ID", 
  		 			salary AS "Salary"
			 FROM salaries),
		emp_subq AS 
			(SELECT emp_no AS "Employee ID", 
  		 			last_name AS "Last Name",
		 			first_name AS "First Name",
		 			gender AS "Gender",
		 			EXTRACT(YEAR FROM age(hire_date)) AS "Employment Years"
			FROM employees)
	SELECT "Employee ID","Last Name", "First Name","Gender","Employment Years","Salary"
	FROM emp_subq
	INNER JOIN salary_subq ON "Employee ID" = "Employee Salary ID";
-- Total number of employees grouped by gender --
SELECT "Gender", 
		count(*) AS "No of Employees" 
FROM salary_emp
GROUP BY "Gender";
-- Maximum salary of employees grouped by gender ---
SELECT "Gender",
       MAX("Salary") AS "Maximum Salary" 
FROM salary_emp
GROUP BY "Gender";
-- Minimum salary of employees grouped by gender ---
SELECT "Gender",
       MIN("Salary") AS "Minimum Salary" 
FROM salary_emp
GROUP BY "Gender";
-- Average salary of employees grouped by gender ---
SELECT "Gender",
       ROUND(AVG("Salary"),2) AS "Average Salary" 
FROM salary_emp
GROUP BY "Gender";
--Observations : Maximum salary belongs to male gender
-- Minimum and Average salary is same for both genders

-- __________________________________________________________________________________________
-- 14. Oldest hire ?
-- -------------------------------------------------------------------------------------------
--**** Creating a view table with age of all employees *****
-- Dropping the view table if exists ---
DROP VIEW IF EXISTS age_emp;
-- Create the query ---
CREATE VIEW age_emp AS
	WITH emp_subq AS 
			(SELECT emp_no AS "Employee ID", 
  		 			gender AS "Gender",
			 		last_name AS "Last Name",
		 			first_name AS "First Name",
			 		EXTRACT(YEAR FROM age(birth_date)) AS "Age",
		 			EXTRACT(YEAR FROM age(hire_date)) AS "Employment Years"
			FROM employees),
	 dept_subq AS
			(SELECT de.emp_no AS "Employee Dept ID",
			 		de.dept_no AS "Dept ID",
			 		d.dept_name AS "Department Name",
			 		d.dept_no AS "Department ID"
			  FROM dept_emp AS de
			 	INNER JOIN departments AS d
			 		ON de.dept_no = d.dept_no),
	 salary_subq AS 
			(SELECT emp_no AS "Employee Salary ID", 
  		 			salary AS "Salary"
			 FROM salaries)				
	SELECT "Last Name","First Name","Gender","Age","Employment Years","Department Name","Salary"
	FROM emp_subq
		INNER JOIN dept_subq ON "Employee ID" = "Employee Dept ID"
			INNER JOIN salary_subq ON "Employee ID" = "Employee Salary ID"; 
-- Create a query from age_emp table to find the oldest employee --
SELECT * FROM age_emp ORDER BY "Age" DESC,"Last Name" ASC, "First Name" ASC LIMIT 10;
-- Create a query from age_emp table to find the oldest hire --
SELECT * FROM age_emp ORDER BY "Employment Years" DESC,"Last Name" ASC, "First Name" ASC LIMIT 10;