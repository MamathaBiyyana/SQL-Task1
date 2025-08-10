-- =====================================================
-- Example SQL Queries for Employee Management Database
-- SQL Internship Task
-- =====================================================

USE employee_management;

-- =====================================================
-- 1. BASIC SELECT QUERIES
-- =====================================================

-- 1.1 List all employees with their department and position
SELECT 
    e.employee_code,
    CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
    d.department_name,
    p.position_title,
    e.salary,
    e.hire_date,
    e.status
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN positions p ON e.position_id = p.position_id
ORDER BY e.employee_id;

-- 1.2 Find employees by department
SELECT 
    e.employee_code,
    CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
    p.position_title,
    e.salary
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN positions p ON e.position_id = p.position_id
WHERE d.department_name = 'Information Technology'
ORDER BY e.salary DESC;

-- 1.3 Count employees by department
SELECT 
    d.department_name,
    COUNT(e.employee_id) AS employee_count,
    AVG(e.salary) AS avg_salary,
    SUM(e.salary) AS total_salary
FROM departments d
LEFT JOIN employees e ON d.department_id = e.department_id AND e.status = 'Active'
GROUP BY d.department_id, d.department_name
ORDER BY employee_count DESC;

-- =====================================================
-- 2. MANAGER AND HIERARCHY QUERIES
-- =====================================================

-- 2.1 Show employee hierarchy (employees and their managers)
SELECT 
    e.employee_code,
    CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
    d.department_name,
    CONCAT(m.first_name, ' ', m.last_name) AS manager_name,
    m.employee_code AS manager_code
FROM employees e
JOIN departments d ON e.department_id = d.department_id
LEFT JOIN employees m ON e.manager_id = m.employee_id
ORDER BY d.department_name, e.employee_id;

-- 2.2 Find employees who are managers
SELECT 
    e.employee_code,
    CONCAT(e.first_name, ' ', e.last_name) AS manager_name,
    d.department_name,
    p.position_title,
    COUNT(sub.employee_id) AS direct_reports
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN positions p ON e.position_id = p.position_id
LEFT JOIN employees sub ON e.employee_id = sub.manager_id
WHERE e.employee_id IN (SELECT DISTINCT manager_id FROM employees WHERE manager_id IS NOT NULL)
GROUP BY e.employee_id, e.employee_code, e.first_name, e.last_name, d.department_name, p.position_title
ORDER BY direct_reports DESC;

-- 2.3 Department managers and their departments
SELECT 
    d.department_name,
    d.location,
    CONCAT(e.first_name, ' ', e.last_name) AS manager_name,
    e.email,
    e.phone
FROM departments d
JOIN employees e ON d.manager_id = e.employee_id
ORDER BY d.department_name;

-- =====================================================
-- 3. SALARY ANALYSIS QUERIES
-- =====================================================

-- 3.1 Salary range by position
SELECT 
    p.position_title,
    d.department_name,
    p.min_salary,
    p.max_salary,
    AVG(e.salary) AS avg_current_salary,
    COUNT(e.employee_id) AS employee_count
FROM positions p
JOIN departments d ON p.department_id = d.department_id
LEFT JOIN employees e ON p.position_id = e.position_id AND e.status = 'Active'
GROUP BY p.position_id, p.position_title, d.department_name, p.min_salary, p.max_salary
ORDER BY avg_current_salary DESC;

-- 3.2 Top 10 highest paid employees
SELECT 
    e.employee_code,
    CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
    d.department_name,
    p.position_title,
    e.salary,
    e.hire_date
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN positions p ON e.position_id = p.position_id
WHERE e.status = 'Active'
ORDER BY e.salary DESC
LIMIT 10;

-- 3.3 Salary history for a specific employee
SELECT 
    es.salary_amount,
    es.effective_date,
    es.salary_type,
    es.reason,
    CONCAT(approver.first_name, ' ', approver.last_name) AS approved_by
