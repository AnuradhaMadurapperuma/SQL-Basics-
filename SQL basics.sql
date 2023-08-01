USE SQL_Shop;


-- Create the tables
CREATE TABLE Customers(
	customer_id int(11),
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    birthdate DATE,
    phone VARCHAR(50),
    address VARCHAR(50),
    city VARCHAR(50),
    points int
); 

CREATE TABLE Orders(
	order_id int,
    order_date DATE,
    quantity int,
    sel_price FLOAT
);

CREATE TABLE Products(
	product_id int,
    product_name VARCHAR(50),
    store_quantity int,
    unit_price FLOAT,
    brand VARCHAR(50)
);

SELECT * FROM Customers;
-- Add primary key constraints
ALTER TABLE Customers
ADD PRIMARY KEY (customer_id);


ALTER TABLE Products
ADD PRIMARY KEY (product_id);

-- Add foreign key constraints

ALTER TABLE Orders
ADD customer_id int;

ALTER TABLE Orders
ADD FOREIGN KEY (customer_id) REFERENCES Customers(customer_id);

ALTER TABLE Orders
ADD  product_id int;

ALTER TABLE Orders
ADD FOREIGN KEY (product_id) REFERENCES Products(product_id);

ALTER TABLE Orders
ADD CONSTRAINT pk_orders PRIMARY KEY (order_id,customer_id,product_id);


-- Add values to the tables 
INSERT INTO Customers 
VALUES (1,'Anna', 'Hathaway','1985-05-23','123-456-789','No -100, Knighton road','Hamilton',1250),
(2,'Taylor','Swift','1990-07-14','456-789-123','No - 140, Hillcrest Road', 'Hamilton',5200),
(3, 'Salena', 'Gomez','1993-07-24','741-852-963','Beerscourt Road','Auckland',5100),
(4, 'Ariana', 'Grandae','1995-02-14','963-852-741','William son Strret','Wellington',4200),
(5, 'Margot','Robbie','1980-05-14','852-741-963','Dey Street', 'Auckland',4900),
(6, 'Lady','Gaga','1984-05-25','841-863-946','Old Farom Street','Wellington',4800),
(7,'Jennifer','Ansiton','1970-05-27','741-941-756','Way street','Auckland',523),
(8,'Harry','Styles','1990-05-27','159-752-952','Riverside walk','Hamilton',450),
(9,'Taylor','Lunter','1991-07-04','456-852-963','Devon port','Auckland',1485),
(10,'Justin','Beiber','1994-05-29','158-952-758','Wtaer front road','Wellington',3645); 


INSERT INTO Products
VALUES (1,'Perfume',1500,450,'Channel'),
(2,'Lip gloss',2000,120,'Body shop'),
(3,'Foundation',4200,270,'Red'),
(4,'Hand bags',4100,890,'LV'),
(5, 'Hair spray',1600,450,'Loreal');


INSERT INTO Orders
Values(1,'2023-07-24',6,650,4,3),
(2,'2023-07-25',8,800,7,2),
(3,'2023-06-05',10,1200,2,4),
(4,'2023-06-25',15,850,9,5),
(5,'2023-07-28',17,700,10,1);


-- Select statements
SELECT * FROM Customers;

SELECT * FROM Products;

SELECT * FROM Orders;

SELECT first_name, last_name, city FROM
customers; 

-- Select distinct values
SELECT DISTINCT city
FROM customers;

-- Count the distinct cities of the customer table
SELECT COUNT(DISTINCT city)
FROM
customers;

-- Where clause
SELECT first_name, city
FROM customers 
WHERE city = 'Hamilton'; 

-- Where clause with a numeric field 
SELECT first_name, city
FROM customers
WHERE customer_id = 5;

-- Where clause with a less than operation
SELECT * FROM customers
WHERE points > 3000 ;

-- AND operator 
SELECT * FROM customers
WHERE customer_id >  5 AND points > 1000; 

-- OR Operator
SELECT * FROM customers
WHERE customer_id > 5 OR points > 1000;  

