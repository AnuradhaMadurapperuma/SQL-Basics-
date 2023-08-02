USE Sports_Report_SQL;

SELECT * FROM athletes;

SELECT * FROM country_stats;

SELECT * FROM summer_games;

SELECT * FROM winter_games;

SELECT sport, COUNT(DISTINCT athlete_id) AS athletes
FROM summer_games
GROUP BY sport
ORDER BY sport
LIMIT 3;

SELECT sport,
COUNT(DISTINCT event) AS events, 
COUNT(DISTINCT athlete_id) AS athletes
FROM summer_games
GROUP BY sport; 

-- Select the age of oldest athlete from each region
SELECT region, 
MAX(age) AS age_of_oldest_athlete
FROM athletes AS a
JOIN summer_games AS s ON a.id = s.athlete_id
JOIN countries AS c ON s.country_id = c.id
GROUP BY region; 


-- Select summer and winter game evets
SELECT 
sport, COUNT(DISTINCT event) AS events
FROM summer_games
GROUP BY sport
UNION
SELECT 
sport, COUNT(DISTINCT event) AS events
FROM winter_games
GROUP BY sport
ORDER BY events DESC;

SELECT year,country_id, SUM(nobel_prize_winners)/population AS ratio_nobel_prize
FROM country_stats
GROUP BY year,country_id, population;


SELECT DISTINCT(event)
FROM winter_games;

SELECT 'summer' AS season,
country, year,
COUNT(DISTINCT event) AS events 
FROM summer_games AS s
JOIN countries AS c
ON s.country_id = c.id
GROUP BY year, country
UNION ALL
SELECT 'winter' AS season,
country, year, 
COUNT(DISTINCT event) AS events
FROM winter_games AS w
JOIN countries AS c
ON w.country_id = c.id
GROUP BY year,country
ORDER BY events DESC;


SELECT name,
CASE WHEN gender = 'F' AND height >=175 THEN 'Tall Female'
WHEN gender = 'M' AND height >=190 THEN 'Tall Male'
ELSE 'Others' END AS segment
FROM athletes; 


-- Pull in sport, bmi_bucket, and athletes
SELECT 
	sport,
    -- Bucket BMI in three groups: <.25, .25-.30, and >.30	
    CASE WHEN 100*weight/height^2 < .25 THEN '<.25'
    WHEN 100*weight/height^2 <= .30 THEN '.25-.30' 
    WHEN 100*weight/height^2 > .30 THEN '>.30' END AS bmi_bucket,
    COUNT(DISTINCT athlete_id) AS athletes
FROM summer_games AS s
JOIN athletes AS a
ON s.athlete_id = a.id
-- GROUP BY non-aggregated fields
GROUP BY sport, bmi_bucket
-- Sort by sport and then by athletes in descending order
ORDER BY sport, athletes DESC;

-- Trouble shooting query
SELECT 
height,weight, weight/height^2*100 AS bmi
FROM athletes
Where weight/height^2*100 IS NULL;

-- 
-- Pull in sport, bmi_bucket, and athletes
SELECT 
	sport,
    -- Bucket BMI in three groups: <.25, .25-.30, and >.30	
    CASE WHEN 100*weight/height^2 < .25 THEN '<.25'
    WHEN 100*weight/height^2 <= .30 THEN '.25-.30' 
    WHEN 100*weight/height^2 > .30 THEN '>.30' 
    ELSE 'no weight recorded' END AS bmi_bucket,
    COUNT(DISTINCT athlete_id) AS athletes
FROM summer_games AS s
JOIN athletes AS a
ON s.athlete_id = a.id
-- GROUP BY non-aggregated fields
GROUP BY sport, bmi_bucket
-- Sort by sport and then by athletes in descending order
ORDER BY sport, athletes DESC;

SELECT event,
CASE WHEN event LIKE '% Women%' THEN 'female'
ELSE 'male' END AS gender,
COUNT(DISTINCT athlete_id) AS athletes
FROM summer_games
GROUP BY event;

SELECT event,
CASE WHEN event LIKE '% Women%' THEN 'female'
ELSE 'male' END AS gender,
COUNT(DISTINCT athlete_id) AS athletes
FROM summer_games
WHERE country_id IN
(SELECT country_id
FROM country_stats
WHERE nobel_prize_winners >0)
GROUP BY event;

SELECT event,'summer' AS season,
CASE WHEN event LIKE '% Women%' THEN 'female'
ELSE 'male' END AS gender,
COUNT(DISTINCT athlete_id) AS athletes
FROM summer_games
WHERE country_id IN
(SELECT country_id
FROM country_stats
WHERE nobel_prize_winners >0)
GROUP BY event
UNION
SELECT event,'winter' AS season,
CASE WHEN event LIKE '% Women%' THEN 'female'
ELSE 'male' END AS gender,
COUNT(DISTINCT athlete_id) AS athletes
FROM winter_games
WHERE country_id IN
(SELECT country_id
FROM country_stats
WHERE nobel_prize_winners >0)
GROUP BY event
ORDER BY athletes DESC;


-- 
SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'country_stats';

SELECT AVG(CAST(population AS DECIMAL)) AS avg_population
FROM country_stats;

-- If the fields are not in the same data type the columns should be cast using CAST()
SELECT s.country_id,
COUNT(DISTINCT s.athlete_id) AS summer_athletes,
COUNT(DISTINCT w.athlete_id) AS winter_athletes
FROM summer_games AS s
JOIN winter_games AS w
ON s.country_id = CAST(w.country_id AS INT)
GROUP BY s.country_id;


SELECT
    year,
    CONCAT(YEAR(year), 's') AS decade,
    CONCAT(YEAR(year) - (YEAR(year) % 10), '-01-01') AS decade_trunc,
    SUM(gdp) AS world_gdp
FROM
    country_stats
GROUP BY
    year
ORDER BY
    year DESC;


-- Cleaning Strings
SELECT 
country,
lower(country) AS country_altered
FROM countries
GROUP BY country;

SELECT 
country,
LEFT(country,3) AS country_altered
FROM countries
GROUP BY country;

SELECT 
country,
SUBSTRING(country FROM 7) AS country_altered
FROM countries
GROUP BY country;

SELECT
region,
REPLACE(region, '&', 'and') AS character_swap,
REPLACE(region, '.','') AS character_remove
FROM countries
WHERE region = 'LATIN AMER. & CARIB'
GROUP BY region;

