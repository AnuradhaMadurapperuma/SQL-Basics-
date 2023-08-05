-- SQL Window functions are covered here including the following topics.
-- Basic window syntax
-- Aggregated functions; SUM(),COUNT(),AVG(),MAX()
-- ROW_NUMBER()
-- RANK()
-- DENSE_RANK
-- NTILE()
-- LAG() and LEAD()
-- WIndow alias

USE Sports_Report_SQL;

SELECT id,name,age,gender,
		COUNT(gender) OVER (PARTITION BY gender) AS num_gender
FROM athletes;         

SELECT id,name,age,weight,gender,
		AVG(weight) OVER (PARTITION BY gender) AS avg_gender_weight
FROM athletes;

SELECT id,name,age,weight,gender,
		AVG(age) OVER (PARTITION BY gender ) AS avg_age_gender
FROM athletes;        

SELECT id,name,age,weight,gender,
		AVG(age) OVER (PARTITION BY gender ORDER BY age) AS avg_age_gender
FROM athletes;   

SELECT id, name, age, weight, gender, avg_age_gender
FROM (
    SELECT id, name, age, weight, gender,
           AVG(age) OVER (PARTITION BY gender) AS avg_age_gender
    FROM athletes
) AS subquery
ORDER BY avg_age_gender, age;

SELECT id,name,age,weight,
		COUNT(age) OVER (ORDER BY age) AS age_count
FROM athletes;

	
-- More aggregated functions
SELECT id,name, weight,gender, 
			AVG(weight) OVER (PARTITION BY gender) AS avg_weight_gender,
            height,
            SUM(height) OVER (PARTITION BY gender) AS sum_height_gender,
            age,
            COUNT(age) OVER (PARTITION BY age) AS count_age_gender
    FROM athletes;        
            
  SELECT id,age,name,weight,gender,avg_weight_gender, sum_height_gender,count_age_gender,max_height_age,max_height_gender
  FROM 
  (SELECT id,name, weight,gender, 
			AVG(weight) OVER (PARTITION BY gender) AS avg_weight_gender,
            height,
            SUM(height) OVER (PARTITION BY gender) AS sum_height_gender,
            age,
            COUNT(age) OVER (PARTITION BY age) AS count_age_gender,
            MAX(height) OVER (PARTITION BY age) AS max_height_age,
            MAX(height) OVER (PARTITION BY gender) AS max_height_gender
    FROM athletes) AS sub
    ORDER BY gender;      
    
    
    
    
 -- ROW_NUMBER()
 SELECT id,name,weight,age,
	ROW_NUMBER() OVER (ORDER BY age) AS row_age_number
 FROM athletes;   
 
  SELECT id,name,weight,age,
	ROW_NUMBER() OVER (ORDER BY age) AS row_age_number
 FROM athletes
 ORDER BY name;   
 
  SELECT id,name,weight,age,gender,
	ROW_NUMBER() OVER (PARTITION BY gender) AS row_gender_number
 FROM athletes;   
 
SELECT id,name,weight,age,gender,
	ROW_NUMBER() OVER (PARTITION BY gender) AS row_gender_number
 FROM athletes
 ORDER BY name;   
 
 SELECT id,name,weight,age,gender,
	ROW_NUMBER() OVER (PARTITION BY gender ORDER BY age) AS rownumber
 FROM athletes;
 
 -- RANK() / FENSE_RANK()
 SELECT id,name,weight,age, gender,
		RANK() OVER (PARTITION BY gender ORDER BY age) AS rankno
 FROM athletes;       


 SELECT id,name,weight,age, gender,
		DENSE_RANK() OVER (PARTITION BY gender ORDER BY age) AS denserankno
 FROM athletes;   
 
 -- NTILE()
 SELECT id,name,gender,weight,
		NTILE(4) OVER (PARTITION BY gender ORDER BY age) AS quartile,
        NTILE(5) OVER (PARTITION BY gender ORDER BY age) AS quintile,
        NTILE(100) OVER (PARTITION BY gender ORDER BY age) AS percentile
FROM athletes;        

-- LAG() LEAD()
SELECT id,name,gender,age, weight,height,
	LAG (age , 1) OVER (PARTITION BY gender ORDER BY age) AS lag_value,
    LEAD(age, 1) OVER (PARTITION BY gender ORDER BY age) AS lead_value
FROM athletes; 

-- Use lag for getting the difference among rows
SELECT id,name,gender,age,
	age- LAG(age ,1) OVER (PARTITION BY gender ORDER BY age) AS differenceAge
 FROM athletes;   
 
 -- Remove the resulted null values
 SELECT * FROM 
			(SELECT id,name,age,gender,
            age-LAG(age,1) OVER (PARTITION BY gender ORDER BY age) AS age_diff
            FROM athletes
            ) sub
 WHERE sub.age_diff IS NOT NULL;
 
 -- Defining a window alias
 SELECT id,name,age,gender,weight,height,
        NTILE(4) OVER ntile_window AS quartile,
        NTILE(5) OVER ntile_window AS quintle,
        NTILE(100) OVER ntile_window AS percentile
FROM athletes
WINDOW ntile_window AS (PARTITION BY gender ORDER BY age);        