-- SQL Homework - Employee Database: A Mystery in Two Parts
-- Background
-- It is a beautiful spring day, and it is two weeks since I have been hired as a new data engineer at Pewlett Hackard. 
-- My first major task is a research project on employees of the corporation from the 1980s and 1990s. 
-- All that remain of the database of employees from that period are six CSV files.

-- In this assignment, I shall design the tables to hold data in the CSVs, import the CSVs into a SQL database, 
-- and answer questions about the data. In other words, I shall perform:
-- 1. Data Modeling 2. Data Engineering and 3. Data Analysis

-- 1. *****  Data Modeling was completed and ERD of the tables is sketched out ************

-- 2. ******* Data Engineering *************************************************************
-- Using the information from the ERD table here is a table schema for each of the six CSV files. 
--**** Creating schema for employees table *********
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (
	emp_no INTEGER PRIMARY KEY,
	birth_date DATE NOT NULL,
    first_name VARCHAR(64) NOT NULL,
	last_name VARCHAR(64) NOT NULL,
    gender VARCHAR(4) NOT NULL,
	hire_date DATE NOT NULL
);
--#### Viewing the schema for employees table ######
SELECT * FROM employees;

--**** Creating schema for departments table *********
DROP TABLE IF EXISTS departments;
CREATE TABLE departments (
	dept_no VARCHAR(16) PRIMARY KEY NOT NULL,
	dept_name VARCHAR(256) NOT NULL
);
--#### Viewing the schema for departments table ######
SELECT * FROM departments;

--**** Creating schema for titles table *********
DROP TABLE IF EXISTS titles;
CREATE TABLE titles (
	emp_no INTEGER NOT NULL,
	title VARCHAR(256) NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);
--#### Viewing the schema for titles table ######
SELECT * FROM titles;

--**** Creating schema for salaries table *********
DROP TABLE IF EXISTS salaries;
CREATE TABLE salaries (
	emp_no INTEGER NOT NULL,
	salary BIGINT NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);
--#### Viewing the schema for salaries table ######
SELECT * FROM salaries;

--**** Creating schema for dept_emp table *********
DROP TABLE IF EXISTS dept_emp;
CREATE TABLE dept_emp (
	emp_no INTEGER NOT NULL,
	dept_no VARCHAR(16) NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no)
);
--#### Viewing the schema for dept_emp table ######
SELECT * FROM dept_emp;

--**** Creating schema for dept_manager table *********
DROP TABLE IF EXISTS dept_manager;
CREATE TABLE dept_manager (
	dept_no VARCHAR(16) NOT NULL,
	emp_no INTEGER NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no)
);
--#### Viewing the schema for dept_manager table ######
SELECT * FROM dept_manager;

--*** Exporting data from the csv files for each table *******---------

-- %%%%% Importing employees.csv file into the employees table %%%%%%%%%
SELECT * FROM employees LIMIT 50;
-- %%%%% Importing departments.csv file into the departments table %%%%%%%%%
SELECT * FROM departments LIMIT 10;
-- %%%%% Importing dept_emp.csv file into the dept_emp table %%%%%%%%%
SELECT * FROM dept_emp LIMIT 50;
-- %%%%% Importing dept_manager.csv file into the dept_manager table %%%%%%%%%
SELECT * FROM dept_manager LIMIT 30;
-- %%%%% Importing salaries.csv file into the salaries table %%%%%%%%%
SELECT * FROM salaries LIMIT 50;
-- %%%%% Importing titles.csv file into the titles table %%%%%%%%%
SELECT * FROM titles LIMIT 50;