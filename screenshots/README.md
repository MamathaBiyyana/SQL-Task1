# Screenshots Directory

This directory is for storing screenshots and visual documentation of the database.

## Recommended Screenshots to Add:

### 1. Database Creation Screenshots
- MySQL Workbench or command line showing successful database creation
- Table structure display (DESCRIBE commands)
- SHOW TABLES output

### 2. ER Diagram Screenshots
- MySQL Workbench ER diagram
- Database relationship visualization
- Table relationship diagram

### 3. Sample Query Results
- Basic SELECT query results
- Complex JOIN query results
- Aggregation query results
- Window function results

### 4. Data Validation Screenshots
- Constraint validation examples
- Foreign key relationship tests
- Check constraint demonstrations

### 5. Performance Screenshots
- Index usage demonstration
- Query execution plans
- Performance optimization results

## How to Generate Screenshots:

### Using MySQL Workbench:
1. Open MySQL Workbench
2. Connect to your MySQL server
3. Run the setup_database.sql script
4. Use the "Database" → "Reverse Engineer" feature to generate ER diagram
5. Take screenshots of the diagram and query results

### Using Command Line:
1. Connect to MySQL: `mysql -u username -p`
2. Run: `SOURCE setup_database.sql;`
3. Take screenshots of the output

### Using phpMyAdmin:
1. Import the SQL files
2. Use the "Designer" tab to view relationships
3. Take screenshots of the database structure

## File Naming Convention:
- `01_database_creation.png`
- `02_er_diagram.png`
- `03_table_structure.png`
- `04_sample_queries.png`
- `05_relationships.png`
- `06_performance_tests.png`

## Note:
The ER diagram is also documented in text format in `../er_diagram.md` for reference.
