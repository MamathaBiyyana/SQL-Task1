-- =====================================================
-- Sample Data Part 2 - Manager References and Related Data
-- =====================================================

USE employee_management;

-- =====================================================
-- 4. UPDATE MANAGER REFERENCES
-- =====================================================
-- Update department managers
UPDATE departments SET manager_id = 1 WHERE department_id = 1; -- IT Manager
UPDATE departments SET manager_id = 6 WHERE department_id = 2; -- HR Manager
UPDATE departments SET manager_id = 9 WHERE department_id = 3; -- Finance Manager
UPDATE departments SET manager_id = 12 WHERE department_id = 4; -- Marketing Manager
UPDATE departments SET manager_id = 15 WHERE department_id = 5; -- Sales Manager
UPDATE departments SET manager_id = 18 WHERE department_id = 6; -- Operations Manager
UPDATE departments SET manager_id = 20 WHERE department_id = 7; -- Research Manager
UPDATE departments SET manager_id = 23 WHERE department_id = 8; -- Support Manager

-- Update employee managers (hierarchical structure)
UPDATE employees SET manager_id = 1 WHERE employee_id IN (2, 3, 4, 5); -- IT employees report to IT Manager
UPDATE employees SET manager_id = 6 WHERE employee_id IN (7, 8); -- HR employees report to HR Manager
UPDATE employees SET manager_id = 9 WHERE employee_id IN (10, 11); -- Finance employees report to Finance Manager
UPDATE employees SET manager_id = 12 WHERE employee_id IN (13, 14); -- Marketing employees report to Marketing Manager
UPDATE employees SET manager_id = 15 WHERE employee_id IN (16, 17); -- Sales employees report to Sales Manager
UPDATE employees SET manager_id = 18 WHERE employee_id = 19; -- Operations employee reports to Operations Manager
UPDATE employees SET manager_id = 20 WHERE employee_id IN (21, 22); -- R&D employees report to Research Manager
UPDATE employees SET manager_id = 23 WHERE employee_id = 24; -- Support employee reports to Support Manager

-- =====================================================
-- 5. INSERT EMPLOYEE SALARIES
-- =====================================================
INSERT INTO employee_salaries (employee_id, salary_amount, effective_date, salary_type, reason, approved_by) VALUES
-- Initial salaries
(1, 95000.00, '2020-01-15', 'Base', 'Initial hire', NULL),
(2, 85000.00, '2020-03-20', 'Base', 'Initial hire', 1),
(3, 70000.00, '2020-06-10', 'Base', 'Initial hire', 1),
(4, 80000.00, '2021-01-05', 'Base', 'Initial hire', 1),
(5, 75000.00, '2021-02-15', 'Base', 'Initial hire', 1),
(6, 80000.00, '2020-02-01', 'Base', 'Initial hire', NULL),
(7, 60000.00, '2020-04-12', 'Base', 'Initial hire', 6),
(8, 55000.00, '2021-03-08', 'Base', 'Initial hire', 6),
(9, 90000.00, '2020-01-10', 'Base', 'Initial hire', NULL),
(10, 65000.00, '2020-05-22', 'Base', 'Initial hire', 9),
(11, 55000.00, '2021-01-18', 'Base', 'Initial hire', 9),
(12, 85000.00, '2020-03-15', 'Base', 'Initial hire', NULL),
(13, 60000.00, '2020-07-08', 'Base', 'Initial hire', 12),
(14, 65000.00, '2021-02-12', 'Base', 'Initial hire', 12),
(15, 80000.00, '2020-04-05', 'Base', 'Initial hire', NULL),
(16, 50000.00, '2020-06-20', 'Base', 'Initial hire', 15),
(17, 65000.00, '2020-08-14', 'Base', 'Initial hire', 15),
(18, 70000.00, '2020-05-10', 'Base', 'Initial hire', NULL),
(19, 55000.00, '2021-01-25', 'Base', 'Initial hire', 18),
(20, 110000.00, '2020-02-28', 'Base', 'Initial hire', NULL),
(21, 85000.00, '2020-04-18', 'Base', 'Initial hire', 20),
(22, 90000.00, '2020-07-30', 'Base', 'Initial hire', 20),
(23, 65000.00, '2020-08-22', 'Base', 'Initial hire', NULL),
(24, 50000.00, '2020-09-05', 'Base', 'Initial hire', 23),

