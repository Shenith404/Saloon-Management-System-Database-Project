-- #### 
-- TUINING OPERATIONS 

-- SET DIFFERENCE OPERATION
SHOW INDEX FROM Bill;
EXPLAIN  (SELECT *FROM bill WHERE Amount> 180 INTERSECT SELECT * FROM bill WHERE Issue_Date = '2023-09-02');
CREATE INDEX idx_bill_issueDate ON Bill(Issue_Date);
SHOW INDEX FROM Bill;
EXPLAIN  (SELECT *FROM bill WHERE Amount> 180 INTERSECT SELECT * FROM bill WHERE Issue_Date = '2023-09-02');



-- nested02
 Explain SELECT b.bill_Id,b.Amount AS Price FROM bill AS b NATURAL JOIN products_bills AS pb NATURAL JOIN payment AS p WHERE p.Method_Name = 'cash';
CREATE INDEX idx_MethName ON payment(Method_Name);
 Explain SELECT b.bill_Id,b.Amount AS Price FROM bill AS b NATURAL JOIN products_bills AS pb NATURAL JOIN payment AS p WHERE p.Method_Name = 'cash';
 
 -- innner join
  EXPLAIN  (SELECT *FROM AllCustomers AS sc INNER JOIN CustomerAppoinments AS ca ON sc.Customer_ID = ca.Customer_ID);
  CREATE INDEX id_appTime ON appoiment(Time);
EXPLAIN (SELECT *FROM AllCustomers AS sc INNER JOIN CustomerAppoinments AS ca ON sc.Customer_ID = ca.Customer_ID);

-- natural join 01
EXPLAIN SELECT *FROM employeeName01 AS cNATURAL JOIN EmployeesWithServices005 AS e;
CREATE INDEX idx_EmpFname ON employee(FirstName);
EXPLAIN SELECT *FROM employeeName01 AS cNATURAL JOIN EmployeesWithServices005 AS e;

-- left outer
EXPLAIN SELECT *FROM EmployeeView AS e LEFT JOIN BranchView AS b ON b.Branch_ID = e.Branch_ID WHERE e.LastName = 'Clark';
CREATE INDEX id_EmpLname ON employee(LastName);
EXPLAIN SELECT *FROM EmployeeView AS e LEFT JOIN BranchView AS b ON b.Branch_ID = e.Branch_ID WHERE e.LastName = 'Clark';

-- right outer join 
 EXPLAIN p.Product_ID, p.Name AS ProductName, bp.Branch_ID AS BranchId FROM ProductView AS p RIGHT JOIN BranchProductView AS bp ON p.Product_ID = bp.Product_Id;
 CREATE INDEX id_ProductEDate ON product(Exp_Date);
 
 -- outer union 
 EXPLAIN SELECT Branch_ID FROM BranchServices2 UNION SELECT Branch_ID FROM kandyBranchs;
 CREATE INDEX id_branch_name ON branch(Name);
 EXPLAIN SELECT Branch_ID FROM BranchServices2 UNION SELECT Branch_ID FROM kandyBranchs;
 
 -- NESTED02
 explain SELECT * FROM saloon_customers AS sc NATURAL JOIN appoiment AS a WHERE a.status ='Scheduled' OR sc.customer_ID =(SELECT customer_ID FROM customer_branches AS cb WHERE cb.branch_Id ='BR002');
 CREATE INDEX id_AppStatus ON appoiment(status);
	explain SELECT * FROM saloon_customers AS sc NATURAL JOIN appoiment AS a WHERE a.status ='Scheduled' OR sc.customer_ID =(SELECT customer_ID FROM customer_branches AS cb WHERE cb.branch_Id ='BR002');

 