FROM employee_salaries es
LEFT JOIN employees approver ON es.approved_by = approver.employee_id
WHERE es.employee_id = 1  -- Change employee_id as needed
ORDER BY es.effective_date DESC;

-- =====================================================
-- 4. PROJECT AND ASSIGNMENT QUERIES
-- =====================================================

-- 4.1 Active projects with team members
SELECT 
    p.project_name,
    p.project_code,
    p.status,
    p.priority,
    d.department_name,
    CONCAT(pm.first_name, ' ', pm.last_name) AS project_manager,
    COUNT(ep.employee_id) AS team_size,
    SUM(ep.hours_allocated) AS total_hours_allocated
FROM projects p
JOIN departments d ON p.department_id = d.department_id
LEFT JOIN employees pm ON p.project_manager_id = pm.employee_id
LEFT JOIN employee_projects ep ON p.project_id = ep.project_id AND ep.is_active = TRUE
WHERE p.status IN ('Active', 'Planning')
GROUP BY p.project_id, p.project_name, p.project_code, p.status, p.priority, d.department_name, pm.first_name, pm.last_name
ORDER BY p.priority DESC, p.status;

-- 4.2 Employee project assignments
SELECT 
    CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
    e.employee_code,
    p.project_name,
    ep.role,
    ep.start_date,
    ep.end_date,
    ep.hours_allocated
FROM employee_projects ep
JOIN employees e ON ep.employee_id = e.employee_id
JOIN projects p ON ep.project_id = p.project_id
WHERE ep.is_active = TRUE
ORDER BY e.employee_id, ep.start_date;

-- 4.3 Projects by department
SELECT 
    d.department_name,
    COUNT(p.project_id) AS total_projects,
    COUNT(CASE WHEN p.status = 'Active' THEN 1 END) AS active_projects,
    COUNT(CASE WHEN p.status = 'Completed' THEN 1 END) AS completed_projects,
    SUM(p.budget) AS total_budget
FROM departments d
LEFT JOIN projects p ON d.department_id = p.department_id
GROUP BY d.department_id, d.department_name
ORDER BY total_projects DESC;

-- =====================================================
-- 5. ATTENDANCE AND PERFORMANCE QUERIES
-- =====================================================

-- 5.1 Attendance summary for the last 30 days
SELECT 
    CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
    d.department_name,
    COUNT(a.attendance_id) AS days_recorded,
    COUNT(CASE WHEN a.status = 'Present' THEN 1 END) AS days_present,
    COUNT(CASE WHEN a.status = 'Absent' THEN 1 END) AS days_absent,
    COUNT(CASE WHEN a.status = 'Late' THEN 1 END) AS days_late,
    COUNT(CASE WHEN a.status = 'Leave' THEN 1 END) AS days_leave,
    AVG(a.total_hours) AS avg_hours_per_day
FROM employees e
JOIN departments d ON e.department_id = d.department_id
LEFT JOIN attendance a ON e.employee_id = a.employee_id 
    AND a.date >= CURDATE() - INTERVAL 30 DAY
WHERE e.status = 'Active'
GROUP BY e.employee_id, e.first_name, e.last_name, d.department_name
ORDER BY days_present DESC;

-- 5.2 Performance review summary
SELECT 
    CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
    d.department_name,
    pr.overall_rating,
    pr.technical_skills_rating,
    pr.communication_rating,
    pr.teamwork_rating,
    pr.leadership_rating,
    pr.review_date,
    pr.status
FROM performance_reviews pr
JOIN employees e ON pr.employee_id = e.employee_id
JOIN departments d ON e.department_id = d.department_id
WHERE pr.status = 'Approved'
ORDER BY pr.overall_rating DESC;

-- 5.3 Top performers by department
SELECT 
    d.department_name,
    CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
    p.position_title,
    pr.overall_rating,
    e.salary
FROM performance_reviews pr
JOIN employees e ON pr.employee_id = e.employee_id
JOIN departments d ON e.department_id = d.department_id
JOIN positions p ON e.position_id = p.position_id
WHERE pr.status = 'Approved'
    AND pr.overall_rating >= 4.0