-- Salary increments
(2, 90000.00, '2021-06-20', 'Increment', 'Annual performance review', 1),
(3, 75000.00, '2021-06-10', 'Increment', 'Annual performance review', 1),
(7, 65000.00, '2021-04-12', 'Increment', 'Annual performance review', 6),
(10, 70000.00, '2021-05-22', 'Increment', 'Annual performance review', 9),
(13, 65000.00, '2021-07-08', 'Increment', 'Annual performance review', 12),
(16, 55000.00, '2021-06-20', 'Increment', 'Annual performance review', 15),
(21, 90000.00, '2021-04-18', 'Increment', 'Annual performance review', 20),
(24, 55000.00, '2021-09-05', 'Increment', 'Annual performance review', 23),

-- Bonuses
(1, 5000.00, '2021-12-15', 'Bonus', 'Year-end bonus', NULL),
(6, 4000.00, '2021-12-15', 'Bonus', 'Year-end bonus', NULL),
(9, 5000.00, '2021-12-15', 'Bonus', 'Year-end bonus', NULL),
(12, 4000.00, '2021-12-15', 'Bonus', 'Year-end bonus', NULL),
(15, 4000.00, '2021-12-15', 'Bonus', 'Year-end bonus', NULL),
(18, 3500.00, '2021-12-15', 'Bonus', 'Year-end bonus', NULL),
(20, 6000.00, '2021-12-15', 'Bonus', 'Year-end bonus', NULL),
(23, 3500.00, '2021-12-15', 'Bonus', 'Year-end bonus', NULL);

-- =====================================================
-- 6. INSERT PROJECTS
-- =====================================================
INSERT INTO projects (project_name, project_code, description, department_id, project_manager_id, start_date, end_date, budget, status, priority) VALUES
('E-commerce Platform Development', 'PROJ-ECOM-001', 'Develop a new e-commerce platform for online sales', 1, 1, '2021-01-15', '2021-12-31', 500000.00, 'Active', 'High'),
('Customer Relationship Management System', 'PROJ-CRM-001', 'Implement CRM system for sales team', 1, 2, '2021-03-01', '2021-11-30', 300000.00, 'Active', 'Medium'),
('Data Analytics Dashboard', 'PROJ-DASH-001', 'Create analytics dashboard for business intelligence', 7, 22, '2021-02-15', '2021-10-31', 250000.00, 'Active', 'High'),
('Marketing Campaign Automation', 'PROJ-MKT-001', 'Automate marketing campaigns and lead generation', 4, 12, '2021-04-01', '2021-09-30', 150000.00, 'Active', 'Medium'),
('Employee Training Portal', 'PROJ-TRAIN-001', 'Develop online training portal for employees', 2, 6, '2021-05-01', '2021-08-31', 100000.00, 'Planning', 'Low'),
('Financial Reporting System', 'PROJ-FIN-001', 'Enhance financial reporting and analysis tools', 3, 9, '2021-06-01', '2021-12-31', 200000.00, 'Active', 'Medium'),
('Mobile App Development', 'PROJ-MOBILE-001', 'Develop mobile application for customer engagement', 1, 3, '2021-07-01', '2022-03-31', 400000.00, 'Planning', 'High'),
('AI-Powered Chatbot', 'PROJ-AI-001', 'Implement AI chatbot for customer support', 8, 23, '2021-08-01', '2022-01-31', 180000.00, 'Planning', 'Medium');

-- =====================================================
-- 7. INSERT EMPLOYEE PROJECTS
-- =====================================================
INSERT INTO employee_projects (employee_id, project_id, role, start_date, end_date, hours_allocated) VALUES
-- E-commerce Platform Project
(1, 1, 'Project Manager', '2021-01-15', '2021-12-31', 40),
(2, 1, 'Lead Developer', '2021-01-15', '2021-12-31', 35),
(3, 1, 'Backend Developer', '2021-01-15', '2021-12-31', 30),
(4, 1, 'Database Developer', '2021-01-15', '2021-12-31', 25),
(5, 1, 'System Administrator', '2021-01-15', '2021-12-31', 20),

-- CRM System Project
(2, 2, 'Project Manager', '2021-03-01', '2021-11-30', 40),
(3, 2, 'Full Stack Developer', '2021-03-01', '2021-11-30', 35),
(4, 2, 'Database Administrator', '2021-03-01', '2021-11-30', 25),
(16, 2, 'Business Analyst', '2021-03-01', '2021-11-30', 20),
(17, 2, 'User Acceptance Tester', '2021-03-01', '2021-11-30', 15),

