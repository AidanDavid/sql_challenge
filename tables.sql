DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 
        FROM pg_namespace 
        WHERE nspname = 'mydb'
    ) THEN
        EXECUTE 'CREATE SCHEMA mydb';
    END IF;
END $$;

SET search_path TO mydb;

-- Remove if they exist already:
DROP TABLE IF EXISTS department_employees CASCADE;
DROP TABLE IF EXISTS department_managers CASCADE;
DROP TABLE IF EXISTS salaries CASCADE;
DROP TABLE IF EXISTS employees CASCADE;
DROP TABLE IF EXISTS titles CASCADE;
DROP TABLE IF EXISTS departments CASCADE;

-- Making tables:
CREATE TABLE departments (
    dept_no VARCHAR(10) NOT NULL PRIMARY KEY,
    dept_name VARCHAR(100) NOT NULL
);

CREATE TABLE titles (
    title_id VARCHAR(10) NOT NULL PRIMARY KEY,
    title_name VARCHAR(100) NOT NULL
);

CREATE TABLE employees (
    emp_no INT PRIMARY KEY,
    emp_title_id VARCHAR(10) NOT NULL REFERENCES titles(title_id),
    birth_date VARCHAR(10) NOT NULL,
    first_name VARCHAR(25) NOT NULL,
    last_name VARCHAR(25) NOT NULL,
    sex VARCHAR(1) NOT NULL,
    hire_date VARCHAR(10)
);

CREATE TABLE department_employees (
    emp_no INT REFERENCES employees(emp_no),
    dept_no VARCHAR(10) NOT NULL REFERENCES departments(dept_no),
    PRIMARY KEY (emp_no, dept_no)
);

CREATE TABLE department_managers (
    dept_no VARCHAR(10) NOT NULL REFERENCES departments(dept_no),
    emp_no INT REFERENCES employees(emp_no),
    PRIMARY KEY (dept_no, emp_no)
);

CREATE TABLE salaries (
    emp_no INT REFERENCES employees(emp_no),
    salary MONEY,
    PRIMARY KEY (emp_no)
);