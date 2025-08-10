-- =====================================================
-- Sample Data Insertion Script
-- Employee Management Database
-- =====================================================

USE employee_management;

-- =====================================================
-- 1. INSERT DEPARTMENTS
-- =====================================================
INSERT INTO departments (department_name, department_code, location, budget) VALUES
('Information Technology', 'IT', 'Floor 3, Building A', 1500000.00),
('Human Resources', 'HR', 'Floor 2, Building A', 800000.00),
('Finance', 'FIN', 'Floor 4, Building A', 1200000.00),
('Marketing', 'MKT', 'Floor 1, Building B', 900000.00),
('Sales', 'SALES', 'Floor 2, Building B', 1100000.00),
('Operations', 'OPS', 'Floor 1, Building A', 700000.00),
('Research & Development', 'R&D', 'Floor 5, Building A', 2000000.00),
('Customer Support', 'CS', 'Floor 3, Building B', 600000.00);

-- =====================================================
-- 2. INSERT POSITIONS
-- =====================================================
INSERT INTO positions (position_title, position_code, department_id, min_salary, max_salary, job_description, requirements) VALUES
-- IT Department Positions
('Senior Software Engineer', 'IT-SSE-001', 1, 80000.00, 120000.00, 'Develop and maintain software applications', 'Bachelor in CS, 5+ years experience'),
('Software Engineer', 'IT-SE-001', 1, 60000.00, 90000.00, 'Develop software applications', 'Bachelor in CS, 2+ years experience'),
('Database Administrator', 'IT-DBA-001', 1, 70000.00, 110000.00, 'Manage and maintain databases', 'Bachelor in CS, 3+ years experience'),
('System Administrator', 'IT-SA-001', 1, 65000.00, 100000.00, 'Manage IT infrastructure', 'Bachelor in IT, 3+ years experience'),
('IT Manager', 'IT-MGR-001', 1, 90000.00, 140000.00, 'Manage IT department', 'Bachelor in CS, 8+ years experience'),

-- HR Department Positions
('HR Manager', 'HR-MGR-001', 2, 70000.00, 110000.00, 'Manage HR operations', 'Bachelor in HR, 5+ years experience'),
('HR Specialist', 'HR-SPEC-001', 2, 50000.00, 75000.00, 'Handle HR processes', 'Bachelor in HR, 2+ years experience'),
('Recruiter', 'HR-REC-001', 2, 45000.00, 70000.00, 'Recruit new employees', 'Bachelor degree, 1+ years experience'),

-- Finance Department Positions
('Finance Manager', 'FIN-MGR-001', 3, 80000.00, 130000.00, 'Manage financial operations', 'Bachelor in Finance, 6+ years experience'),
('Financial Analyst', 'FIN-ANAL-001', 3, 55000.00, 85000.00, 'Analyze financial data', 'Bachelor in Finance, 2+ years experience'),
('Accountant', 'FIN-ACC-001', 3, 45000.00, 70000.00, 'Handle accounting tasks', 'Bachelor in Accounting, 1+ years experience'),

-- Marketing Department Positions
('Marketing Manager', 'MKT-MGR-001', 4, 75000.00, 120000.00, 'Manage marketing campaigns', 'Bachelor in Marketing, 5+ years experience'),
('Marketing Specialist', 'MKT-SPEC-001', 4, 50000.00, 80000.00, 'Execute marketing strategies', 'Bachelor in Marketing, 2+ years experience'),
('Digital Marketing Specialist', 'MKT-DIG-001', 4, 55000.00, 85000.00, 'Manage digital marketing', 'Bachelor degree, 2+ years experience'),

-- Sales Department Positions
('Sales Manager', 'SALES-MGR-001', 5, 70000.00, 120000.00, 'Manage sales team', 'Bachelor degree, 5+ years experience'),
('Sales Representative', 'SALES-REP-001', 5, 40000.00, 70000.00, 'Generate sales', 'Bachelor degree, 1+ years experience'),
('Account Executive', 'SALES-AE-001', 5, 50000.00, 90000.00, 'Manage client accounts', 'Bachelor degree, 3+ years experience'),