-- Data Analytics Dashboard Project
(22, 3, 'Project Manager', '2021-02-15', '2021-10-31', 40),
(21, 3, 'Data Scientist', '2021-02-15', '2021-10-31', 35),
(2, 3, 'Frontend Developer', '2021-02-15', '2021-10-31', 25),
(4, 3, 'Data Engineer', '2021-02-15', '2021-10-31', 30),
(10, 3, 'Business Analyst', '2021-02-15', '2021-10-31', 20),

-- Marketing Campaign Automation Project
(12, 4, 'Project Manager', '2021-04-01', '2021-09-30', 40),
(13, 4, 'Marketing Specialist', '2021-04-01', '2021-09-30', 35),
(14, 4, 'Digital Marketing Specialist', '2021-04-01', '2021-09-30', 30),
(3, 4, 'Integration Developer', '2021-04-01', '2021-09-30', 25),
(16, 4, 'Sales Representative', '2021-04-01', '2021-09-30', 20),

-- Financial Reporting System Project
(9, 6, 'Project Manager', '2021-06-01', '2021-12-31', 40),
(10, 6, 'Financial Analyst', '2021-06-01', '2021-12-31', 35),
(11, 6, 'Accountant', '2021-06-01', '2021-12-31', 30),
(4, 6, 'Database Developer', '2021-06-01', '2021-12-31', 25),
(2, 6, 'Report Developer', '2021-06-01', '2021-12-31', 20);

-- =====================================================
-- 8. INSERT ATTENDANCE RECORDS (Sample for last 30 days)
-- =====================================================
INSERT INTO attendance (employee_id, date, check_in, check_out, total_hours, status, notes) VALUES
-- Employee 1 (John Smith) - IT Manager
(1, CURDATE() - INTERVAL 30 DAY, '09:00:00', '17:00:00', 8.00, 'Present', NULL),
(1, CURDATE() - INTERVAL 29 DAY, '08:45:00', '17:15:00', 8.50, 'Present', NULL),
(1, CURDATE() - INTERVAL 28 DAY, '09:15:00', '17:00:00', 7.75, 'Late', 'Traffic delay'),
(1, CURDATE() - INTERVAL 27 DAY, '09:00:00', '17:00:00', 8.00, 'Present', NULL),
(1, CURDATE() - INTERVAL 26 DAY, '09:00:00', '17:00:00', 8.00, 'Present', NULL),
(1, CURDATE() - INTERVAL 25 DAY, '09:00:00', '17:00:00', 8.00, 'Present', NULL),
(1, CURDATE() - INTERVAL 24 DAY, NULL, NULL, 0.00, 'Leave', 'Personal leave'),
(1, CURDATE() - INTERVAL 23 DAY, '09:00:00', '17:00:00', 8.00, 'Present', NULL),
(1, CURDATE() - INTERVAL 22 DAY, '09:00:00', '17:00:00', 8.00, 'Present', NULL),
(1, CURDATE() - INTERVAL 21 DAY, '09:00:00', '17:00:00', 8.00, 'Present', NULL),

-- Employee 2 (Sarah Johnson) - Senior Software Engineer
(2, CURDATE() - INTERVAL 30 DAY, '09:00:00', '17:00:00', 8.00, 'Present', NULL),
(2, CURDATE() - INTERVAL 29 DAY, '09:00:00', '17:00:00', 8.00, 'Present', NULL),
(2, CURDATE() - INTERVAL 28 DAY, '09:00:00', '17:00:00', 8.00, 'Present', NULL),
(2, CURDATE() - INTERVAL 27 DAY, '09:00:00', '17:00:00', 8.00, 'Present', NULL),
(2, CURDATE() - INTERVAL 26 DAY, '09:00:00', '17:00:00', 8.00, 'Present', NULL),
(2, CURDATE() - INTERVAL 25 DAY, '09:00:00', '17:00:00', 8.00, 'Present', NULL),
(2, CURDATE() - INTERVAL 24 DAY, '09:00:00', '17:00:00', 8.00, 'Present', NULL),
(2, CURDATE() - INTERVAL 23 DAY, '09:00:00', '17:00:00', 8.00, 'Present', NULL),
(2, CURDATE() - INTERVAL 22 DAY, '09:00:00', '17:00:00', 8.00, 'Present', NULL),
(2, CURDATE() - INTERVAL 21 DAY, '09:00:00', '17:00:00', 8.00, 'Present', NULL),