ORDER BY d.department_name, pr.overall_rating DESC;

-- =====================================================
-- 6. COMPLEX ANALYTICAL QUERIES
-- =====================================================

-- 6.1 Department efficiency analysis
SELECT 
    d.department_name,
    COUNT(e.employee_id) AS employee_count,
    AVG(e.salary) AS avg_salary,
    AVG(pr.overall_rating) AS avg_performance_rating,
    COUNT(p.project_id) AS active_projects,
    SUM(p.budget) AS total_project_budget
FROM departments d
LEFT JOIN employees e ON d.department_id = e.department_id AND e.status = 'Active'
LEFT JOIN performance_reviews pr ON e.employee_id = pr.employee_id AND pr.status = 'Approved'
LEFT JOIN projects p ON d.department_id = p.department_id AND p.status = 'Active'
GROUP BY d.department_id, d.department_name
ORDER BY avg_performance_rating DESC;

-- 6.2 Employee workload analysis
SELECT 
    CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
    d.department_name,
    p.position_title,
    e.salary,
    COUNT(ep.project_id) AS active_projects,
    SUM(ep.hours_allocated) AS total_hours_allocated,
    AVG(a.total_hours) AS avg_attendance_hours,
    pr.overall_rating
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN positions p ON e.position_id = p.position_id
LEFT JOIN employee_projects ep ON e.employee_id = ep.employee_id AND ep.is_active = TRUE
LEFT JOIN attendance a ON e.employee_id = a.employee_id 
    AND a.date >= CURDATE() - INTERVAL 30 DAY
LEFT JOIN performance_reviews pr ON e.employee_id = pr.employee_id 
    AND pr.status = 'Approved'
    AND pr.review_date = (
        SELECT MAX(review_date) 
        FROM performance_reviews 
        WHERE employee_id = e.employee_id AND status = 'Approved'
    )
WHERE e.status = 'Active'
GROUP BY e.employee_id, e.first_name, e.last_name, d.department_name, p.position_title, e.salary, pr.overall_rating
ORDER BY total_hours_allocated DESC;

-- 6.3 Salary vs Performance correlation
SELECT 
    d.department_name,
    AVG(e.salary) AS avg_salary,
    AVG(pr.overall_rating) AS avg_performance,
    COUNT(e.employee_id) AS employee_count,
    CASE 
        WHEN AVG(pr.overall_rating) >= 4.0 THEN 'High Performance'
        WHEN AVG(pr.overall_rating) >= 3.0 THEN 'Medium Performance'
        ELSE 'Low Performance'
    END AS performance_category
FROM employees e
JOIN departments d ON e.department_id = d.department_id
LEFT JOIN performance_reviews pr ON e.employee_id = pr.employee_id AND pr.status = 'Approved'
WHERE e.status = 'Active'
GROUP BY d.department_id, d.department_name
HAVING avg_performance IS NOT NULL
ORDER BY avg_performance DESC;

-- =====================================================
-- 7. REPORTING QUERIES
-- =====================================================

-- 7.1 Monthly employee summary report
SELECT 
    DATE_FORMAT(e.hire_date, '%Y-%m') AS hire_month,
    d.department_name,
    COUNT(e.employee_id) AS new_hires,
    AVG(e.salary) AS avg_starting_salary
FROM employees e
JOIN departments d ON e.department_id = d.department_id
WHERE e.hire_date >= '2020-01-01'
GROUP BY DATE_FORMAT(e.hire_date, '%Y-%m'), d.department_id, d.department_name
ORDER BY hire_month DESC, new_hires DESC;

-- 7.2 Project budget utilization
SELECT 
    p.project_name,
    p.project_code,
    p.budget AS allocated_budget,
    COUNT(ep.employee_id) AS team_size,
    SUM(ep.hours_allocated) AS total_hours,
    ROUND((SUM(ep.hours_allocated) * 50) / p.budget * 100, 2) AS budget_utilization_percent
