create database office;
use office;
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    department VARCHAR(50),
    salary DECIMAL(10, 2),
    hire_date DATE
);
INSERT INTO employees (employee_id, first_name, last_name, department, salary, hire_date) VALUES
(1, 'John', 'Doe', 'Engineering', 75000.00, '2021-01-15'),
(2, 'Jane', 'Smith', 'Marketing', 65000.00, '2020-03-20'),
(3, 'Jim', 'Brown', 'Sales', 55000.00, '2019-07-11'),
(4, 'Jake', 'Wilson', 'HR', 60000.00, '2018-12-01'),
(5, 'Jill', 'Johnson', 'Engineering', 80000.00, '2021-09-23');

select * from employees;

-- Write an SQL query to retrieve the first name, last name, and department of employees who work in the 'Engineering' department.
SELECT 
    first_name, last_name, department
FROM
    employees
WHERE
    department = 'Engineering';

-- Write an SQL query to find the total salary paid to employees in the 'Marketing' department.
select sum(salary) as total_salary from employees where department = "Marketing";

-- Write an SQL query to find the employee with the highest salary. Retrieve the employee's first name, last name, and salary.
select first_name, last_name, salary from employees order by salary desc limit 1;

-- Write an SQL query to count the number of employees in each department.
select department,count(*) from employees group by department;

-- Write an SQL query to increase the salary of the employee with employee_id 3 to 60000.
update employees set salary = 60000 where employee_id = 3;

-- Write an SQL query to delete the employee with employee_id 4 from the employees table.
Delete from employees where employee_id = 4;

-- Write an SQL query to retrieve the average salary of employees in each department.
select Department, round(Avg(salary),1)
 as avg_salary from employees group by department;
 
 -- Write an SQL query to find the names of employees who were hired in the year 2021.
 select first_name, Last_name from employees where year(hire_date) = 2021;
 
 -- Write an SQL query to find the second-highest salary from the employees table.
 select first_name, Last_name ,salary from employees order by salary  desc limit 1 offset 1;
 
 -- Write an SQL query to calculate the difference between the highest and lowest salaries in the employees table.
SELECT MAX(salary) - MIN(salary) AS difference
FROM employees;

-- Write an SQL query to find the average salary of employees who were hired after January 1, 2020.
select  round(avg(salary),2) as avg_salary from employees where hire_date > '2020-1-1';

-- Write an SQL query to find the employees who have the same salary as the highest salary in the employees table. Include their first name, last name, and salary in the result.
select first_name, last_name, salary from employees where salary = (select salary from employees order by salary desc limit 1); 

-- Write an SQL query to find the department(s) with the highest average salary among employees. Include the department name and the average salary in the result.
select department, avg(salary) as avg_salary from employees group by department order by avg_salary desc limit 1;
 
 
-- Write an SQL query to find the employee(s) who have been with the company for the longest time. Retrieve their first name, last name, and hire date.
select hire_date, first_name, Last_name from employees order by hire_date  limit 1;

-- Write an SQL query to find the employee(s) who were hired on the same date as the employee with the lowest employee ID. Retrieve their first name, last name, and hire date.

select first_name, Last_name, hire_date from employees where hire_date = (select hire_date from employees order by employee_id limit 1);

-- Write an SQL query to find the  department(s) where the number of employees is more than the average 
-- number of employees across all departments. Retrieve the department name and the count of employees 
-- in each department.

with department_count as ( select department, count(*) as num_employee from employees group by department)
select department, num_employee from department_count where num_employee > (select avg(num_employee)from department_count);

-- Write an SQL query to find the employee(s) who have the highest salary in each department. Retrieve their first name, last name, department, and salary.
select first_name, last_name, department
from (select *, rank() over(partition by department order by salary desc) as salary_rank 
from employees ) as ranked_salary where salary_rank = 1;

-- Write an SQL query to find the department(s) where the total salary exceeds 200,000.
-- Retrieve the department name and the total salary for each department.

select department, sum(salary) as total_salary from employees group by department having total_salary > 200000;

-- Write an SQL query to find the employee(s) who have the highest salary in their respective departments 
-- not in the 'Engineering' department. Retrieve their first name, last name, department, and salary.
with ranked_salary as (select * , 
dense_rank() over(partition by department order by salary desc) as salary_rank 
from employees  where department != 'Engineering')
select first_name, last_name, salary, department from ranked_salary 
where salary_rank = 1;