-- Employee 6 (Jennifer Taylor) - HR Manager
(6, CURDATE() - INTERVAL 30 DAY, '09:00:00', '17:00:00', 8.00, 'Present', NULL),
(6, CURDATE() - INTERVAL 29 DAY, '09:00:00', '17:00:00', 8.00, 'Present', NULL),
(6, CURDATE() - INTERVAL 28 DAY, '09:00:00', '17:00:00', 8.00, 'Present', NULL),
(6, CURDATE() - INTERVAL 27 DAY, '09:00:00', '17:00:00', 8.00, 'Present', NULL),
(6, CURDATE() - INTERVAL 26 DAY, '09:00:00', '17:00:00', 8.00, 'Present', NULL),
(6, CURDATE() - INTERVAL 25 DAY, '09:00:00', '17:00:00', 8.00, 'Present', NULL),
(6, CURDATE() - INTERVAL 24 DAY, '09:00:00', '17:00:00', 8.00, 'Present', NULL),
(6, CURDATE() - INTERVAL 23 DAY, '09:00:00', '17:00:00', 8.00, 'Present', NULL),
(6, CURDATE() - INTERVAL 22 DAY, '09:00:00', '17:00:00', 8.00, 'Present', NULL),
(6, CURDATE() - INTERVAL 21 DAY, '09:00:00', '17:00:00', 8.00, 'Present', NULL);

-- =====================================================
-- 9. INSERT PERFORMANCE REVIEWS
-- =====================================================
INSERT INTO performance_reviews (employee_id, reviewer_id, review_period_start, review_period_end, review_date, overall_rating, technical_skills_rating, communication_rating, teamwork_rating, leadership_rating, strengths, areas_of_improvement, goals_for_next_period, recommendations, status) VALUES
-- Performance reviews for key employees
(1, 6, '2020-01-15', '2021-01-14', '2021-01-20', 4.5, 4.5, 4.0, 4.5, 4.5, 'Excellent technical leadership and team management skills', 'Could improve communication with non-technical stakeholders', 'Lead major IT initiatives and mentor junior developers', 'Consider leadership training program', 'Approved'),
(2, 1, '2020-03-20', '2021-03-19', '2021-03-25', 4.2, 4.5, 4.0, 4.0, 3.5, 'Strong technical skills and problem-solving abilities', 'Needs to improve leadership and mentoring skills', 'Take on more complex projects and mentor junior developers', 'Assign leadership responsibilities gradually', 'Approved'),
(6, 1, '2020-02-01', '2021-01-31', '2021-02-05', 4.3, 3.5, 4.5, 4.5, 4.0, 'Excellent people management and communication skills', 'Could enhance technical knowledge of HR systems', 'Implement new HR processes and improve employee satisfaction', 'Attend HR technology training', 'Approved'),
(9, 1, '2020-01-10', '2021-01-09', '2021-01-15', 4.4, 4.0, 4.5, 4.0, 4.5, 'Strong financial acumen and strategic thinking', 'Could improve team collaboration', 'Optimize financial processes and lead cost reduction initiatives', 'Participate in cross-functional projects', 'Approved'),
(12, 1, '2020-03-15', '2021-03-14', '2021-03-20', 4.1, 3.5, 4.5, 4.0, 4.0, 'Creative marketing strategies and excellent communication', 'Needs to improve data analysis skills', 'Launch successful marketing campaigns and increase brand awareness', 'Enroll in data analytics course', 'Approved'),
(15, 1, '2020-04-05', '2021-04-04', '2021-04-10', 4.0, 3.5, 4.5, 4.0, 4.0, 'Strong sales performance and customer relationship skills', 'Could improve team management', 'Increase sales revenue and develop sales team', 'Attend sales management training', 'Approved'),
(20, 1, '2020-02-28', '2021-02-27', '2021-03-05', 4.6, 4.5, 4.0, 4.5, 4.5, 'Outstanding research capabilities and innovation', 'Could improve project timeline management', 'Lead breakthrough research projects and publish findings', 'Implement project management tools', 'Approved'),
(23, 1, '2020-08-22', '2021-08-21', '2021-08-27', 4.2, 4.0, 4.5, 4.0, 4.0, 'Excellent customer service skills and problem resolution', 'Could improve technical knowledge', 'Improve customer satisfaction scores and implement new support tools', 'Attend technical training sessions', 'Approved');

-- =====================================================
-- SAMPLE DATA INSERTION COMPLETE
-- =====================================================

-- Display sample data counts
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

-- Display sample employee data
SELECT 
    e.employee_code,
    CONCAT(e.first_name, ' ', e.last_name) as employee_name,
    d.department_name,
    p.position_title,
    e.salary,
    e.status
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN positions p ON e.position_id = p.position_id
ORDER BY e.employee_id
LIMIT 10;