SELECT * FROM customers
WHERE city = 'Wellington'  OR city = 'Auckland';

-- NOT  operrator 
SELECT * FROM customers
WHERE NOT city = 'Wellington';

-- Combining And Or 
SELECT * FROM customers
WHERE city = 'Hamilton' AND (points > 1000 OR birthdate  > '1990-01-01') ;

-- Order by key word
SELECT * FROM customers 
ORDER BY first_name; 

SELECT * FROM customers
WHERE points > 1000
ORDER BY city ;

SELECT * FROM customers
WHERE points > 1000
ORDER BY city DESC;

SELECT * FROM customers
WHERE points > 1000
ORDER BY city ASC, last_name DESC;

-- NULL values
SELECT * FROM customers
WHERE phone IS NULL ;

SELECT * FROM customers
WHERE phone IS NOT NULL;

-- UPDATE TABLE
UPDATE customers 
SET birthdate = '1999-10-20' , city = 'Auckland'
WHERE customer_id = 10;

-- DELETE 
DELETE FROM Orders
WHERE order_id = 5;

-- LIMIT
SELECT * FROM customers
LIMIT 5; 

-- MIN()
SELECT MIN(points) AS min_points
FROM customers;

-- MAX()
SELECT MAX(points) AS max_points
FROM customers; 

-- COUNT()
SELECT COUNT(customer_id) AS no_of_customers
FROM customers;

-- AVG()
SELECT AVG(points) AS Average_points 
FROM customers;

-- SUM()
SELECT SUM(points) as Sum_Points
FROM customers;

-- LIKE 
SELECT * FROM customers
WHERE first_name LIKE 'A%';

SELECT * FROM customers
WHERE  first_name LIKE 'A%a';

SELECT * FROM customers
WHERE  first_name LIKE 'A__a';

SELECT * FROM customers 
WHERE first_name NOT LIKE 'A%';

-- IN Operator
SELECT * FROM customers
WHERE city IN ('Auckland', 'Hamilton');

SELECT * FROM customers
WHERE city NOT IN ('Auckland', 'Hamilton');

-- BETWEEN 
SELECT * FROM customers
WHERE points BETWEEN 1000 and 2000 ; 

SELECT * FROM customers 
WHERE points BETWEEN 2000 AND 4000
AND city IN ('Auckland','Wellington'); 

SELECT * FROM customers
WHERE city NOT BETWEEN 'Auckland' AND 'Hamilton' 
ORDER BY customer_id;

-- Aliases
SELECT city FROM customers
AS Cities; 


SELECT c.first_name, o.quantity
FROM customers AS c , orders AS o
WHERE c.customer_id= o.order_id; 

SELECT c.first_name, o.quantity
FROM customers AS c , orders AS o
WHERE c.first_name LIKE 'A%' AND c.customer_id = o.order_id; 

-- SQL INNER JOINS
SELECT c.first_name, c.last_name, o.quantity, o.order_date
FROM Customers AS c INNER JOIN Orders AS o
ON c.customer_id = o.customer_id;

-- INNER JOIN three tables
SELECT c.first_name, c.last_name, o.quantity, o.order_date, p.product_name,p.brand
FROM (( Customers AS c
INNER JOIN Orders AS o ON c.customer_id = o.order_id)
INNER JOIN Products AS p ON o.product_id = p.product_id
);

-- LEFT JOIN
SELECT * FROM Customers
LEFT JOIN Orders
ON Customers.customer_id =  Orders.customer_id; 


SELECT * FROM Customers
LEFT JOIN Orders
ON Customers.customer_id =  Orders.customer_id
ORDER BY Customers.first_name; 

-- RIGHT JOIN
SELECT Orders.order_id,Orders.quantity, Customers.First_name FROM Customers
RIGHT JOIN Orders
ON Customers.customer_id =  Orders.customer_id
ORDER BY Orders.quantity; 

-- FULL JOIN

