-- =====================================================
-- Complete Database Setup Script
-- Employee Management Database - SQL Internship Task
-- =====================================================

-- This script will set up the complete database with all tables and sample data

-- Drop and create database
DROP DATABASE IF EXISTS employee_management;
CREATE DATABASE employee_management;
USE employee_management;

-- Run the main schema file
SOURCE database_schema.sql;

-- Run the sample data files
SOURCE sample_data.sql;
SOURCE sample_data_part2.sql;

-- Display completion message
SELECT 'Database setup completed successfully!' AS status;

-- Show summary
SELECT 'departments' as table_name, COUNT(*) as record_count FROM departments
UNION ALL
SELECT 'positions', COUNT(*) FROM positions
UNION ALL
SELECT 'employees', COUNT(*) FROM employees
UNION ALL
SELECT 'employee_salaries', COUNT(*) FROM employee_salaries
UNION ALL
SELECT 'projects', COUNT(*) FROM projects
UNION ALL
SELECT 'employee_projects', COUNT(*) FROM employee_projects
UNION ALL
SELECT 'attendance', COUNT(*) FROM attendance
UNION ALL
SELECT 'performance_reviews', COUNT(*) FROM performance_reviews;

-- Show sample data
SELECT 
    e.employee_code,
    CONCAT(e.first_name, ' ', e.last_name) as employee_name,
    d.department_name,
    p.position_title,
    e.salary
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN positions p ON e.position_id = p.position_id
ORDER BY e.employee_id
LIMIT 5;