-- Operations Department Positions
('Operations Manager', 'OPS-MGR-001', 6, 65000.00, 100000.00, 'Manage operations', 'Bachelor degree, 4+ years experience'),
('Operations Specialist', 'OPS-SPEC-001', 6, 45000.00, 70000.00, 'Support operations', 'Bachelor degree, 1+ years experience'),

-- R&D Department Positions
('Research Manager', 'RD-MGR-001', 7, 90000.00, 150000.00, 'Manage research projects', 'PhD, 5+ years experience'),
('Research Scientist', 'RD-SCI-001', 7, 70000.00, 120000.00, 'Conduct research', 'PhD, 2+ years experience'),
('Data Scientist', 'RD-DS-001', 7, 75000.00, 130000.00, 'Analyze data', 'Master in Data Science, 3+ years experience'),

-- Customer Support Department Positions
('Support Manager', 'CS-MGR-001', 8, 60000.00, 95000.00, 'Manage support team', 'Bachelor degree, 4+ years experience'),
('Customer Support Specialist', 'CS-SPEC-001', 8, 40000.00, 65000.00, 'Provide customer support', 'Bachelor degree, 1+ years experience');

-- =====================================================
-- 3. INSERT EMPLOYEES
-- =====================================================
INSERT INTO employees (employee_code, first_name, last_name, email, phone, date_of_birth, gender, hire_date, department_id, position_id, salary, status, address, emergency_contact, emergency_phone) VALUES
-- IT Department Employees
('EMP001', 'John', 'Smith', 'john.smith@company.com', '555-0101', '1985-03-15', 'Male', '2020-01-15', 1, 5, 95000.00, 'Active', '123 Main St, City, State 12345', 'Jane Smith', '555-0102'),
('EMP002', 'Sarah', 'Johnson', 'sarah.johnson@company.com', '555-0103', '1990-07-22', 'Female', '2020-03-20', 1, 1, 85000.00, 'Active', '456 Oak Ave, City, State 12345', 'Mike Johnson', '555-0104'),
('EMP003', 'Michael', 'Brown', 'michael.brown@company.com', '555-0105', '1988-11-08', 'Male', '2020-06-10', 1, 2, 70000.00, 'Active', '789 Pine Rd, City, State 12345', 'Lisa Brown', '555-0106'),
('EMP004', 'Emily', 'Davis', 'emily.davis@company.com', '555-0107', '1992-04-30', 'Female', '2021-01-05', 1, 3, 80000.00, 'Active', '321 Elm St, City, State 12345', 'Tom Davis', '555-0108'),
('EMP005', 'David', 'Wilson', 'david.wilson@company.com', '555-0109', '1987-09-12', 'Male', '2021-02-15', 1, 4, 75000.00, 'Active', '654 Maple Dr, City, State 12345', 'Amy Wilson', '555-0110'),

-- HR Department Employees
('EMP006', 'Jennifer', 'Taylor', 'jennifer.taylor@company.com', '555-0111', '1986-12-03', 'Female', '2020-02-01', 2, 6, 80000.00, 'Active', '987 Cedar Ln, City, State 12345', 'Robert Taylor', '555-0112'),
('EMP007', 'Christopher', 'Anderson', 'christopher.anderson@company.com', '555-0113', '1991-05-18', 'Male', '2020-04-12', 2, 7, 60000.00, 'Active', '147 Birch Way, City, State 12345', 'Maria Anderson', '555-0114'),
('EMP008', 'Amanda', 'Martinez', 'amanda.martinez@company.com', '555-0115', '1993-08-25', 'Female', '2021-03-08', 2, 8, 55000.00, 'Active', '258 Spruce Ct, City, State 12345', 'Carlos Martinez', '555-0116'),

-- Finance Department Employees
('EMP009', 'Robert', 'Garcia', 'robert.garcia@company.com', '555-0117', '1984-01-20', 'Male', '2020-01-10', 3, 9, 90000.00, 'Active', '369 Willow Rd, City, State 12345', 'Sofia Garcia', '555-0118'),
('EMP010', 'Lisa', 'Rodriguez', 'lisa.rodriguez@company.com', '555-0119', '1989-06-14', 'Female', '2020-05-22', 3, 10, 65000.00, 'Active', '741 Aspen Ave, City, State 12345', 'Jose Rodriguez', '555-0120'),
('EMP011', 'James', 'Miller', 'james.miller@company.com', '555-0121', '1990-10-07', 'Male', '2021-01-18', 3, 11, 55000.00, 'Active', '852 Poplar St, City, State 12345', 'Karen Miller', '555-0122'),

