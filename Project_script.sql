DROP DATABASE  IF EXISTS Saloon_bookingManagement_System;
CREATE DATABASE Saloon_bookingManagement_System;
USE Saloon_bookingManagement_System;
CREATE TABLE customer(
	Customer_ID VARCHAR(8) NOT NULL,
    FirstName VARCHAR(20) NOT NULL,
    LastName VARCHAR(42) NOT NULL,
    Email VARCHAR(50) NOT NULL,
    Sex VARCHAR(1) NOT NULL,
    Dob DATE NOT NULL,
    Town VARCHAR(20),
    Street VARCHAR(20),
    Zip_code VARCHAR(6),
    Age INTEGER,

    PRIMARY KEY(Customer_ID)
    
);


CREATE TABLE customer_contacts (
    Customer_ID VARCHAR(8) NOT NULL,
    Contact_No VARCHAR(12) NOT NULL,
    PRIMARY KEY (Customer_ID, Contact_No),
    CONSTRAINT FK_CstmID
    FOREIGN KEY (Customer_ID) REFERENCES customer (Customer_ID)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);


CREATE TABLE appoiment(
	Customer_ID VARCHAR(8) NOT NULL PRIMARY KEY,
    Date DATE NOT NULL,
    Status VARCHAR(20) NOT NULL,
    Time TIME NOT NULL,
	CONSTRAINT FK_CstmID_ap
    FOREIGN KEY (Customer_ID) REFERENCES customer (Customer_ID)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);


CREATE TABLE branch(
	Branch_Id VARCHAR(8) NOT NULL,
    Name VARCHAR(20) NOT NULL,
    Location VARCHAR(20) NOT NULL,
    Contact VARCHAR(12) NOT NULL,
    PRIMARY KEY (Branch_ID)
);

CREATE TABLE product(
	Product_ID VARCHAR(8) NOT NULL,
    Name VARCHAR(20) NOT NULL,
    Price DECIMAL(7,2),
    Exp_date DATE NOT NULL,
    PRIMARY KEY (Product_ID)
);

CREATE TABLE service(
	Service_ID VARCHAR(8) NOT NULL,
    Name VARCHAR(20) NOT NULL,
    PRIMARY KEY(Service_ID)
    
);

