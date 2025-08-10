-- =====================================================
-- Employee Management Database Schema
-- SQL Internship Task
-- =====================================================

-- Drop database if exists and create new one
DROP DATABASE IF EXISTS employee_management;
CREATE DATABASE employee_management;
USE employee_management;

-- =====================================================
-- 1. DEPARTMENTS TABLE
-- =====================================================
CREATE TABLE departments (
    department_id INT PRIMARY KEY AUTO_INCREMENT,
    department_name VARCHAR(100) NOT NULL UNIQUE,
    department_code VARCHAR(10) NOT NULL UNIQUE,
    location VARCHAR(100),
    manager_id INT NULL,
    budget DECIMAL(12,2) DEFAULT 0.00,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    INDEX idx_department_name (department_name),
    INDEX idx_department_code (department_code)
);

-- =====================================================
-- 2. POSITIONS TABLE
-- =====================================================
CREATE TABLE positions (
    position_id INT PRIMARY KEY AUTO_INCREMENT,
    position_title VARCHAR(100) NOT NULL,
    position_code VARCHAR(20) NOT NULL UNIQUE,
    department_id INT NOT NULL,
    min_salary DECIMAL(10,2) NOT NULL,
    max_salary DECIMAL(10,2) NOT NULL,
    job_description TEXT,
    requirements TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    FOREIGN KEY (department_id) REFERENCES departments(department_id) ON DELETE RESTRICT,
    INDEX idx_position_title (position_title),
    INDEX idx_department_position (department_id, position_id),
    CHECK (min_salary <= max_salary)
);

-- =====================================================
-- 3. EMPLOYEES TABLE
-- =====================================================
CREATE TABLE employees (
    employee_id INT PRIMARY KEY AUTO_INCREMENT,
    employee_code VARCHAR(20) NOT NULL UNIQUE,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(20),
    date_of_birth DATE NOT NULL,
    gender ENUM('Male', 'Female', 'Other') NOT NULL,
    hire_date DATE NOT NULL,
    department_id INT NOT NULL,
    position_id INT NOT NULL,
    manager_id INT NULL,
    salary DECIMAL(10,2) NOT NULL,
    status ENUM('Active', 'Inactive', 'Terminated', 'On Leave') DEFAULT 'Active',
    address TEXT,
    emergency_contact VARCHAR(100),
    emergency_phone VARCHAR(20),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    FOREIGN KEY (department_id) REFERENCES departments(department_id) ON DELETE RESTRICT,
    FOREIGN KEY (position_id) REFERENCES positions(position_id) ON DELETE RESTRICT,
    FOREIGN KEY (manager_id) REFERENCES employees(employee_id) ON DELETE SET NULL,
    
    INDEX idx_employee_code (employee_code),
    INDEX idx_email (email),
    INDEX idx_department_employee (department_id),
    INDEX idx_position_employee (position_id),
    INDEX idx_manager_employee (manager_id),
    INDEX idx_status (status),
    INDEX idx_hire_date (hire_date),
    
    CHECK (salary > 0),
    CHECK (date_of_birth < hire_date)
);

-- =====================================================
-- 4. EMPLOYEE_SALARIES TABLE (Salary History)
-- =====================================================
CREATE TABLE employee_salaries (
    salary_id INT PRIMARY KEY AUTO_INCREMENT,
    employee_id INT NOT NULL,
    salary_amount DECIMAL(10,2) NOT NULL,
    effective_date DATE NOT NULL,
    end_date DATE NULL,
    salary_type ENUM('Base', 'Bonus', 'Increment', 'Decrement') DEFAULT 'Base',
    reason VARCHAR(200),
    approved_by INT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id) ON DELETE CASCADE,
    FOREIGN KEY (approved_by) REFERENCES employees(employee_id) ON DELETE SET NULL,
    
    INDEX idx_employee_salary (employee_id),
    INDEX idx_effective_date (effective_date),
    INDEX idx_salary_type (salary_type),
    
    CHECK (salary_amount > 0),
    CHECK (effective_date <= COALESCE(end_date, '9999-12-31'))
);

