USE SQL_Shops;


-- Create the tables
CREATE TABLE Customers(
	customer_id int(11),
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    birthdate DATE,
    phone VARCHAR(50),
    address VARCHAR(50),
    city VARCHAR(50),
    points int,
    PRIMARY KEY (customer_id)
); 


CREATE TABLE Products(
	product_id int,
    product_name VARCHAR(50),
    store_quantity int,
    unit_price FLOAT,
    brand VARCHAR(50),
    PRIMARY KEY (product_id)
);

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

CREATE TABLE Orders(
	order_id int,
    order_date DATE,
    quantity int,
    sel_price FLOAT,
    product_id int,
    supplier_id int,
    customer_id int,
    PRIMARY KEY (order_id),
    FOREIGN KEY (product_id) REFERENCES Products (product_id),
    FOREIGN KEY (supplier_id) REFERENCES Suppliers (supplier_id),
    FOREIGN KEY (customer_id) REFERENCES Customers (customer_id)
);

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
(5, 'Hair spray',1600,450,'Loreal'),
(6,'Lip balm',1200,520,'Mac'),
(7,'Laptop',160,4500,'Apple'),
(8,'Microphone',80,750,'Blue ray'),
(9,'Mobile phone',700,2580,'Iphone'),
(10,'Play Stations',450,6500,'XBox');



-- Add values into Suppliers
INSERT INTO Suppliers
VALUES(1,'Channel','Hillcrest road','123-456-789','Hamilton',1),
(2,'Body Shop','Water front','456-785-852','Wellington',2),
(3,'LV','Dey Street','159-452-852','Auckland',4),
(4,'Red','Beerscourt street','456-485-895','Auckland',3),
(5,'Loreal-NZ','Victoria Street','412-487-854','Wellington',5),
(6,'Mac','Queens Street','475-789-954','Auckland',6),
(7,'Apple Noel leeming','Clarence street','859-895-965','Hamilton',7),
(8, 'PB Tech','TE Rapa','415-748-854','Hamilton',8),
(9,'JB HI FI ','Mills Street','415-748-854','Auckland',9),
(10,'Harvey Norman','Dey Street','451-784-485','Wellington',10);


INSERT INTO Orders
Values(1,'2023-07-24',6,1250,4,3,1),
(2,'2023-07-25',10,5600,7,2,2),
(3,'2023-06-05',10,400,3,4,3),
(4,'2023-06-25',15,3500,9,5,4),
(5,'2023-07-28',17,7000,10,1,5),
(6,'2023-07-29',120,750,6,6,7),
(7,'2023-07-30',15,3400,9,8,9);

-- Show the table contents
SELECT * FROM Customers;

SELECT * FROM Suppliers;

SELECT * FROM Products;

SELECT * FROM Orders;

-- INNER JOINS
-- To see the customers who has placed the orders
SELECT c.first_name, c.last_name, o.order_date
FROM Customers AS c
INNER JOIN Orders AS o ON c.customer_id = o.customer_id;

-- To check the ordered products
SELECT o.order_id, p.product_name, p.brand
FROM Orders AS o
INNER JOIN Products AS p ON o.product_id = p.product_id;

-- To Check the suppliers for the orders 
SELECT s.supplier_name, s.supplier_city, o.order_date
FROM Suppliers AS s
INNER JOIN Orders AS o ON s.supplier_id = o.supplier_id;

-- To ckeck the customers who placed orders before 23-07-2023
SELECT c.first_name, c.last_name, c.phone, o.order_date
FROM Customers AS c
INNER JOIN Orders As o ON c.customer_id = o.customer_id 
WHERE o.order_date > '2023-07-23';

-- To ckeck the customers who placed orders before 23-07-2023 and live in Auckland
SELECT c.first_name, c.last_name, c.phone, c.city, o.order_date
FROM Customers AS c 
INNER JOIN Orders AS o ON c.customer_id = o.customer_id
WHERE o.order_date > '2023-07-23' AND city = 'Auckland';

-- To ckeck the customers who placed orders before 23-07-2023 and live in Auckland and Hamilton
SELECT c.first_name, c.last_name, c.phone, c.city, o.order_date
FROM Customers AS c 
INNER JOIN Orders AS o ON c.customer_id = o.customer_id
WHERE o.order_date > '2023-07-23' AND city IN ('Auckland','Hamilton');

