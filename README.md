# SQL Internship Task - Employee Management Database

## Project Overview
This project demonstrates the creation of a comprehensive employee management database system using MySQL. The database includes multiple tables with proper relationships, primary keys, and foreign keys to manage employee data in a company.

## Objectives
- Learn to create databases, tables, and define relationships
- Implement proper database normalization
- Use primary and foreign keys for data integrity
- Generate ER diagrams to visualize database structure

## Project Structure
```
SQL Internship/
├── README.md                 # This file - project documentation
├── database_schema.sql       # Complete SQL script to create the database
├── sample_data.sql          # Sample data insertion scripts
├── queries_examples.sql     # Example queries to test the database
├── er_diagram.md            # ER diagram description and visualization
├── screenshots/             # Database screenshots and ER diagram
└── datasets/                # Sample datasets used in the project
```

## Database Schema

### Tables Created:
1. **departments** - Company departments
2. **positions** - Job positions/titles
3. **employees** - Employee information
4. **employee_salaries** - Salary history
5. **projects** - Company projects
6. **employee_projects** - Many-to-many relationship between employees and projects
7. **attendance** - Employee attendance records
8. **performance_reviews** - Employee performance evaluations

### Key Features:
- **Primary Keys**: Unique identifiers for each table
- **Foreign Keys**: Proper relationships between tables
- **Constraints**: Data integrity constraints (NOT NULL, UNIQUE, etc.)
- **Indexes**: Performance optimization for frequently queried columns
- **Triggers**: Automatic updates for audit trails

## Relationships:
- One-to-Many: Department → Employees, Position → Employees
- Many-to-Many: Employees ↔ Projects (via employee_projects table)
- One-to-Many: Employee → Salaries, Employee → Attendance, Employee → Performance Reviews

## How to Use

### 1. Database Setup
```sql
-- Run the complete schema
source database_schema.sql

-- Insert sample data
source sample_data.sql
```

### 2. Test Queries
```sql
-- Run example queries
source queries_examples.sql
```

### 3. View ER Diagram
- Check the `er_diagram.md` file for the visual representation
- Screenshots are available in the `screenshots/` directory

## Technologies Used
- **Database**: MySQL 8.0+
- **ER Diagram**: Generated using MySQL Workbench
- **Documentation**: Markdown
- **Sample Data**: Realistic employee data for testing

## Learning Outcomes
- Database design principles
- SQL DDL (Data Definition Language)
- Relationship modeling
- Data integrity constraints
- Performance optimization with indexes
- Audit trail implementation

## Screenshots
- Database creation and table structure
- ER diagram visualization
- Sample query results
- Data relationships demonstration

## Author
SQL Internship Participant