-- =====================================================
-- 5. PROJECTS TABLE
-- =====================================================
CREATE TABLE projects (
    project_id INT PRIMARY KEY AUTO_INCREMENT,
    project_name VARCHAR(200) NOT NULL,
    project_code VARCHAR(20) NOT NULL UNIQUE,
    description TEXT,
    department_id INT NOT NULL,
    project_manager_id INT NULL,
    start_date DATE NOT NULL,
    end_date DATE NULL,
    budget DECIMAL(12,2) DEFAULT 0.00,
    status ENUM('Planning', 'Active', 'On Hold', 'Completed', 'Cancelled') DEFAULT 'Planning',
    priority ENUM('Low', 'Medium', 'High', 'Critical') DEFAULT 'Medium',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    FOREIGN KEY (department_id) REFERENCES departments(department_id) ON DELETE RESTRICT,
    FOREIGN KEY (project_manager_id) REFERENCES employees(employee_id) ON DELETE SET NULL,
    
    INDEX idx_project_code (project_code),
    INDEX idx_project_status (status),
    INDEX idx_project_dates (start_date, end_date),
    INDEX idx_department_project (department_id),
    
    CHECK (start_date <= COALESCE(end_date, '9999-12-31'))
);

-- =====================================================
-- 6. EMPLOYEE_PROJECTS TABLE (Many-to-Many Relationship)
-- =====================================================
CREATE TABLE employee_projects (
    assignment_id INT PRIMARY KEY AUTO_INCREMENT,
    employee_id INT NOT NULL,
    project_id INT NOT NULL,
    role VARCHAR(100) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NULL,
    hours_allocated INT DEFAULT 0,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id) ON DELETE CASCADE,
    FOREIGN KEY (project_id) REFERENCES projects(project_id) ON DELETE CASCADE,
    
    UNIQUE KEY unique_employee_project (employee_id, project_id),
    INDEX idx_employee_assignment (employee_id),
    INDEX idx_project_assignment (project_id),
    INDEX idx_active_assignments (is_active),
    
    CHECK (hours_allocated >= 0),
    CHECK (start_date <= COALESCE(end_date, '9999-12-31'))
);

-- =====================================================
-- 7. ATTENDANCE TABLE
-- =====================================================
CREATE TABLE attendance (
    attendance_id INT PRIMARY KEY AUTO_INCREMENT,
    employee_id INT NOT NULL,
    date DATE NOT NULL,
    check_in TIME NULL,
    check_out TIME NULL,
    total_hours DECIMAL(4,2) DEFAULT 0.00,
    status ENUM('Present', 'Absent', 'Late', 'Half Day', 'Leave') DEFAULT 'Present',
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id) ON DELETE CASCADE,
    
    UNIQUE KEY unique_employee_date (employee_id, date),
    INDEX idx_employee_attendance (employee_id),
    INDEX idx_date_attendance (date),
    INDEX idx_status_attendance (status),
    
    CHECK (total_hours >= 0 AND total_hours <= 24)
);

-- =====================================================
-- 8. PERFORMANCE_REVIEWS TABLE
-- =====================================================
CREATE TABLE performance_reviews (
    review_id INT PRIMARY KEY AUTO_INCREMENT,
    employee_id INT NOT NULL,
    reviewer_id INT NOT NULL,
    review_period_start DATE NOT NULL,
    review_period_end DATE NOT NULL,
    review_date DATE NOT NULL,
    overall_rating DECIMAL(3,1) NOT NULL,
    technical_skills_rating DECIMAL(3,1) NOT NULL,
    communication_rating DECIMAL(3,1) NOT NULL,
    teamwork_rating DECIMAL(3,1) NOT NULL,
    leadership_rating DECIMAL(3,1) NOT NULL,
    strengths TEXT,
    areas_of_improvement TEXT,
    goals_for_next_period TEXT,
    recommendations TEXT,
    status ENUM('Draft', 'Submitted', 'Reviewed', 'Approved', 'Rejected') DEFAULT 'Draft',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id) ON DELETE CASCADE,
    FOREIGN KEY (reviewer_id) REFERENCES employees(employee_id) ON DELETE RESTRICT,
    
    INDEX idx_employee_review (employee_id),
    INDEX idx_reviewer_review (reviewer_id),
    INDEX idx_review_period (review_period_start, review_period_end),
    INDEX idx_review_status (status),
    
    CHECK (overall_rating >= 1.0 AND overall_rating <= 5.0),
    CHECK (technical_skills_rating >= 1.0 AND technical_skills_rating <= 5.0),
    CHECK (communication_rating >= 1.0 AND communication_rating <= 5.0),
    CHECK (teamwork_rating >= 1.0 AND teamwork_rating <= 5.0),
    CHECK (leadership_rating >= 1.0 AND leadership_rating <= 5.0),
    CHECK (review_period_start <= review_period_end),
    CHECK (review_date >= review_period_end)
);

