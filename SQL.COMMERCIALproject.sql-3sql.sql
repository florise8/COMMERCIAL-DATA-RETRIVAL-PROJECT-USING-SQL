
CREATE DATABASE COMMERCIALPROJECT_3
USE COMMERCIALPROJECT_3

CREATE TABLE WINE (
    WINE_ID INT PRIMARY KEY,
    CATEGORY VARCHAR(50),
    YEAR INT,
    DEGREE FLOAT
);

CREATE TABLE PRODUCER (
    PRODUCER_ID INT PRIMARY KEY,
    FIRST_NAME VARCHAR(50),
    LAST_NAME VARCHAR(50),
    REGION VARCHAR(50)
);

 CREATE TABLE PRODUCTION (
    PRODUCTION_ID INT PRIMARY KEY,
    WINE_ID INT FOREIGN KEY  REFERENCES WINE(WINE_ID),
    PRODUCER_ID INT FOREIGN KEY  REFERENCES PRODUCER(PRODUCER_ID),
	QUANTITY INT
);


 INSERT INTO WINE VALUES
(1, 'Red', 2019, 13.5),
(2, 'White', 2020, 12.0),
(3, 'Rose', 2018, 11.5),
(4, 'Red', 2021, 14.0),
(5, 'Sparkling', 2017, 10.5),
(6, 'White', 2019, 12.5),
(7, 'Red', 2022, 13.0),
(8, 'Rose', 2020, 11.0),
(9, 'Red', 2018, 12.0),
(10, 'Sparkling', 2019, 10.0),
(11, 'White', 2021, 11.5),
(12, 'Red', 2022, 15.0);

-- Insert Data into Producer Table

 INSERT INTO PRODUCER VALUES
(1, 'John', 'Smith', 'Sousse'),
(2, 'Emma', 'Johnson', 'Tunis'),
(3, 'Michael', 'Williams', 'Sfax'),
(4, 'Emily', 'Brown', 'Sousse'),
(5, 'James', 'Jones', 'Sousse'),
(6, 'Sarah', 'Davis', 'Tunis'),
(7, 'David', 'Miller', 'Sfax'),
(8, 'Olivia', 'Wilson', 'Monastir'),
(9, 'Daniel', 'Moore', 'Sousse'),
(10, 'Sophia', 'Taylor', 'Tunis'),
(11, 'Matthew', 'Anderson', 'Sfax'),
(12, 'Amelia', 'Thomas', 'Sousse');

-- Insert Sample Data into Production Table

INSERT INTO PRODUCTION VALUES
(1, 1, 1, 500),
(2, 2, 2, 300),
(3, 3, 3, 450),
(4, 4, 4, 200),
(5, 5, 5, 150),
(6, 6, 6, 350),
(7, 7, 7, 400),
(8, 8, 8, 250),
(9, 9, 9, 600),
(10, 10, 10, 700),
(11, 11, 11, 800),
(12, 12, 12, 300);

--4. Retrieve a list of all producers
   SELECT * 
   FROM 
       PRODUCER;
--5. Retrieve a sorted list of producers by name.
 SELECT 
      FIRST_NAME AS 'Producers First Name', 
	  LAST_NAME As 'Producers Last Name'
 FROM 
     [dbo].[PRODUCER];

-- 6. Retrieve a list of producers from Sousse.
    SELECT *
    FROM [dbo].[PRODUCER]
	WHERE REGION = 'Sousse';

-- 7. Calculate the total quantity of wine produced with the wine number 12:
      SELECT * FROM WINE
	  SELECT * FROM [dbo].[PRODUCER]
	  SELECT * FROM [dbo].[PRODUCTION]

SELECT 
	  W.WINE_ID, SUM(P.QUANTITY) AS 'Total Wine Quantity'
FROM 
	  [dbo].[WINE] AS W
JOIN 
	  [dbo].[PRODUCTION] AS P
ON 
	  W.WINE_ID = P.WINE_ID
WHERE 
	  W.WINE_ID = 12
GROUP BY 
	  W.WINE_ID;

-- 8. Calculate the quantity of wine produced for each category.
      SELECT * FROM [dbo].[WINE]
	  SELECT * FROM [dbo].[PRODUCTION]