SELECT c.first_name, c.last_name, o.quantity, o.sel_price 
FROM Customers AS c 
LEFT JOIN Orders AS o ON c.customer_id = o.customer_id
UNION
SELECT c.first_name, c.last_name, o.quantity, o.sel_price 
FROM Customers AS c 
RIGHT JOIN Orders AS o ON c.customer_id = o.customer_id
ORDER BY first_name;

-- SELF JOIN
SELECT A.first_name AS CustomerName1, B.first_name AS CustomerName2, A.city
FROM Customers A, Customers B
WHERE A.customer_id <> B.customer_id
AND A.city = B.city
ORDER BY A.city;

-- CREATE Supplier table
CREATE TABLE Suppliers(
	supplier_id int,
    supplier_name VARCHAR(50),
    supplier_address VARCHAR(50),
    supplier_phone VARCHAR(50),
    Supplier_city VARCHAR(20),
    product_id int,
    PRIMARY KEY (supplier_id),
    FOREIGN KEY (product_id) REFERENCES Products (product_id)
);


-- Add values into Suppliers
INSERT INTO Suppliers
VALUES(1,'Channel','Hillcrest road','123-456-789','Hamilton',1),
(2,'Body Shop','Water front','456-785-852','Wellington',2),
(3,'LV','Dey Street','159-452-852','Auckland',4);

SELECT * FROM Suppliers;

-- UNION Keyword
SELECT city FROM Customers
UNION 
SELECT Supplier_city FROM Suppliers 
ORDER BY city;

-- GROUP BY 
SELECT  first_name, last_name, city
FROM Customers
WHERE points > 2000
GROUP BY first_name, last_name,city;


SELECT  first_name, last_name, city
FROM Customers
WHERE points > 2000
GROUP BY first_name, last_name,city
ORDER BY city;

SELECT COUNT(customer_id) , city
FROM Customers
GROUP BY city
ORDER BY COUNT(customer_id) DESC; 

-- HAVING 
SELECT COUNT(customer_id) , city
FROM Customers
GROUP BY city
HAVING COUNT(customer_id) > 3;

-- HAVING 
SELECT COUNT(customer_id) , city
FROM Customers
GROUP BY city
HAVING COUNT(customer_id) > 2
ORDER BY COUNT(customer_id) DESC;

SELECT Products.product_name, COUNT(Orders.order_id) AS NoOfOrders
FROM (Orders 
INNER JOIN Products ON Orders.product_id = Products.product_id)
GROUP BY product_name
HAVING COUNT(Orders.order_id) > 0;

-- EXIST
SELECT supplier_name
FROM Suppliers
WHERE EXISTS (SELECT Product_name FROM Products WHERE Products.product_id = Suppliers.product_id AND unit_price > 400);

-- ANY
SELECT product_name
FROM Products
WHERE product_id = ANY
	(SELECT product_id
    FROM Suppliers
    WHERE Supplier_city = 'Wellington'
    );
    
    
SELECT product_name
FROM Products
WHERE product_id = ALL
  (SELECT product_id
  FROM Orders
  WHERE quantity = 10);  
  
-- SELECT INTO
SELECT * INTO CustomersBackup
FROM Customers;  

-- SQL CASE
SELECT first_name, last_name,
CASE 
	WHEN points > 4500 THEN 'GOLD'
    WHEN points  > 2000 THEN 'SILVER'
    ELSE 'Novice'
 END AS Membership
 FROM Customers;
 
-- Stored Procedures
DELIMITER //

CREATE PROCEDURE SelectCustomers()
BEGIN
    SELECT * FROM Customers;
END //

DELIMITER ;

CALL SelectCustomers();

DELIMITER //

CREATE PROCEDURE selectCustomersCity(IN cityParam nvarchar(30))
BEGIN
SELECT * FROM Customers WHERE city = cityParam;
END//

DELIMITER //

CALL selectCustomersCity('Hamilton');

-- SQL create views
CREATE VIEW `Hamilton Customers` AS 
SELECT first_name, last_name
FROM Customers
WHERE city = 'Hamilton';

SELECT * FROM \`Hamilton Customers\`;



 




















