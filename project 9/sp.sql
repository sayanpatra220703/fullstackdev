-- ==============================
-- DDL COMMANDS
-- ==============================

-- 1. CREATE
CREATE TABLE Customer (
    CustID INT PRIMARY KEY,
    CustName VARCHAR(50),
    City VARCHAR(50)
);

CREATE TABLE Employee (
    EmpID INT PRIMARY KEY,
    EmpName VARCHAR(50),
    City VARCHAR(50)
);

-- 2. ALTER (Add a column to Customer)
ALTER TABLE Customer ADD Email VARCHAR(100);

-- 3. TRUNCATE (Remove all data but keep structure)
TRUNCATE TABLE Employee;

-- 4. DROP (Delete table permanently)
-- DROP TABLE Employee;   -- (Not executing now, just demo)

-- ==============================
-- DML COMMANDS
-- ==============================

-- Insert values
INSERT INTO Customer VALUES (1, 'Ravi', 'Delhi', 'ravi@mail.com');
INSERT INTO Customer VALUES (2, 'Sita', 'Mumbai', 'sita@mail.com');
INSERT INTO Customer VALUES (3, 'Aman', 'Kolkata', 'aman@mail.com');

INSERT INTO Employee VALUES (101, 'Arjun', 'Delhi');
INSERT INTO Employee VALUES (102, 'Neha', 'Bangalore');
INSERT INTO Employee VALUES (103, 'Sita', 'Mumbai');

-- Select
SELECT * FROM Customer;
SELECT * FROM Employee;

-- Update
UPDATE Customer SET City = 'Chennai' WHERE CustID = 3;

-- Delete
DELETE FROM Employee WHERE EmpID = 103;

-- ==============================
-- DCL COMMANDS
-- ==============================

-- Grant permission (syntax depends on DBMS)
GRANT SELECT, INSERT ON Customer TO user_name;

-- Revoke permission
REVOKE INSERT ON Customer FROM user_name;

-- ==============================
-- TCL COMMANDS
-- ==============================

-- Start transaction
BEGIN;

INSERT INTO Customer VALUES (4, 'Rahul', 'Hyderabad', 'rahul@mail.com');

SAVEPOINT sp1;

INSERT INTO Customer VALUES (5, 'Priya', 'Pune', 'priya@mail.com');

-- Rollback to savepoint
ROLLBACK TO sp1;

-- Commit transaction
COMMIT;

-- ==============================
-- JOINS
-- ==============================

-- 1. INNER JOIN
SELECT C.CustID, C.CustName, E.EmpName, C.City
FROM Customer C
INNER JOIN Employee E ON C.City = E.City;

-- 2. LEFT JOIN
SELECT C.CustID, C.CustName, E.EmpName, C.City
FROM Customer C
LEFT JOIN Employee E ON C.City = E.City;

-- 3. RIGHT JOIN
SELECT C.CustID, C.CustName, E.EmpName, C.City
FROM Customer C
RIGHT JOIN Employee E ON C.City = E.City;

-- 4. FULL OUTER JOIN
SELECT C.CustID, C.CustName, E.EmpName, C.City
FROM Customer C
FULL OUTER JOIN Employee E ON C.City = E.City;

-- ==============================
-- SET OPERATIONS
-- ==============================

-- UNION (removes duplicates)
SELECT City FROM Customer
UNION
SELECT City FROM Employee;

-- UNION ALL (keeps duplicates)
SELECT City FROM Customer
UNION ALL
SELECT City FROM Employee;

-- INTERSECT (common cities)
SELECT City FROM Customer
INTERSECT
SELECT City FROM Employee;

-- MINUS / EXCEPT (cities in Customer but not in Employee)
SELECT City FROM Customer
MINUS
SELECT City FROM Employee;
