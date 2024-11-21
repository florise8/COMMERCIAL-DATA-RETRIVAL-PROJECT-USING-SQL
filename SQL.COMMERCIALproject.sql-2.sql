
CREATE DATABASE COMMERCIALPROJECT_2
USE COMMERCIALPROJECT_2
-- 1. Products Table

 CREATE TABLE Products (
    ProductID VARCHAR(10) PRIMARY KEY,
    ProductName VARCHAR(50),
    ProductType VARCHAR(50),
    Price DECIMAL(10, 2)
 );

INSERT INTO Products VALUES
('P101', 'Widget A', 'Widget', 10.00),
('P102', 'Widget B', 'Widget', 15.00),
('P103', 'Gadget X', 'Gadget', 20.00),
('P104', 'Gadget Y', 'Gadget', 25.00),
('P105', 'Doohickey Z', 'Doohickey', 30.00);

--------------------------------------------------------------------------------------
-- Customers Table

 CREATE TABLE Customers (
    CustomerID VARCHAR(10) PRIMARY KEY,
    CustomerName VARCHAR(50),
    Email VARCHAR(100),
    Phone VARCHAR(15)
 );

INSERT INTO Customers VALUES
('C101', 'John Smith', 'john@example.com', '123-456-7890'),
('C102', 'Jane Doe', 'jane.doe@example.com', '987-654-3210'),
('C103', 'Paul Dada', 'paul.dada@example.com', '981-655-4210'),
('C104', 'linda Ever', 'linda.ever@example.com', '523-951-3110'),
('C105', 'Alice Brown', 'alice.brown@example.com', '456-789-0123');

-----------------------------------------------------------------------------------------
-- CREATE ORDERS TABLE

  CREATE TABLE Orders (
    OrderID VARCHAR(10) PRIMARY KEY,
    OrderDate DATE,
    CustomerID VARCHAR(10) FOREIGN KEY REFERENCES Customers(CustomerID)
  );

INSERT INTO Orders  VALUES
('O101', '2024-05-01', 'C101'),
('O102', '2024-05-02', 'C102'),
('O103', '2024-05-03', 'C103'),
('O104', '2024-05-04', 'C104'),
('0105', '2024-05-05', 'C105');

----------------------------------------------------------------------------------------------
-- OrderDetails Table

 CREATE TABLE OrderDetails (
 OrderDetailID VARCHAR(10) PRIMARY KEY,
 Quantity INT,
 OrderID VARCHAR(10) FOREIGN KEY REFERENCES Orders(OrderID),
 ProductID VARCHAR(10) FOREIGN KEY REFERENCES Products(ProductID)
 );

INSERT INTO OrderDetails VALUES
('D101', 11, 'O101', 'P101' ),
('D102', 13, 'O102','P102'),
('D103', 14, 'O103', 'P103'),
('D104', 12, 'O104', 'P104'),
('D105', 15, '0105', 'P105');

-------------------------------------------------------------------------------------------------
-- ProductTypes Table

CREATE TABLE 
ProductTypes (
    ProductTypeID VARCHAR(10) PRIMARY KEY,
    ProductTypeName VARCHAR(50)
);

INSERT INTO ProductTypes VALUES
('PT101', 'Widget'),
('PT102', 'Gadget'),
('PT103', 'Doohickey');

SELECT * FROM [dbo].[OrderDetails]
SELECT * FROM [dbo].[Customers]
SELECT * FROM [dbo].[Products]
SELECT * FROM [dbo].[Orders]
SELECT * FROM ProductTypes

----------------------------------------------------------------------
 -- ProductTypes Table
 CREATE TABLE ProductTypes (
    ProductTypeID INT PRIMARY KEY,
    ProductTypeName VARCHAR(50)
);


INSERT INTO ProductTypes (ProductTypeID, ProductTypeName) VALUES
(1, 'Widget'),
(2, 'Gadget'),
(3, 'Doohickey');

----------------------------------------------------------------------
-- 1. Retrieve all products.
SELECT * FROM [dbo].[Products]; 

--2. Retrieve all customers.
SELECT * FROM [dbo].[Customers];

--3. Retrieve all orders.
SELECT * FROM [dbo].[Orders];

-- 4. Retrieve all order details.
SELECT * FROM [dbo].[OrderDetails];

-- 5. Retrieve all product types.
SELECT * FROM [dbo].[ProductTypes];

