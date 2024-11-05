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

-- Remove if they exist already:
DROP TABLE IF EXISTS department_employees CASCADE;
DROP TABLE IF EXISTS department_managers CASCADE;
DROP TABLE IF EXISTS salaries CASCADE;
DROP TABLE IF EXISTS employees CASCADE;
DROP TABLE IF EXISTS titles CASCADE;
DROP TABLE IF EXISTS departments CASCADE;

-- Making tables:
CREATE TABLE departments (
    dept_no INT PRIMARY KEY,
    dept_name VARCHAR(100) NOT NULL
);

CREATE TABLE titles (
    title_id INT PRIMARY KEY,
    title_name VARCHAR(100) NOT NULL
);

CREATE TABLE employees (
    emp_no INT PRIMARY KEY,
    emp_title_id INT REFERENCES titles(title_id),
    birth_date DATE,
    first_name VARCHAR(25) NOT NULL,
    last_name VARCHAR(25) NOT NULL,
    sex VARCHAR(1) NOT NULL,
    hire_date DATE
);

CREATE TABLE department_employees (
    emp_no INT REFERENCES employees(emp_no),
    dept_no INT REFERENCES departments(dept_no),
    PRIMARY KEY (emp_no, dept_no)
);

CREATE TABLE department_managers (
    dept_no INT REFERENCES departments(dept_no),
    emp_no INT REFERENCES employees(emp_no),
    PRIMARY KEY (dept_no, emp_no)
);

CREATE TABLE salaries (
    emp_no INT REFERENCES employees(emp_no),
    salary MONEY,
    PRIMARY KEY (emp_no)
);


-- Importing data:
/*
COPY departments (dept_no, dept_name)
FROM '/data/departments.csv'
DELIMITER ','
CSV HEADER;

COPY titles (title_id, title_name)
FROM '/data/titles.csv'
DELIMITER ','
CSV HEADER;

COPY employees (emp_no, emp_title_id, birth_date, first_name, last_name, sex, hire_date)
FROM '/data/employees.csv'
DELIMITER ','
CSV HEADER;

COPY department_employees (emp_no, dept_no)
FROM '/data/dept_emp.csv'
DELIMITER ','
CSV HEADER;

COPY department_managers (dept_no, emp_no)
FROM '/data/dept_managers.csv'
DELIMITER ','
CSV HEADER;

COPY salaries (emp_no, salary)
FROM '/data/salries.csv'
DELIMITER ','
CSV HEADER;
*/