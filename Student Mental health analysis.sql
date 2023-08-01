-- The data file is uploaded as students mental health data.csv

USE Portfolio_project1;

SELECT * FROM students;

-- Table Description
-- inter_dom ->	Types of students (international or domestic)
-- japanese_cate ->	Japanese language proficiency
-- english_cate->	English language proficiency
-- academic-> 	Current academic level (undergraduate or graduate)
-- age->	Current age of student
-- stay->	Current length of stay in years
-- todep->	Total score of depression (PHQ-9 test)
-- tosc->	Total score of social connectedness (SCS test)
-- toas->	Total score of acculturative stress (ASISS test)




-- How many international students 
SELECT COUNT(*) AS NoOfInternationalStu
FROM students
WHERE inter_dom = 'Inter';  

-- How many Domestic students
SELECT COUNT(*) AS NoOfDomesticStu
FROM students
WHERE inter_dom = 'Dom';

-- Number of international students as a percentage
SELECT (SUM(inter_dom = 'Inter') / COUNT(*)) * 100 AS percentage_inter
FROM students;

-- Percentage of females
SELECT (SUM(gender = 'Female')/ COUNT(*)) * 100 AS Female_percentage
FROM students;

-- Percentage of Undergraduates
SELECT (SUM(academic = 'Under')/ COUNT(*)) * 100 AS Undergrad_percentage
FROM students;

-- Select the studnets who commited on a suicide
SELECT * FROM students
WHERE suicide = 'yes';

-- Create a view with the details of suicided students
CREATE VIEW Suicided_stu AS
SELECT * FROM students
WHERE suicide = 'yes';

SELECT * FROM Suicided_stu;

-- Is international students tends to committed in suicide than domestic
SELECT inter_dom, COUNT(*) AS count_of_students
FROM Suicided_stu
GROUP BY inter_dom;

-- How many females and males students are in suicide
SELECT gender, COUNT(*) AS Count_gender
FROM Suicided_stu
GROUP BY gender;

-- Can we see a difference among grad and undergrads
SELECT academic, COUNT(*) AS Count_academic
FROM Suicided_stu
GROUP BY academic;

SELECT todep,academic,gender,suicide
FROM students
WHERE inter_dom = 'Inter' 
ORDER BY todep DESC;


SELECT todep,academic,gender
FROM students
WHERE inter_dom = 'Inter' AND suicide = 'yes'
ORDER BY todep DESC;

SELECT tosc,academic,gender,suicide
FROM students
WHERE inter_dom = 'Inter'  
ORDER BY tosc;

SELECT tosc,academic,gender
FROM students
WHERE inter_dom = 'Inter' AND suicide = 'yes'
ORDER BY tosc;

SELECT todep, tosc, toas, gender, academic
FROM students
WHERE inter_dom = 'Inter' AND suicide = 'yes'
GROUP BY gender, academic,todep, tosc, toas
ORDER BY todep, tosc, toas; 

SELECT todep, tosc, toas, gender
FROM students
WHERE inter_dom = 'Inter' AND suicide = 'yes' AND academic='Under'
GROUP BY gender,todep, tosc, toas
ORDER BY todep, tosc, toas; 

SELECT todep, tosc, toas, gender
FROM students
WHERE inter_dom = 'Inter' AND suicide = 'yes' AND academic='Under'
GROUP BY gender,todep, tosc, toas
HAVING todep > 10
ORDER BY todep, tosc, toas; 

SELECT todep, tosc, toas, gender
FROM students
WHERE inter_dom = 'Inter' AND suicide = 'yes' AND academic='Under'
GROUP BY gender,todep, tosc, toas
HAVING todep > 10 AND tosc < 15 
ORDER BY todep, tosc, toas; 

-- Find the average scores by length of stay for international students, and view them in descending order
SELECT stay, 
       ROUND(AVG(todep), 2) AS average_todep, 
       ROUND(AVG(tosc), 2) AS average_tosc, 
       ROUND(AVG(toas), 2) AS average_toas
FROM students
WHERE inter_dom = 'Inter'
GROUP BY stay
ORDER BY stay;