SELECT 
	  W.WINE_ID, W.CATEGORY, 
	  COUNT(P.QUANTITY) AS WineQuantity
FROM 
	  [dbo].[WINE] AS W
JOIN 
	  [dbo].[PRODUCTION] AS P
ON 
	  W.WINE_ID = P.WINE_ID
GROUP BY 
	  W.WINE_ID , W.CATEGORY;

-- 9. Find producers in the Sousse region who have harvested at least one wine in quantities greater than 300 liters. 
------Display their names and first names, sorted alphabetically.
      SELECT * FROM [dbo].[PRODUCER]
	  SELECT * FROM [dbo].[PRODUCTION]

SELECT 
      P1.REGION as HarvestedRegion,
	  P1.FIRST_NAME, 
	  P1.LAST_NAME
FROM  [dbo].[PRODUCER]AS P1
	  JOIN [dbo].[PRODUCTION] AS P2
ON P1.PRODUCER_ID = P2.PRODUCER_ID
	  WHERE P1.REGION = 'Sousse'
	  AND   P2.QUANTITY > 300


-- 10. List the wine numbers with a degree greater than 12, produced by producer number 12.

      SELECT * FROM [dbo].[PRODUCER]
	  SELECT * FROM [dbo].[PRODUCTION]
	  SELECT * FROM [dbo].[WINE]

SELECT 
	  P1.PRODUCER_ID, 
	  W.DEGREE,
	  W.CATEGORY,
	  W.YEAR
FROM [dbo].[PRODUCER] AS P1
	  JOIN [dbo].[PRODUCTION] AS P2
ON P1.PRODUCER_ID = P2.PRODUCER_ID
	  JOIN [dbo].[WINE] AS W
ON W.WINE_ID = P2.WINE_ID
	  WHERE  W.DEGREE > 12
	  AND P1.PRODUCER_ID = 12
	  
--11. Find the producer who has produced the highest quantity of wine.

SELECT 
	  P2.PRODUCER_ID, 
	  P2.FIRST_NAME, 
	  P2.LAST_NAME, 
	  P1.QUANTITY AS WINE_PRODUCED
FROM 
	  [dbo].[PRODUCTION] P1
	  JOIN [dbo].[PRODUCER] P2
	  ON P1.PRODUCER_ID = P2.PRODUCER_ID
WHERE 
	  QUANTITY = (
	               SELECT MAX(QUANTITY) AS HIGHTEST_QUANT
	               FROM [dbo].[PRODUCTION]
				  );

--12. Find the average degree of wine produced.
 SELECT * FROM [dbo].[WINE]

SELECT  
    AVG(DEGREE) AS Average_Degree 
FROM 
    [dbo].[WINE]


--13. Find the oldest wine in the database.

SELECT TOP(1)
    WINE_ID, 
	CATEGORY, 
	YEAR AS YEAR_PRODUCED
FROM [dbo].[WINE]
ORDER BY YEAR ASC;

--14. Retrieve a list of producers along with 
--the total quantity of wine they have produced.

SELECT 
	  P1.PRODUCER_ID, 
	  P1.FIRST_NAME, 
	  P1.LAST_NAME, 
	  SUM(P2.QUANTITY) AS Total_Quant_Produced
FROM 
      [dbo].[PRODUCER] AS P1
JOIN 
	  [dbo].[PRODUCTION] AS P2
ON P1.PRODUCER_ID = P2.PRODUCER_ID
GROUP BY 
	  P1.PRODUCER_ID, 
	  P1.FIRST_NAME, 
	  P1.LAST_NAME
ORDER BY 
      Total_Quant_Produced DESC

--15. Retrieve a list of wines along with their producer details.
SELECT 
	  W.*, 
	  P2.*
FROM 
	  [dbo].[WINE] AS W
JOIN 
	  [dbo].[PRODUCTION] AS P1
ON 
	  W.WINE_ID = P1.WINE_ID
JOIN 
	  [dbo].[PRODUCER] AS P2
ON 
	  P1.PRODUCER_ID = P2.PRODUCER_ID