-- 6. Retrieve the names of the products that have been ordered by at least one customer,
-- along with the total quantity of each product ordered.
SELECT * FROM [dbo].[Products] 
SELECT * FROM [dbo].[OrderDetails]



SELECT 
    P.ProductName, 
    SUM(OD.Quantity) AS Total_Quantity
FROM 
    [dbo].[Products] AS P
JOIN  
    [dbo].[OrderDetails] AS OD
ON 
    P.ProductID = OD.ProductID
GROUP BY 
    P.ProductName;

----------------------------------------------------------------------------------------------------
-- 7. Retrieve the names of the customers who have placed an order on every day of the week, 
--along with the total number of orders placed by each customer.
SELECT * FROM [dbo].[Customers]
SELECT * FROM [dbo].[Orders]

SELECT 
C.CustomerID, C.CustomerName, 
(DISTINCT DATEPART(WEEKDAY, O.OrderDate)) AS 'Day of Week', 
COUNT(O.OrderID) AS TotalOrders
FROM 
[dbo].[Customers] AS C
JOIN  
[dbo].[Orders] AS O
ON 
C.CustomerID = O.CustomerID
GROUP BY 
C.CustomerID, C.CustomerName
ORDER BY 'Day of Week'

-- Main Query to Retrieve Customers with Orders on Every Day of the Week

SET DATEFIRST 1; -- Set Monday as the first day of the week
SELECT 
    C.CustomerID, 
    C.CustomerName, 
    COUNT( DATEPART(WEEKDAY, O.OrderDate)) AS DaysOrdered,  
    COUNT(O.OrderID) AS TotalOrders
FROM 
    [dbo].[Customers] AS C
INNER JOIN  
    [dbo].[Orders] AS O 
ON 
	C.CustomerID = O.CustomerID
	
GROUP BY 
    C.CustomerID, 
    C.CustomerName
HAVING 
    COUNT(DISTINCT DATEPART(WEEKDAY, O.OrderDate)) = 1
ORDER BY 
    C.CustomerName;  
	



--------------------------------------------------------------------------------------------------------
-- 8. Retrieve the names of the customers who have placed the most orders, along with the total number of orders placed by each customer.
SELECT * FROM [dbo].[Customers]
SELECT * FROM [dbo].[Orders]
SELECT * FROM [dbo].[OrderDetails]

SELECT 
C.CustomerName, 
COUNT(O.OrderID) AS TotalOrders, 
SUM(OD.Quantity) AS 'Most Order'
FROM 
[dbo].[Customers] AS C
JOIN  
[dbo].[Orders] AS O
ON 
C.CustomerID = C.CustomerID
JOIN 
[dbo].[OrderDetails] AS OD
ON 
O.OrderID = OD.OrderID
GROUP BY C.CustomerName
ORDER BY TotalOrders DESC

-----------------------------------------------------------------------------------------------------------
-- 9. Retrieve the names of the products that have been ordered the most, along with the total quantity of each product ordered.
SELECT * FROM [dbo].[Products]
SELECT * FROM [dbo].[OrderDetails]

SELECT 
   P.ProductName, 
   SUM(OD.Quantity) AS TotalQuantityOrdered
FROM 
  [dbo].[Products] AS P
JOIN 
  [dbo].[OrderDetails] AS OD
ON 
  P.ProductID = OD.ProductID
GROUP BY 
  P.ProductName
ORDER BY 
  TotalQuantityOrdered ASC

-------------------------------------------------------------------------------------------------------------------
-- 10. Retrieve the names of customers who have placed an order for at least one widget.
SELECT * FROM Customers
SELECT * FROM Orders
SELECT * FROM OrderDetails
SELECT * FROM Products

SELECT 
   C.CustomerName, P.ProductType
FROM 
   [dbo].[Customers] AS C
JOIN 
   [dbo].[Orders] AS O
ON 
   C.CustomerID = O.CustomerID
JOIN  
   [dbo].[OrderDetails] AS OD
ON 
   O.OrderID = OD.OrderID
JOIN  
   [dbo].[Products] AS P
ON 
   OD.ProductID = P.ProductID
WHERE 
   P.ProductType = 'Widget';

---------------------------------------------------------------------------------------------------------------------------------
-- 11. Retrieve the names of the customers who have placed an order for at least one widget and at least one gadget, 
--along with the total cost of the widgets and gadgets ordered by each customer.

SELECT * FROM [dbo].[Customers]
SELECT * FROM [dbo].[OrderDetails]
SELECT * FROM [dbo].[Products]
SELECT * FROM [dbo].[Orders]