FROM projects p
LEFT JOIN employee_projects ep ON p.project_id = ep.project_id AND ep.is_active = TRUE
WHERE p.status = 'Active'
GROUP BY p.project_id, p.project_name, p.project_code, p.budget
ORDER BY budget_utilization_percent DESC;

-- 7.3 Employee retention analysis
SELECT 
    d.department_name,
    COUNT(e.employee_id) AS total_employees,
    COUNT(CASE WHEN e.hire_date <= '2020-12-31' THEN 1 END) AS employees_2020,
    COUNT(CASE WHEN e.hire_date > '2020-12-31' THEN 1 END) AS employees_2021,
    ROUND(COUNT(CASE WHEN e.hire_date > '2020-12-31' THEN 1 END) * 100.0 / COUNT(e.employee_id), 2) AS growth_percentage
FROM employees e
JOIN departments d ON e.department_id = d.department_id
WHERE e.status = 'Active'
GROUP BY d.department_id, d.department_name
ORDER BY growth_percentage DESC;

-- =====================================================
-- 8. VIEW-BASED QUERIES (Using the views we created)
-- =====================================================

-- 8.1 Using employee_details view
SELECT * FROM employee_details WHERE department_name = 'Information Technology';

-- 8.2 Using department_summary view
SELECT * FROM department_summary ORDER BY employee_count DESC;

-- 8.3 Using project_assignments view
SELECT * FROM project_assignments WHERE project_status = 'Active';

-- =====================================================
-- 9. DATA INTEGRITY AND VALIDATION QUERIES
-- =====================================================

-- 9.1 Check for orphaned records
SELECT 'employee_projects without employee' AS issue, COUNT(*) AS count
FROM employee_projects ep
LEFT JOIN employees e ON ep.employee_id = e.employee_id
WHERE e.employee_id IS NULL
UNION ALL
SELECT 'employee_projects without project' AS issue, COUNT(*) AS count
FROM employee_projects ep
LEFT JOIN projects p ON ep.project_id = p.project_id
WHERE p.project_id IS NULL;

-- 9.2 Validate salary constraints
SELECT 
    e.employee_code,
    CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
    e.salary,
    p.min_salary,
    p.max_salary,
    CASE 
        WHEN e.salary < p.min_salary THEN 'Below minimum'
        WHEN e.salary > p.max_salary THEN 'Above maximum'
        ELSE 'Within range'
    END AS salary_status
FROM employees e
JOIN positions p ON e.position_id = p.position_id
WHERE e.salary < p.min_salary OR e.salary > p.max_salary;

-- 9.3 Check for duplicate email addresses
SELECT email, COUNT(*) AS count
FROM employees
GROUP BY email
HAVING COUNT(*) > 1;

-- =====================================================
-- 10. ADVANCED QUERIES WITH WINDOW FUNCTIONS
-- =====================================================

-- 10.1 Salary ranking within departments
SELECT 
    d.department_name,
    CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
    e.salary,
    RANK() OVER (PARTITION BY d.department_id ORDER BY e.salary DESC) AS salary_rank_in_dept,
    RANK() OVER (ORDER BY e.salary DESC) AS salary_rank_overall
FROM employees e
JOIN departments d ON e.department_id = d.department_id
WHERE e.status = 'Active'
ORDER BY d.department_name, salary_rank_in_dept;

-- 10.2 Running total of salaries by department
SELECT 
    d.department_name,
    CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
    e.salary,
    SUM(e.salary) OVER (PARTITION BY d.department_id ORDER BY e.salary DESC) AS running_total
FROM employees e
JOIN departments d ON e.department_id = d.department_id
WHERE e.status = 'Active'
ORDER BY d.department_name, e.salary DESC;

-- 10.3 Employee performance percentile
SELECT 
    CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
    d.department_name,
    pr.overall_rating,
    NTILE(4) OVER (ORDER BY pr.overall_rating DESC) AS performance_quartile
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN performance_reviews pr ON e.employee_id = pr.employee_id
WHERE pr.status = 'Approved'
ORDER BY pr.overall_rating DESC;
