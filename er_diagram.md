# Entity Relationship (ER) Diagram for Employee Management Database

## Database Overview
The Employee Management Database consists of 8 main tables with complex relationships representing a comprehensive HR management system.

## Entity Relationships

### 1. Core Entities

#### **departments** (Primary Entity)
- **Primary Key**: `department_id` (INT, AUTO_INCREMENT)
- **Attributes**: 
  - `department_name` (VARCHAR(100), UNIQUE)
  - `department_code` (VARCHAR(10), UNIQUE)
  - `location` (VARCHAR(100))
  - `manager_id` (INT, Foreign Key to employees)
  - `budget` (DECIMAL(12,2))
  - `created_at`, `updated_at` (TIMESTAMP)

#### **positions** (Primary Entity)
- **Primary Key**: `position_id` (INT, AUTO_INCREMENT)
- **Attributes**:
  - `position_title` (VARCHAR(100))
  - `position_code` (VARCHAR(20), UNIQUE)
  - `department_id` (INT, Foreign Key to departments)
  - `min_salary`, `max_salary` (DECIMAL(10,2))
  - `job_description`, `requirements` (TEXT)
  - `created_at`, `updated_at` (TIMESTAMP)

#### **employees** (Primary Entity)
- **Primary Key**: `employee_id` (INT, AUTO_INCREMENT)
- **Attributes**:
  - `employee_code` (VARCHAR(20), UNIQUE)
  - `first_name`, `last_name` (VARCHAR(50))
  - `email` (VARCHAR(100), UNIQUE)
  - `phone` (VARCHAR(20))
  - `date_of_birth`, `hire_date` (DATE)
  - `gender` (ENUM: 'Male', 'Female', 'Other')
  - `department_id` (INT, Foreign Key to departments)
  - `position_id` (INT, Foreign Key to positions)
  - `manager_id` (INT, Foreign Key to employees - Self-referencing)
  - `salary` (DECIMAL(10,2))
  - `status` (ENUM: 'Active', 'Inactive', 'Terminated', 'On Leave')
  - `address`, `emergency_contact`, `emergency_phone` (TEXT/VARCHAR)
  - `created_at`, `updated_at` (TIMESTAMP)

### 2. Supporting Entities

#### **employee_salaries** (Weak Entity)
- **Primary Key**: `salary_id` (INT, AUTO_INCREMENT)
- **Attributes**:
  - `employee_id` (INT, Foreign Key to employees)
  - `salary_amount` (DECIMAL(10,2))
  - `effective_date`, `end_date` (DATE)
  - `salary_type` (ENUM: 'Base', 'Bonus', 'Increment', 'Decrement')
  - `reason` (VARCHAR(200))
  - `approved_by` (INT, Foreign Key to employees)
  - `created_at` (TIMESTAMP)

#### **projects** (Primary Entity)
- **Primary Key**: `project_id` (INT, AUTO_INCREMENT)
- **Attributes**:
  - `project_name` (VARCHAR(200))
  - `project_code` (VARCHAR(20), UNIQUE)
  - `description` (TEXT)
  - `department_id` (INT, Foreign Key to departments)
  - `project_manager_id` (INT, Foreign Key to employees)
  - `start_date`, `end_date` (DATE)
  - `budget` (DECIMAL(12,2))
  - `status` (ENUM: 'Planning', 'Active', 'On Hold', 'Completed', 'Cancelled')
  - `priority` (ENUM: 'Low', 'Medium', 'High', 'Critical')
  - `created_at`, `updated_at` (TIMESTAMP)

#### **employee_projects** (Junction Table - Many-to-Many)
- **Primary Key**: `assignment_id` (INT, AUTO_INCREMENT)
- **Attributes**:
  - `employee_id` (INT, Foreign Key to employees)
  - `project_id` (INT, Foreign Key to projects)
  - `role` (VARCHAR(100))
  - `start_date`, `end_date` (DATE)
  - `hours_allocated` (INT)
  - `is_active` (BOOLEAN)
  - `created_at`, `updated_at` (TIMESTAMP)

#### **attendance** (Weak Entity)
- **Primary Key**: `attendance_id` (INT, AUTO_INCREMENT)
- **Attributes**:
  - `employee_id` (INT, Foreign Key to employees)
  - `date` (DATE)
  - `check_in`, `check_out` (TIME)
  - `total_hours` (DECIMAL(4,2))
  - `status` (ENUM: 'Present', 'Absent', 'Late', 'Half Day', 'Leave')
  - `notes` (TEXT)
  - `created_at`, `updated_at` (TIMESTAMP)

#### **performance_reviews** (Weak Entity)
- **Primary Key**: `review_id` (INT, AUTO_INCREMENT)
- **Attributes**:
  - `employee_id` (INT, Foreign Key to employees)
  - `reviewer_id` (INT, Foreign Key to employees)
  - `review_period_start`, `review_period_end`, `review_date` (DATE)
  - `overall_rating`, `technical_skills_rating`, `communication_rating`, `teamwork_rating`, `leadership_rating` (DECIMAL(3,1))
  - `strengths`, `areas_of_improvement`, `goals_for_next_period`, `recommendations` (TEXT)
  - `status` (ENUM: 'Draft', 'Submitted', 'Reviewed', 'Approved', 'Rejected')
  - `created_at`, `updated_at` (TIMESTAMP)

## Relationship Types

### 1. One-to-Many Relationships
- **departments** → **positions** (One department can have many positions)
- **departments** → **employees** (One department can have many employees)
- **departments** → **projects** (One department can have many projects)
- **positions** → **employees** (One position can be held by many employees)
- **employees** → **employee_salaries** (One employee can have many salary records)
- **employees** → **attendance** (One employee can have many attendance records)
- **employees** → **performance_reviews** (One employee can have many performance reviews)