-- =====================================================
-- TRIGGERS FOR AUDIT TRAIL
-- =====================================================

-- Trigger to update department manager reference
DELIMITER //
CREATE TRIGGER after_employee_insert
AFTER INSERT ON employees
FOR EACH ROW
BEGIN
    -- Update department manager if this employee is a manager
    IF NEW.manager_id IS NULL THEN
        UPDATE departments 
        SET manager_id = NEW.employee_id 
        WHERE department_id = NEW.department_id AND manager_id IS NULL;
    END IF;
END//
DELIMITER ;

-- Trigger to log salary changes
DELIMITER //
CREATE TRIGGER after_salary_insert
AFTER INSERT ON employee_salaries
FOR EACH ROW
BEGIN
    -- Update current salary in employees table
    UPDATE employees 
    SET salary = NEW.salary_amount 
    WHERE employee_id = NEW.employee_id;
END//
DELIMITER ;

-- =====================================================
-- VIEWS FOR COMMON QUERIES
-- =====================================================

-- Employee details with department and position
CREATE VIEW employee_details AS
SELECT 
    e.employee_id,
    e.employee_code,
    e.first_name,
    e.last_name,
    e.email,
    e.phone,
    e.hire_date,
    e.salary,
    e.status,
    d.department_name,
    p.position_title,
    CONCAT(m.first_name, ' ', m.last_name) AS manager_name
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN positions p ON e.position_id = p.position_id
LEFT JOIN employees m ON e.manager_id = m.employee_id;

-- Department summary
CREATE VIEW department_summary AS
SELECT 
    d.department_id,
    d.department_name,
    d.location,
    COUNT(e.employee_id) AS employee_count,
    AVG(e.salary) AS avg_salary,
    SUM(e.salary) AS total_salary_budget,
    CONCAT(m.first_name, ' ', m.last_name) AS manager_name
FROM departments d
LEFT JOIN employees e ON d.department_id = e.department_id AND e.status = 'Active'
LEFT JOIN employees m ON d.manager_id = m.employee_id
GROUP BY d.department_id, d.department_name, d.location, m.first_name, m.last_name;

-- Project assignments
CREATE VIEW project_assignments AS
SELECT 
    p.project_name,
    p.project_code,
    p.status AS project_status,
    e.employee_code,
    CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
    ep.role,
    ep.start_date,
    ep.end_date,
    ep.hours_allocated
FROM projects p
JOIN employee_projects ep ON p.project_id = ep.project_id
JOIN employees e ON ep.employee_id = e.employee_id
WHERE ep.is_active = TRUE;

-- =====================================================
-- INDEXES FOR PERFORMANCE OPTIMIZATION
-- =====================================================

-- Composite indexes for better query performance
CREATE INDEX idx_employee_department_status ON employees(department_id, status);
CREATE INDEX idx_employee_position_status ON employees(position_id, status);
CREATE INDEX idx_salary_employee_date ON employee_salaries(employee_id, effective_date);
CREATE INDEX idx_attendance_employee_date ON attendance(employee_id, date);
CREATE INDEX idx_review_employee_period ON performance_reviews(employee_id, review_period_start, review_period_end);

-- =====================================================
-- DATABASE CREATION COMPLETE
-- =====================================================

-- Display table information
SHOW TABLES;

-- Display table structures
DESCRIBE departments;
DESCRIBE positions;
DESCRIBE employees;
DESCRIBE employee_salaries;
DESCRIBE projects;
DESCRIBE employee_projects;
DESCRIBE attendance;
DESCRIBE performance_reviews;

-- Display views
SHOW FULL TABLES WHERE Table_type = 'VIEW';

-- Display triggers
SHOW TRIGGERS;

-- Display indexes
SHOW INDEX FROM employees;
SHOW INDEX FROM departments;
SHOW INDEX FROM positions;
