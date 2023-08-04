USE SQL_Shop;

SELECT customer_id, first_name, last_name
FROM Customers
WHERE customer_id = ( SELECT MAX(customer_id) FROM Customers
); 

-- Non Correlated Subqueries
SELECT order_id, quantity,sel_price
FROM Orders
WHERE product_id  <> (SELECT product_id
											FROM Products 
                                            WHERE product_name = 'Perfume'); 


SELECT order_id, quantity,sel_price
FROM Orders
WHERE product_id  = (SELECT product_id
											FROM Products 
                                            WHERE product_name = 'Lip gloss'); 
                                            
SELECT order_id, quantity, sel_price
FROM Orders
WHERE product_id IN  (SELECT product_id FROM Products);   

SELECT order_id, quantity, sel_price
FROM Orders
WHERE product_id IN  (SELECT product_id FROM Products WHERE brand='Body Shop');      

 SELECT order_id, quantity, sel_price
FROM Orders
WHERE product_id NOT IN  (SELECT product_id FROM Products WHERE brand='Body Shop');      
                                
SELECT order_id, quantity,sel_price,customer_id
FROM Orders
WHERE customer_id <> ALL (SELECT customer_id
												FROM Customers
                                                WHERE points < 1500);
                                                
 SELECT order_id, quantity,sel_price
 FROM Orders
 WHERE product_id IN (SELECT product_id
											FROM Suppliers
                                            WHERE supplier_city = 'Wellington') AND product_id IN 
									(SELECT product_id
											FROM Products
                                            WHERE store_quantity < 2500);
                                            
                                            
  SELECT order_id,order_date,quantity,customer_id
  FROM Orders
  WHERE product_id IN (SELECT Products.product_id
											FROM Products
                                            INNER JOIN Suppliers
                                            ON Products.product_id = Suppliers.product_id
                                            WHERE supplier_city = 'Auckland'
											);
                                            
                                            
                                            
  SELECT o.order_id,o.order_date,o.quantity,c.customer_id,c.first_name,c.last_name
  FROM Orders AS o
  INNER JOIN Customers AS c
  ON o.customer_id = c.customer_id
  WHERE product_id IN (SELECT Products.product_id
											FROM Products
                                            INNER JOIN Suppliers
                                            ON Products.product_id = Suppliers.product_id
                                            WHERE supplier_city = 'Auckland'
											);          
                                            
  
-- Correlated subqueries  
 SELECT o.order_id,o.order_date,o.quantity 
 FROM 
 Orders AS o
 WHERE 1 = (SELECT COUNT(*)
					FROM Products AS p
                    WHERE p.product_id = o.product_id);


SELECT o.order_id,o.order_date,o.quantity,o.sel_price 
 FROM 
 Orders AS o
 WHERE EXISTS (SELECT COUNT(*)
					FROM Products AS p
                    WHERE p.product_id = o.product_id);
                    
 SELECT o.order_id,o.order_date,o.quantity,o.sel_price 
 FROM 
 Orders AS o
 WHERE NOT EXISTS (SELECT COUNT(*)
					FROM Products AS p
                    WHERE p.product_id = o.product_id);        
                    
 -- Data manipulation using correlated subquerries
 UPDATE Products AS p
 SET p.brand = 
 (SELECT s.supplier_name
 FROM Suppliers AS s
 WHERE s.product_id = p.product_id AND supplier_city = 'Hamilton'
 );
 
 DELETE FROM Orders
 WHERE NOT EXISTS (SELECT 1 
										FROM Products
                                        WHERE Orders.product_id = Products.product_id
										);

SELECT o.order_id,o.quantity, o.sel_price, sub.num_products AS NumProducts
FROM Orders AS o
INNER JOIN 
(SELECT product_id, COUNT(*) AS num_products
FROM Products 
GROUP BY product_id) AS sub
ON o.product_id = sub.product_id;

SELECT c.first_name, c.last_name, p.product_name
FROM Customers AS c INNER JOIN Orders As o
ON c.customer_id = o.customer_id 
INNER JOIN Products AS p
ON p.product_id = o.product_id
INNER JOIN Suppliers AS s 
ON p.product_id = s.product_id
WHERE p.brand = 'LV' 
GROUP BY c.first_name, c.last_name, p.product_name
ORDER BY 1,2;