CREATE TABLE package(
	Pac_Id VARCHAR(8) NOT NULL PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    Price DECIMAL(8,2),
    Description VARCHAR(200) ,
    Service_ID VARCHAR(8) NOT NULL,
    CONSTRAINT FK_SvcID
    FOREIGN KEY (Service_ID) REFERENCES service (Service_ID)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE  bill (
	Bill_ID VARCHAR(8) NOT NULL,
    Issue_Date DATE NOT NULL,
    Due_Date DATE NOT NULL,
    Amount DECIMAL(8,2) ,
    PRIMARY KEY (Bill_ID)
);


CREATE TABLE employee(
	Emp_ID VARCHAR(8) NOT NULL PRIMARY KEY,
	FirstName VARCHAR(20) NOT NULL,
    LastName VARCHAR(40) NOT NULL,
    Supervise_ID VARCHAR(8) ,
    Branch_Id VARCHAR(8) NOT NULL,
    CONSTRAINT FK_BrID
    FOREIGN KEY (Branch_Id) REFERENCES branch(Branch_ID)
    ON DELETE CASCADE
    ON UPDATE CASCADE
    
);


ALTER TABLE employee
ADD CONSTRAINT FK_Supervisor
FOREIGN KEY (Supervise_ID) REFERENCES employee(Emp_ID)
ON DELETE CASCADE
ON UPDATE CASCADE;

CREATE TABLE employee_contacts(
	Emp_ID VARCHAR(8) NOT NULL,
    Contact VARCHAR(12) NOT NULL,
	CONSTRAINT FK_Emp_ID
    FOREIGN KEY (Emp_ID) REFERENCES employee(Emp_ID)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    PRIMARY KEY(Emp_ID,Contact)
    
    
);
CREATE TABLE payment(
	Bill_ID VARCHAR(8) NOT NULL PRIMARY KEY,
    Method_Name VARCHAR(20) NOT NULL,
    Expiration_Date DATE NOT NULL,
    Account_NO VARCHAR(20) ,
    Data DATE NOT NULL,
    CONSTRAINT FK_Bill_ID
    FOREIGN KEY (Bill_ID) REFERENCES bill(Bill_ID)
    ON DELETE CASCADE
    ON UPDATE CASCADE

);
 CREATE TABLE Customer_Branches(
	Customer_ID VARCHAR(8) NOT NULL,
    Branch_Id VARCHAR(8) NOT NULL,
    CONSTRAINT FK_CutomerB_ID
    FOREIGN KEY (Customer_Id) REFERENCES customer(Customer_Id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    CONSTRAINT FK_Bill_Br_ID
    FOREIGN KEY (Branch_ID) REFERENCES branch(Branch_ID)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    PRIMARY KEY(Customer_ID,Branch_ID)

 );

  CREATE TABLE branch_products(
	
    Branch_Id VARCHAR(8) NOT NULL,
    Product_Id VARCHAR(8) NOT NULL,
    Qnt INTEGER DEFAULT 0,
    CONSTRAINT FK_ProductBp_ID
    FOREIGN KEY (Product_ID) REFERENCES product(Product_ID)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    CONSTRAINT FK_Bill_Bp_ID
    FOREIGN KEY (Branch_ID) REFERENCES branch(Branch_ID)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    PRIMARY KEY(Branch_ID,Product_ID)

 );
 
   CREATE TABLE branch_services(
    Branch_ID VARCHAR(8) NOT NULL,
    Service_ID VARCHAR(8) NOT NULL,
    CONSTRAINT FK_ServiceBs_ID
    FOREIGN KEY (Service_ID) REFERENCES service(Service_ID)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    CONSTRAINT FK_BillBs_ID
    FOREIGN KEY (Branch_ID) REFERENCES branch(Branch_ID)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    PRIMARY KEY(Branch_ID,Service_ID)

 );
 
   CREATE TABLE product_packages(
    Product_ID VARCHAR(8) NOT NULL,
    Package_ID VARCHAR(8) NOT NULL,
	Qnt INTEGER DEFAULT 0,
    CONSTRAINT FK_ProductPp_ID
    FOREIGN KEY (Product_ID) REFERENCES product(Product_ID)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    CONSTRAINT FK_PackagePp_ID
    FOREIGN KEY (Package_ID) REFERENCES package(Pac_ID)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    PRIMARY KEY(Product_ID,Package_ID)

 );

   CREATE TABLE packages_Bills(
    Package_ID VARCHAR(8) NOT NULL,
    Bill_ID VARCHAR(8) NOT NULL,
    CONSTRAINT FK_BillPabi_ID
    FOREIGN KEY (Bill_ID) REFERENCES bill(Bill_ID)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    CONSTRAINT FK_PackagePbi_ID
    FOREIGN KEY (Package_ID) REFERENCES package(Pac_ID)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    PRIMARY KEY(Package_ID,Bill_ID)

 );
    CREATE TABLE Products_Bills(
    Package_ID VARCHAR(8) NOT NULL,
    Bill_ID VARCHAR(8) NOT NULL,
    CONSTRAINT FK_BillPbi_ID
    FOREIGN KEY (Bill_ID) REFERENCES bill(Bill_ID)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    CONSTRAINT FK_PackagePabi_ID
    FOREIGN KEY (Package_ID) REFERENCES package(Pac_ID)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    PRIMARY KEY(Package_ID,Bill_ID)

 );
CREATE TABLE customer_services (
    Customer_ID VARCHAR(8) NOT NULL,
    Service_ID VARCHAR(8) NOT NULL,
    CONSTRAINT FK_CstmCs_ID
    FOREIGN KEY (Customer_ID) REFERENCES customer (Customer_ID)
    ON DELETE CASCADE
    ON UPDATE CASCADE,  
    CONSTRAINT FK_ServiceCs_ID
    FOREIGN KEY (Service_ID) REFERENCES service(Service_ID)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    PRIMARY KEY (Customer_ID, Service_ID)
);

CREATE TABLE employee_services (
    Emp_ID VARCHAR(8) NOT NULL,
    Service_ID VARCHAR(8) NOT NULL,
    CONSTRAINT FK_EmpEs_ID
    FOREIGN KEY (Emp_ID) REFERENCES employee (Emp_ID)
    ON DELETE CASCADE
    ON UPDATE CASCADE,  
    CONSTRAINT FK_ServiceEs_ID
    FOREIGN KEY (Service_ID) REFERENCES service(Service_ID)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    PRIMARY KEY (Emp_ID, Service_ID)
);


-- ###############################################################

--  CUSTOMER TABLE
INSERT INTO customer (Customer_ID, FirstName, LastName, Email, Sex, Dob, Town, Street, Zip_code)
VALUES
    ('CUST001', 'John', 'Doe', 'john@gamil.com', 'M', '1990-01-15', 'Colombo', 'Galle Road', '00100'),
    ('CUST002', 'Jane', 'Smith', 'jane@gamil.com', 'F', '1985-05-20', 'Kandy', 'Main Street', '20000'),
    ('CUST003', 'Alice', 'Johnson', 'alice@gamil.com', 'F', '1995-08-10', 'Jaffna', 'Beach Road', '40050'),
    ('CUST004', 'Bob', 'Wilson', 'bob@vgamil.com', 'M', '1980-03-05', 'Galle', 'Harbor Street', '80030'),
    ('CUST005', 'Charlie', 'Brown', 'charlie@gamil.com', 'M', '1992-11-25', 'Matara', 'Market Street', '90040'),
    ('CUST006', 'Eva', 'Davis', 'eva@gamil.com', 'F', '1998-09-14', 'Nuwara Eliya', 'Hill Road', '60060'),
    ('CUST007', 'Even', 'Davis', 'eva@gamil.com', 'F', '1998-09-14', 'Nuwara Eliya', 'Hill Road', '60060');

-- Update 2 rows in the "customer" table (for example, updating emails)
UPDATE customer
SET Email = 'newemail1@gamil.com'
WHERE Customer_ID = 'CUST001';

UPDATE customer
SET Email = 'newemail2@gamil.com'
WHERE Customer_ID = 'CUST002';

-- Delete 1 row from the "customer" table (for example, deleting the last customer)
DELETE FROM customer
WHERE Customer_ID = 'CUST007';

select *from customer;
-- Insert data into the "employee" table
-- Insert data into the "branch" table
INSERT INTO branch (Branch_Id, Name, Location, Contact)
VALUES
    ('BR001', 'Main Salon', 'Colombo 03', '011-1234567'),
    ('BR002', 'Downtown Salon', 'Kandy', '081-7654321'),
    ('BR003', 'Beach Salon', 'Galle', '091-9876543'),
    ('BR004', 'City Salon', 'Colombo 07', '011-9876543'),
    ('BR005', 'Hill Salon', 'Nuwara Eliya', '052-1234567'),
    ('BR006', 'East Salon', 'Trincomalee', '026-7654321');

-- Update 2 rows in the "branch" table (for example, updating contact numbers)
UPDATE branch
SET Contact = '011-1111111'
WHERE Branch_Id = 'BR001';

UPDATE branch
SET Contact = '081-9999999'
WHERE Branch_Id = 'BR002';

-- Delete 1 row from the "branch" table (for example, deleting the last branch)
DELETE FROM branch
WHERE Branch_Id = 'BR006';

SELECT * FROM BRANCH;

-- ################################################
-- Insert data into the "product" table
INSERT INTO product (Product_ID, Name, Price, Exp_date)
VALUES
    ('PROD001', 'Shampoo', 10.99, '2024-12-31'),
    ('PROD002', 'Conditioner', 8.49, '2024-12-31'),
    ('PROD003', 'Hair Gel', 5.99, '2023-06-30'),
    ('PROD004', 'Body Lotion', 12.99, '2024-12-31'),
    ('PROD005', 'Face Wash', 6.99, '2024-12-31'),
    ('PROD006', 'Sunscreen', 9.99, '2024-12-31');

-- Update 2 rows in the "product" table (for example, updating prices)
UPDATE product
SET Price = 11.99
WHERE Product_ID = 'PROD001';

UPDATE product
SET Price = 9.99
WHERE Product_ID = 'PROD002';

-- Delete 1 row from the "product" table (for example, deleting the last product)
DELETE FROM product
WHERE Product_ID = 'PROD006';

SELECT * FROM PRODUCT;

-- ######################################
-- Insert data into the "service" table
INSERT INTO service (Service_ID, Name)
VALUES
    ('SERV001', 'Haircut'),
    ('SERV002', 'Manicure'),
    ('SERV003', 'Pedicure'),
    ('SERV004', 'Spa Treatment'),
    ('SERV005', 'Facial'),
    ('SERV006', 'Massage');

-- Update 2 rows in the "service" table (for example, updating service names)
UPDATE service
SET Name = 'Hair Styling'
WHERE Service_ID = 'SERV001';

UPDATE service
SET Name = 'Nail
wallpaper Art'
WHERE Service_ID = 'SERV002';

-- Delete 1 row from the "service" table (for example, deleting the last service)
DELETE FROM service
WHERE Service_ID = 'SERV006';


-- ######################################33
-- EMPLOYEE
-- Insert data into the "employee" table
INSERT INTO employee (Emp_ID, FirstName, LastName, Supervise_ID, Branch_Id)
VALUES
    ('EMP001', 'David', 'Anderson', NULL, 'BR001'),
    ('EMP002', 'Sarah', 'Clark', 'EMP001', 'BR002'),
    ('EMP003', 'Michael', 'Smith', NULL, 'BR001'),
    ('EMP004', 'Lisa', 'Wilson', 'EMP001', 'BR003'),
    ('EMP005', 'Emily', 'Brown', 'EMP001', 'BR002'),
    ('EMP006', 'Robert', 'Johnson', 'EMP001', 'BR001');

-- Update 2 rows in the "employee" table (for example, updating supervisor)
UPDATE employee
SET Supervise_ID = 'EMP003'
WHERE Emp_ID = 'EMP001';

UPDATE employee
SET Supervise_ID = 'EMP004'
WHERE Emp_ID = 'EMP002';

-- Delete 1 row from the "employee" table (for example, deleting the last employee)
DELETE FROM employee
WHERE Emp_ID = 'EMP006';

SELECT * FROM EMPLOYEE;

-- ###################################################
-- Insert data into the "appointment" table
INSERT INTO appoiment (Customer_ID, Date, Status, Time)
VALUES
    ('CUST001', '2023-09-15', 'Scheduled', '10:00:00'),
    ('CUST002', '2023-09-16', 'Scheduled', '14:30:00'),
    ('CUST003', '2023-09-17', 'Cancelled', '16:00:00'),
    ('CUST004', '2023-09-18', 'Scheduled', '11:15:00'),
    ('CUST005', '2023-09-19', 'Completed', '13:45:00'),
    ('CUST006', '2023-09-20', 'Scheduled', '15:30:00');

-- Update 2 rows in the "appointment" table (for example, updating appointment status)
UPDATE appoiment
SET Status = 'Rescheduled'
WHERE Customer_ID = 'CUST001';

UPDATE appoiment
SET Status = 'Cancelled'
WHERE Customer_ID = 'CUST003';

-- Delete 1 row from the "appointment" table (for example, deleting the last appointment)
DELETE FROM appoiment
WHERE Customer_ID = 'CUST006';



-- ###################################
-- Insert data into the "customer_contacts" table
INSERT INTO customer_contacts (Customer_ID, Contact_No)
VALUES
    ('CUST001', '011-1234567'),
    ('CUST002', '081-7654321'),
    ('CUST003', '091-9876543'),
    ('CUST004', '011-9876543'),
    ('CUST005', '052-1234567'),
    ('CUST006', '026-7654321');

-- Update 2 rows in the "customer_contacts" table (for example, updating contact numbers)
UPDATE customer_contacts
SET Contact_No = '011-1111111'
WHERE Customer_ID = 'CUST001';

UPDATE customer_contacts
SET Contact_No = '081-9999999'
WHERE Customer_ID = 'CUST002';

-- Delete 1 row from the "customer_contacts" table (for example, deleting the last contact)
DELETE FROM customer_contacts
WHERE Customer_ID = 'CUST006';

-- ##############################
-- Insert data into the "package" table
INSERT INTO package (Pac_Id, Name, Price, Description, Service_ID)
VALUES
    ('PAC001', 'Relaxation Package', 100.00, 'Includes massage and facial', 'SERV001'),
    ('PAC002', 'Pampering Package', 150.00, 'Includes manicure, pedicure, and facial', 'SERV002'),
    ('PAC003', 'Spa Retreat Package', 200.00, 'Full spa day with treatments', 'SERV004'),
    ('PAC004', 'Hair and Makeup Package', 80.00, 'Includes haircut and makeup', 'SERV001'),
    ('PAC005', 'Grooming Package', 75.00, 'Includes haircut and beard trim', 'SERV001'),
    ('PAC006', 'Nail Art Package', 60.00, 'Includes manicure with nail art', 'SERV002');

-- Update 2 rows in the "package" table (for example, updating package prices)
UPDATE package
SET Price = 110.00
WHERE Pac_Id = 'PAC001';

UPDATE package
SET Price = 160.00
WHERE Pac_Id = 'PAC002';

-- Delete 1 row from the "package" table (for example, deleting the last package)
DELETE FROM package
WHERE Pac_Id = 'PAC006';

-- ##################################
-- Insert data into the "bill" table
INSERT INTO bill (Bill_ID, Issue_Date, Due_Date, Amount)
VALUES
    ('BILL001', '2023-09-01', '2023-09-15', 150.00),
    ('BILL002', '2023-09-02', '2023-09-16', 200.00),
    ('BILL003', '2023-09-03', '2023-09-17', 120.00),
    ('BILL004', '2023-09-02', '2023-09-18', 90.00),
    ('BILL005', '2023-09-02', '2023-09-19', 180.00),
    ('BILL006', '2023-09-02', '2023-09-20', 210.00);

-- Update 2 rows in the "bill" table (for example, updating bill amounts)
UPDATE bill
SET Amount = 160.00
WHERE Bill_ID = 'BILL003';

UPDATE bill
SET Amount = 220.00
WHERE Bill_ID = 'BILL004';

-- Delete 1 row from the "bill" table (for example, deleting the last bill)
DELETE FROM bill
WHERE Bill_ID = 'BILL006';


-- ###############################
-- Insert data into the "Products_Bills" table
INSERT INTO Products_Bills (Package_ID, Bill_ID)
VALUES
    ('PAC001', 'BILL001'),
    ('PAC002', 'BILL002'),
    ('PAC003', 'BILL003'),
    ('PAC004', 'BILL004'),
    ('PAC005', 'BILL005')
    ;

-- Update 2 rows in the "Products_Bills" table (for example, updating package IDs)
UPDATE Products_Bills
SET Package_ID = 'PAC004'
WHERE Bill_ID = 'BILL001';

UPDATE Products_Bills
SET Package_ID = 'PAC003'
WHERE Bill_ID = 'BILL002';

-- Delete 1 row from the "Products_Bills" table (for example, deleting the last record)
DELETE FROM Products_Bills
WHERE Bill_ID = 'BILL005';

-- #####################################
-- Insert data into the "employee_contacts" table
INSERT INTO employee_contacts (Emp_ID, Contact)
VALUES
    ('EMP001', '011-1234567'),
    ('EMP002', '081-7654321'),
    ('EMP003', '091-9876543'),
    ('EMP004', '011-9876543'),
    ('EMP005', '052-1234567'),
    ('EMP001', '026-7654321');

-- Update 2 rows in the "employee_contacts" table (for example, updating contact numbers)
UPDATE employee_contacts
SET Contact = '011-1101111'
WHERE Emp_ID = 'EMP001' AND  Contact = '011-1234567';

UPDATE employee_contacts
SET Contact = '081-9999999'
WHERE Emp_ID = 'EMP002';

-- Delete 1 row from the "employee_contacts" table (for example, deleting the last contact)
DELETE FROM employee_contacts
WHERE Emp_ID = 'EMP005';

-- ################################

-- Insert data into the "payment" table
INSERT INTO payment (Bill_ID, Method_Name, Expiration_Date, Account_NO, Data)
VALUES
    ('BILL001', 'Credit Card', '2023-10-31', 1234567890, '2023-09-05'),
    ('BILL002', 'PayPal', '2023-10-30', 9876543210, '2023-09-06'),
    ('BILL003', 'Cash', '2023-10-29', NULL, '2023-09-07'),
    ('BILL004', 'Debit Card', '2023-10-28', 5678901234, '2023-09-08'),
    ('BILL005', 'Bank Transfer', '2023-10-27', 6543210987, '2023-09-09');
   
-- Update 2 rows in the "payment" table (for example, updating payment methods)
UPDATE payment
SET Method_Name = 'Online Wallet'
WHERE Bill_ID = 'BILL001';

UPDATE payment
SET Method_Name = 'Cash'
WHERE Bill_ID = 'BILL002';

-- Delete 1 row from the "payment" table (for example, deleting the last payment)
DELETE FROM payment
WHERE Bill_ID = 'BILL005';

-- #####################################
-- Insert data into the "Customer_Branches" table
INSERT INTO Customer_Branches (Customer_ID, Branch_Id)
VALUES
    ('CUST001', 'BR001'),
    ('CUST002', 'BR002'),
    ('CUST003', 'BR003'),
    ('CUST004', 'BR001'),
    ('CUST005', 'BR002'),
    ('CUST005', 'BR003');

-- Update 2 rows in the "Customer_Branches" table (for example, updating branch associations)
UPDATE Customer_Branches
SET Branch_Id = 'BR002'
WHERE Customer_ID = 'CUST004';

UPDATE Customer_Branches
SET Branch_Id = 'BR003'
WHERE Customer_ID = 'CUST002';

-- Delete 1 row from the "Customer_Branches" table (for example, deleting the last association)
DELETE FROM Customer_Branches
WHERE Customer_ID = 'CUST005';

-- #################################
-- Insert data into the "branch_products" table
INSERT INTO branch_products (Branch_Id, Product_Id, Qnt)
VALUES
    ('BR001', 'PROD001', 10),
    ('BR002', 'PROD002', 15),
    ('BR003', 'PROD003', 20),
    ('BR001', 'PROD004', 8),
    ('BR002', 'PROD005', 12),
    ('BR003', 'PROD001', 18);

-- Update 2 rows in the "branch_products" table (for example, updating product quantities)
UPDATE branch_products
SET Qnt = 12
WHERE Product_Id = 'PROD001';

UPDATE branch_products
SET Qnt = 10
WHERE Product_Id = 'PROD002';

-- Delete 1 row from the "branch_products" table (for example, deleting the last product)
DELETE FROM branch_products
WHERE Product_Id = 'PRODUCT006';

-- #########################################3
-- Insert data into the "branch_services" table
INSERT INTO branch_services (Branch_ID, Service_ID)
VALUES
    ('BR001', 'SERV001'),
    ('BR002', 'SERV002'),
    ('BR003', 'SERV003'),
    ('BR001', 'SERV004'),
    ('BR002', 'SERV005'),
    ('BR003', 'SERV002');

-- Update 2 rows in the "branch_services" table (for example, updating service associations)
UPDATE branch_services
SET Service_ID = 'SERV005'
WHERE Branch_ID = 'BR001' AND Service_ID ="SERV001";

UPDATE branch_services
SET Service_ID = 'SERV004'
WHERE Branch_ID = 'BR002' AND Service_ID ="SERV002";

-- Delete 1 row from the "branch_services" table (for example, deleting the last association)
DELETE FROM branch_services
WHERE Branch_ID = 'BR003';

-- #############################
-- Insert data into the "product_packages" table
INSERT INTO product_packages (Product_ID, Package_ID, Qnt)
VALUES
    ('PROD001', 'PAC001', 5),
    ('PROD002', 'PAC002', 8),
    ('PROD003', 'PAC003', 10),
    ('PROD004', 'PAC004', 6),
    ('PROD005', 'PAC005', 7),
    ('PROD003', 'PAC002', 4);

-- Update 2 rows in the "product_packages" table (for example, updating product quantities)
UPDATE product_packages
SET Qnt = 7
WHERE Product_ID = 'PRODUCT001';

UPDATE product_packages
SET Qnt = 9
WHERE Product_ID = 'PRODUCT002';

-- Delete 1 row from the "product_packages" table (for example, deleting the last association)
DELETE FROM product_packages
WHERE Product_ID = 'PRODUCT006';

-- ######################################
-- Insert data into the "packages_Bills" table
INSERT INTO packages_Bills (Package_ID, Bill_ID)
VALUES
    ('PAC001', 'BILL001'),
    ('PAC002', 'BILL002'),
    ('PAC003', 'BILL003'),
    ('PAC003', 'BILL004'),
    ('PAC004', 'BILL004'),
    ('PAC005', 'BILL004');

-- Update 2 rows in the "packages_Bills" table (for example, updating package associations)
UPDATE packages_Bills
SET Bill_ID = 'BILL005'
WHERE Package_ID = 'PAC001';

UPDATE packages_Bills
SET Bill_ID = 'BILL004'
WHERE Package_ID = 'PAC002';

-- Delete 1 row from the "packages_Bills" table (for example, deleting the last association)
DELETE FROM packages_Bills
WHERE Package_ID = 'PAC006';


-- ###########################################
-- Insert data into the "employee_services" table
INSERT INTO employee_services (Emp_ID, Service_ID)
VALUES
    ('EMP001', 'SERV001'),
    ('EMP002', 'SERV002'),
    ('EMP003', 'SERV003'),
    ('EMP004', 'SERV004'),
    ('EMP005', 'SERV005'),
    ('EMP005', 'SERV001');

-- Update 2 rows in the "employee_services" table (for example, updating service associations)
UPDATE employee_services
SET Service_ID = 'SERV005'
WHERE Emp_ID = 'EMP001';

UPDATE employee_services
SET Service_ID = 'SERV004'
WHERE Emp_ID = 'EMP002';

-- Delete 1 row from the "employee_services" table (for example, deleting the last association)
DELETE FROM employee_services
WHERE Emp_ID = 'EMP004';

-- ###########################################
-- Insert data into the "customer_services" table
INSERT INTO customer_services (Customer_ID, Service_ID)
VALUES
    ('CUST001', 'SERV001'),
    ('CUST002', 'SERV002'),
    ('CUST003', 'SERV003'),
    ('CUST004', 'SERV004'),
    ('CUST005', 'SERV005'),
    ('CUST003', 'SERV001');

-- Update 2 rows in the "customer_services" table (for example, updating service associations)
UPDATE customer_services
SET Service_ID = 'SERV005'
WHERE Customer_ID = 'CUST001';

UPDATE customer_services
SET Service_ID = 'SERV004'
WHERE Customer_ID = 'CUST002';

-- Delete 1 row from the "customer_services" table (for example, deleting the last association)
DELETE FROM customer_services
WHERE Customer_ID = 'CUST005';


/*
##############################################################################
##############################################################################
##############################################################################*/
-- QUERIES
-- Select operation 
SELECT * FROM employee WHERE Supervise_Id ="EMP001";
-- Project operation
SELECT FirstName,Branch_ID  FROM employee;
-- Cartesian product operation
SELECT *
FROM product
CROSS JOIN service;
-- Creating a user view
CREATE   VIEW CutomerNamesView AS SELECT FirstName,LastName FROM customer;
SELECT * FROM CutomerNamesView;
-- Rename operation
RENAME TABLE customer TO Saloon_customers;
-- Demonstrating the use of an aggregation function (MAX function)
SELECT * FROM bill WHERE Amount = (SELECT MAX(Amount) FROM bill);
-- Demonstrating the use of LIKE keyword
SELECT * FROM saloon_customers WHERE email LIKE "%@gamil.com";


-- COMPLEX QUERIES

-- Union
SELECT ProductOrService
FROM (
    (SELECT Name AS ProductOrService, 'Product' AS ItemType
    FROM product)
    UNION ALL
   ( SELECT Name AS ProductOrService, 'Service' AS ItemType
    FROM service)
) AS CombinedItems
ORDER BY ProductOrService;

-- INTERSECTION

 /*SELECT *FROM bill WHERE Amount> 180
INTERSECT
SELECT * FROM bill WHERE Issue_Date = '2023-09-02';*/

-- SET DIFFERENCE OPERATION

(SELECT Name, Exp_date FROM product)
EXCEPT
(SELECT Name, Exp_date FROM product WHERE Price > 10.00);

-- Division operation

SELECT c.Customer_ID, c.FirstName, c.LastName
FROM saloon_customers c
WHERE NOT EXISTS (
    SELECT s.Service_ID
    FROM service s
    WHERE NOT EXISTS (
        SELECT 1
        FROM appoiment a
        WHERE a.Customer_ID = c.Customer_ID
    )
);

-- Inner join operation

CREATE VIEW AllCustomers AS
SELECT *
FROM saloon_customers;


CREATE VIEW CustomerAppoinments AS
SELECT *
FROM Appoiment
WHERE Time = '10:00:00';

SELECT *
FROM AllCustomers AS sc
INNER JOIN CustomerAppoinments AS ca
ON sc.Customer_ID = ca.Customer_ID;


-- Natural join operation

CREATE VIEW employeeName01 AS
SELECT *
FROM employee AS e
WHERE e.FirstName = 'David';

CREATE VIEW EmployeesWithServices005 AS
SELECT *
FROM employee_services AS es
WHERE es.Service_ID = 'SERV005';

SELECT *
FROM employeeName01 AS c
NATURAL JOIN EmployeesWithServices005 AS e;


-- LEFT OUTER JOIN

CREATE VIEW EmployeeView AS
SELECT *
FROM employee;

CREATE VIEW BranchView AS
SELECT *
FROM Branch;

SELECT *
FROM EmployeeView AS e
LEFT JOIN BranchView AS b
ON b.Branch_ID = e.Branch_ID
WHERE e.LastName = 'Clark';


-- RIGHT OUTER JOIN
CREATE VIEW ProductshampooView AS
SELECT *
FROM product
WHERE Name ='shampoo';

CREATE VIEW BranchProductView AS
SELECT *
FROM branch_products;

SELECT p.Product_ID, p.Name AS ProductName, bp.Branch_ID AS BranchId
FROM ProductshampooView AS p
RIGHT JOIN BranchProductView AS bp ON p.Product_ID = bp.Product_Id;


-- FULL OUTER JOIN
CREATE VIEW SaloonCustomersView AS
SELECT *
FROM saloon_customers;

CREATE VIEW CustomerBranchesView AS
SELECT *
FROM Customer_Branches;

SELECT a.Customer_ID, a.FirstName, a.LastName, b.Branch_Id
FROM SaloonCustomersView AS a
LEFT JOIN CustomerBranchesView AS b ON a.Customer_ID = b.Customer_ID
UNION
SELECT b.Customer_ID, a.FirstName, a.LastName, b.Branch_Id
FROM CustomerBranchesView AS b
RIGHT JOIN SaloonCustomersView AS a ON a.Customer_ID = b.Customer_ID;


-- OUTER UNION
CREATE VIEW kandyBranchs AS 
SELECT* FROM branch
WHERE Name ="Kandy";

CREATE VIEW BranchServices2 AS 
SELECT* FROM branch_services
WHERE Service_ID ="SERV004";

SELECT Branch_ID 
FROM BranchServices2
UNION
SELECT Branch_ID 
FROM kandyBranchs;





-- NESTED 01
SELECT b.Name,b.contact FROM branch AS b
INNER JOIN branch_products AS bp
ON b.branch_Id= bp.branch_Id
WHERE bp.Qnt > 7

UNION

SELECT b.Name,b.contact FROM branch AS b
INNER JOIN Customer_Branches AS cb
ON b.Branch_ID = cb.Branch_ID
WHERE cb.Customer_ID = 'CUST002';

-- NESTED 02
SELECT b.bill_Id,b.Amount AS Price FROM bill AS b
NATURAL JOIN products_bills AS pb
NATURAL JOIN payment AS p
WHERE p.Method_Name = 'cash';

-- NESTED 03

SELECT * FROM saloon_customers AS sc
NATURAL JOIN
appoiment AS a
WHERE a.status ='Scheduled'
OR sc.customer_ID =
(SELECT customer_ID FROM customer_branches AS cb
WHERE cb.branch_Id ='BR002');





SELECT * FROM customer_services;
SELECT * FROM employee_services;
SELECT * FROM packages_Bills;
SELECT * FROM product_packages;
SELECT * FROM branch_services;
SELECT * FROM branch_products;
SELECT * FROM Customer_Branches;
SELECT * FROM payment;
SELECT * FROM employee_contacts;
SELECT * FROM employee;
SELECT * FROM Products_bills;
SELECT * FROM bill;
SELECT * FROM package;
SELECT * FROM service;
SELECT * FROM product;
SELECT * FROM appoiment;
SELECT * FROM customer_contacts;
SELECT * FROM Saloon_customers;
SELECT * FROM branch;



/*USE Saloon_bookingManagement_System;
DROP VIEW CutomerNamesView;
DROP VIEW AllCustomers;
DROP VIEW  CustomersWithService004;
DROP VIEW  EmployeesWithService004;
DROP VIEW  EmployeeView;
DROP VIEW  ProductView;
DROP VIEW BranchProductView;
DROP VIEW  SaloonCustomersView;
DROP VIEW BranchView;
DROP VIEW Branch03CustomersView;
DROP VIEW Service04CustomersView;

DROP TABLE customer_services;
DROP TABLE employee_services;
DROP TABLE packages_Bills;
DROP TABLE product_packages;
DROP TABLE branch_services;
DROP TABLE branch_products;
DROP TABLE Customer_Branches;
DROP TABLE payment;
DROP TABLE employee_contacts;
DROP TABLE employee;
DROP TABLE Products_bills;
DROP TABLE bill;
DROP TABLE package;
DROP TABLE service;
DROP TABLE product;
DROP TABLE appoiment;
DROP TABLE customer_contacts;
DROP TABLE Saloon_customers;
DROP TABLE branch;
*/