### 2. Many-to-Many Relationships
- **employees** ↔ **projects** (via employee_projects junction table)
  - Many employees can work on many projects
  - Many projects can have many employees

### 3. Self-Referencing Relationships
- **employees** → **employees** (manager_id references employee_id)
  - One employee can manage many other employees
  - One employee can have one manager

### 4. Optional Relationships
- **departments** → **employees** (manager_id - department manager)
- **projects** → **employees** (project_manager_id - project manager)
- **employee_salaries** → **employees** (approved_by - who approved the salary change)
- **performance_reviews** → **employees** (reviewer_id - who conducted the review)

## ER Diagram Visualization

```
┌─────────────────┐         ┌─────────────────┐         ┌─────────────────┐
│   departments   │         │    positions    │         │    employees    │
├─────────────────┤         ├─────────────────┤         ├─────────────────┤
│ department_id   │◄────────┤ department_id   │         │ employee_id     │
│ department_name │         │ position_id     │◄────────┤ department_id   │
│ department_code │         │ position_title  │         │ position_id     │
│ location        │         │ position_code   │         │ employee_code   │
│ manager_id      │─────────┤ min_salary      │         │ first_name      │
│ budget          │         │ max_salary      │         │ last_name       │
│ created_at      │         │ job_description │         │ email           │
│ updated_at      │         │ requirements    │         │ phone           │
└─────────────────┘         │ created_at      │         │ date_of_birth   │
                            │ updated_at      │         │ gender          │
                            └─────────────────┘         │ hire_date       │
                                                        │ manager_id      │◄──┐
                                                        │ salary          │   │
                                                        │ status          │   │
                                                        │ address         │   │
                                                        │ emergency_contact│   │
                                                        │ emergency_phone │   │
                                                        │ created_at      │   │
                                                        │ updated_at      │   │
                                                        └─────────────────┘   │
                                                                              │
                                                        ┌─────────────────┐   │
                                                        │ employee_salaries│   │
                                                        ├─────────────────┤   │
                                                        │ salary_id       │   │
                                                        │ employee_id     │◄──┼──┐
                                                        │ salary_amount   │   │  │
                                                        │ effective_date  │   │  │
                                                        │ end_date        │   │  │
                                                        │ salary_type     │   │  │
                                                        │ reason          │   │  │
                                                        │ approved_by     │◄──┼──┘
                                                        │ created_at      │   │
                                                        └─────────────────┘   │
                                                                              │
                                                        ┌─────────────────┐   │
                                                        │   attendance    │   │
                                                        ├─────────────────┤   │
                                                        │ attendance_id   │   │
                                                        │ employee_id     │◄──┘
                                                        │ date            │
                                                        │ check_in        │
                                                        │ check_out       │
                                                        │ total_hours     │
                                                        │ status          │
                                                        │ notes           │
                                                        │ created_at      │
                                                        │ updated_at      │
                                                        └─────────────────┘

┌─────────────────┐         ┌─────────────────┐         ┌─────────────────┐
│    projects     │         │ employee_projects│         │performance_reviews│
├─────────────────┤         ├─────────────────┤         ├─────────────────┤
│ project_id      │         │ assignment_id   │         │ review_id       │
│ project_name    │         │ employee_id     │◄────────┤ employee_id     │◄──┐
│ project_code    │         │ project_id      │◄────────┤ reviewer_id     │◄──┘
│ description     │         │ role            │         │ review_period_start│
│ department_id   │◄────────┤ start_date      │         │ review_period_end│
│ project_manager_id│◄──────┤ end_date        │         │ review_date     │
│ start_date      │         │ hours_allocated │         │ overall_rating  │
│ end_date        │         │ is_active       │         │ technical_skills_rating│
│ budget          │         │ created_at      │         │ communication_rating│
│ status          │         │ updated_at      │         │ teamwork_rating │
│ priority        │         └─────────────────┘         │ leadership_rating│
│ created_at      │                                    │ strengths        │
│ updated_at      │                                    │ areas_of_improvement│
└─────────────────┘                                    │ goals_for_next_period│
                                                       │ recommendations  │
                                                       │ status           │
                                                       │ created_at       │
                                                       │ updated_at       │
                                                       └─────────────────┘
```

## Key Features of the ER Design

### 1. **Normalization**
- All tables are in 3NF (Third Normal Form)
- No redundant data storage
- Proper separation of concerns

### 2. **Data Integrity**
- Primary keys ensure unique identification
- Foreign keys maintain referential integrity
- Check constraints validate data ranges
- Unique constraints prevent duplicates

### 3. **Scalability**
- Auto-incrementing primary keys
- Proper indexing for performance
- Flexible relationship structures

### 4. **Audit Trail**
- Timestamp fields for tracking changes
- Salary history tracking
- Performance review history

### 5. **Business Logic Support**
- Hierarchical employee structure
- Project assignment management
- Attendance tracking
- Performance evaluation system

## Database Constraints

### Primary Key Constraints
- All tables have unique primary keys
- Auto-increment ensures no gaps

### Foreign Key Constraints
- CASCADE DELETE for dependent records
- RESTRICT DELETE for critical relationships
- SET NULL for optional relationships

### Check Constraints
- Salary ranges validation
- Date range validations
- Rating scale validations (1.0-5.0)
- Hours validation (0-24)

### Unique Constraints
- Employee codes, email addresses
- Department codes, position codes
- Project codes
- Employee-project combinations

This ER diagram represents a comprehensive employee management system that can handle complex organizational structures, project assignments, performance tracking, and historical data analysis.