SELECT 
  C.CustomerName, SUM (P.Price) AS SumofTotal, 
  COUNT(OD.Quantity) , P.ProductType
FROM 
  [dbo].[Customers] As C
JOIN 
  [dbo].[Orders] AS O
ON 
  C.CustomerID = O.CustomerID
JOIN 
  [dbo].[OrderDetails] AS OD
ON 
  O.OrderID = OD.OrderID
JOIN 
  [dbo].[Products] AS P
ON 
  P.ProductID = OD.ProductID
WHERE  
  P.ProductType IN ('Gadget', 'Widget')
GROUP BY 
  C.CustomerName, P.ProductType
HAVING 
  COUNT(OD.Quantity) > = 1

-- 12. Retrieve the names of the customers who have placed an order for at least one gadget, 
--Along with the total cost of the gadgets ordered by each customer.
SELECT * FROM [dbo].[Customers]
SELECT * FROM [dbo].[Orders]
SELECT * FROM [dbo].[Products]
SELECT * FROM [dbo].[OrderDetails]

SELECT 
  C.CustomerName, 
  P.ProductType, 
  SUM (P.Price* OD.Quantity) AS SumofTotal, 
  COUNT(OD.Quantity) AS QUANTITY
FROM 
  [dbo].[Customers] As C
JOIN 
  [dbo].[Orders] AS O
ON 
  C.CustomerID = O.CustomerID
JOIN 
  [dbo].[OrderDetails] AS OD
ON 
  O.OrderID = OD.OrderID
JOIN 
  [dbo].[Products] AS P
ON 
  P.ProductID = OD.ProductID
WHERE  
  P.ProductType IN ('Gadget')
GROUP BY 
  C.CustomerName, P.ProductType
HAVING 
  COUNT(OD.Quantity) > = 1

----------------------------------------------------------------------------------------------------------
-- 13. Retrieve the names of the customers who have placed an order for at least one doohickey, 
--along with the total cost of the doohickeys ordered by each customer.

SELECT * FROM [dbo].[Customers]
SELECT * FROM [dbo].[OrderDetails]
SELECT * FROM [dbo].[Products]
SELECT * FROM [dbo].[Orders]

SELECT 
  c.CustomerName, 
  SUM(OD.Quantity * P.Price) AS Total_Price
FROM 
  [dbo].[Customers] AS C
JOIN 
  [dbo].[Orders] AS O 
ON 
  C.CustomerID = O.CustomerID
JOIN  
  [dbo].[OrderDetails] AS OD 
ON o.OrderID = od.OrderID
JOIN  
   [dbo].[Products] AS P 
ON od.ProductID = P.ProductID
WHERE 
  P.ProductType = 'Doohickey'
GROUP BY 
 c.CustomerName;

-- 14. Retrieve the names of the customers who have placed an order every day of the week, 
-- along with the total number of orders placed by each customer.
SELECT * FROM [dbo].[Customers]
SELECT * FROM [dbo].[OrderDetails]

SELECT 
   c.CustomerName, 
   (DATEPART(WEEKDAY, o.OrderDate)) AS WEEKLYORDER, 
   COUNT(O.OrderID) AS TotalOrders
FROM 
   [dbo].[Customers] C
JOIN  
   [dbo].[Orders] O
ON 
   c.CustomerID = o.CustomerID
GROUP BY 
   c.CustomerName, (DATEPART(WEEKDAY, o.OrderDate))
ORDER BY 
  WEEKLYORDER


-- 15. Retrieve the total number of widgets and gadgets ordered by each customer, along with the total cost of the orders.
SELECT * FROM [dbo].[Customers]
SELECT * FROM [dbo].[OrderDetails]
SELECT * FROM [dbo].[Products]

SELECT 
   C.CustomerName, P.ProductType, 
   SUM(OD.Quantity) AS TOTAL_W__G, 
   SUM (P.Price*OD.Quantity) AS TOTALCOST
 FROM 
   Customers c
JOIN 
   [dbo].[Orders] o 
ON 
   c.CustomerID = o.CustomerID
JOIN 
   OrderDetails od 
ON o.OrderID = od.OrderID
JOIN 
   Products p 
ON 
   od.ProductID = P.ProductID
WHERE 
   P.ProductType IN ('Widget', 'Gadget')
GROUP BY 
   c.CustomerName, P.ProductType;