-- To ckeck the customers who placed orders before 23-07-2023 and live in Auckland and Hamilton - display the result in alphabetical order of first name
SELECT c.first_name, c.last_name, c.phone, c.city, o.order_date
FROM Customers AS c 
INNER JOIN Orders AS o ON c.customer_id = o.customer_id
WHERE o.order_date > '2023-07-23' AND city IN ('Auckland','Hamilton')
ORDER BY first_name;

-- To ckeck the customers who placed orders before 23-07-2023 and live in Auckland and Hamilton - display the result in alphabetical order of first and last names
SELECT c.first_name, c.last_name, c.phone, c.city, o.order_date
FROM Customers AS c 
INNER JOIN Orders AS o ON c.customer_id = o.customer_id
WHERE o.order_date > '2023-07-23' AND city IN ('Auckland','Hamilton')
ORDER BY first_name, last_name;

-- LEFT JOIN 
-- To see all the order details with the customers who made orders
SELECT o.order_id, o.order_date, o.quantity,o.sel_price, c.first_name,c.last_name,c.phone
FROM Orders As o
LEFT JOIN Customers AS c ON o.customer_id = c.customer_id;

-- To see the suppliers of the avilable orders
SELECT o.order_id, o.order_date, o.quantity,o.sel_price, s.supplier_name, s.supplier_address
FROM Orders As o 
LEFT JOIN Suppliers AS s ON o.supplier_id = s.supplier_id;

-- To To check the product details of the orders
SELECT o.order_id, o.order_date, o.quantity,o.sel_price, p.product_name, p.brand
FROM Orders As o
LEFT JOIN Products AS p ON o.product_id = p.product_id;

-- To see all the order details with the customers who made orders from Hamilton
SELECT o.order_id, o.order_date, o.quantity,o.sel_price, c.first_name,c.last_name,c.phone,c.city
FROM Orders As o
LEFT JOIN Customers AS c ON o.customer_id = c.customer_id
WHERE c.city = 'Hamilton';

-- To see the suppliers of the all avilable orders before 2023-07-06
SELECT o.order_id, o.order_date, o.quantity,o.sel_price, s.supplier_name, s.supplier_address
FROM Orders As o 
LEFT JOIN Suppliers AS s ON o.supplier_id = s.supplier_id
WHERE o.order_date  > '2023-07-26';

-- To check the product details and customer cities of the all available orders 
SELECT o.order_id, o.order_date, o.quantity,o.sel_price, p.product_name, p.brand,c.city
FROM Orders As o
LEFT JOIN Products AS p ON o.product_id = p.product_id
LEFT JOIN Customers As c ON o.customer_id = c.customer_id; 

-- To check the product details and customer cities of the all available orders placed from a customer from Auckland
SELECT o.order_id, o.order_date, o.quantity,o.sel_price, p.product_name, p.brand,c.city
FROM Orders As o
LEFT JOIN Products AS p ON o.product_id = p.product_id
LEFT JOIN Customers As c ON o.customer_id = c.customer_id
WHERE c.city='Auckland'; 

-- RIGHT JOIN
-- To check the customer details of all avilable orders
SELECT o.order_id, c.first_name, c.last_name, c.city, c.phone, o.order_date, o.quantity
FROM Customers AS c
RIGHT JOIN Orders As o ON c.customer_id = o.customer_id; 

-- To get the product details of aall orders 
SELECT o.order_id,p.product_name,p.brand
FROM Products AS p
RIGHT JOIN Orders AS o ON p.product_id = o.product_id
ORDER BY order_id;

-- FULL JOIN
-- To see the customer detals and order details
SELECT c.first_name, c.last_name, c.phone, o.order_id, o.order_date
FROM Customers AS c
LEFT JOIN Orders AS o ON c.customer_id = o.customer_id
UNION
SELECT c.first_name, c.last_name, c.phone, o.order_id, o.order_date
FROM Customers AS c
RIGHT JOIN Orders AS o ON c.customer_id = o.customer_id;


-- SELF JOIN
-- To match the customers from the same city
SELECT A.first_name AS CustomerName1, B.first_name AS CustomerName2, A.city 
FROM Customers A, Customers B
WHERE A.customer_id <> B.customer_id
AND A.city = B.city
ORDER BY A.city;