-- Marketing Department Employees
('EMP012', 'Michelle', 'Lee', 'michelle.lee@company.com', '555-0123', '1987-02-28', 'Female', '2020-03-15', 4, 12, 85000.00, 'Active', '963 Sycamore Dr, City, State 12345', 'Kevin Lee', '555-0124'),
('EMP013', 'Daniel', 'White', 'daniel.white@company.com', '555-0125', '1992-11-11', 'Male', '2020-07-08', 4, 13, 60000.00, 'Active', '159 Magnolia Ln, City, State 12345', 'Rachel White', '555-0126'),
('EMP014', 'Jessica', 'Clark', 'jessica.clark@company.com', '555-0127', '1991-04-05', 'Female', '2021-02-12', 4, 14, 65000.00, 'Active', '357 Dogwood Way, City, State 12345', 'Mark Clark', '555-0128'),

-- Sales Department Employees
('EMP015', 'Thomas', 'Lewis', 'thomas.lewis@company.com', '555-0129', '1986-08-16', 'Male', '2020-04-05', 5, 15, 80000.00, 'Active', '486 Redwood Ct, City, State 12345', 'Patricia Lewis', '555-0130'),
('EMP016', 'Nicole', 'Hall', 'nicole.hall@company.com', '555-0131', '1993-01-23', 'Female', '2020-06-20', 5, 16, 50000.00, 'Active', '753 Sequoia Rd, City, State 12345', 'Andrew Hall', '555-0132'),
('EMP017', 'Kevin', 'Young', 'kevin.young@company.com', '555-0133', '1989-12-09', 'Male', '2020-08-14', 5, 17, 65000.00, 'Active', '951 Cypress Ave, City, State 12345', 'Stephanie Young', '555-0134'),

-- Operations Department Employees
('EMP018', 'Rachel', 'King', 'rachel.king@company.com', '555-0135', '1988-03-17', 'Female', '2020-05-10', 6, 18, 70000.00, 'Active', '264 Hemlock St, City, State 12345', 'Brian King', '555-0136'),
('EMP019', 'Steven', 'Wright', 'steven.wright@company.com', '555-0137', '1990-07-29', 'Male', '2021-01-25', 6, 19, 55000.00, 'Active', '573 Fir Dr, City, State 12345', 'Melissa Wright', '555-0138'),

-- R&D Department Employees
('EMP020', 'Laura', 'Lopez', 'laura.lopez@company.com', '555-0139', '1983-05-12', 'Female', '2020-02-28', 7, 20, 110000.00, 'Active', '842 Juniper Ln, City, State 12345', 'Miguel Lopez', '555-0140'),
('EMP021', 'Ryan', 'Hill', 'ryan.hill@company.com', '555-0141', '1985-09-03', 'Male', '2020-04-18', 7, 21, 85000.00, 'Active', '135 Cedar Way, City, State 12345', 'Jennifer Hill', '555-0142'),
('EMP022', 'Ashley', 'Scott', 'ashley.scott@company.com', '555-0143', '1987-12-19', 'Female', '2020-07-30', 7, 22, 90000.00, 'Active', '246 Pine Ct, City, State 12345', 'Matthew Scott', '555-0144'),

-- Customer Support Department Employees
('EMP023', 'Brandon', 'Green', 'brandon.green@company.com', '555-0145', '1991-06-08', 'Male', '2020-08-22', 8, 23, 65000.00, 'Active', '357 Oak Rd, City, State 12345', 'Amanda Green', '555-0146'),
('EMP024', 'Stephanie', 'Adams', 'stephanie.adams@company.com', '555-0147', '1992-10-15', 'Female', '2020-09-05', 8, 24, 50000.00, 'Active', '468 Maple Ave, City, State 12345', 'David Adams', '555-0148');
