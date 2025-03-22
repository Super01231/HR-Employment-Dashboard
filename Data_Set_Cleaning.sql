USE project;
SELECT* FROM hr;
-- To change the name of colum following query can be used 
ALTER TABLE hr
CHANGE COLUMN ï»¿id emp_id VARCHAR(20) NULL; --  this query will change the data type of the column from text to varchar and piut constraint NULL

SELECT birthdate FROM hr;
SET sql_safe_updates=0; -- this one is very important to safe
UPDATE hr
SET hire_date = CASE
	WHEN hire_date LIKE '%/%' THEN date_format(str_to_date(hire_date,'%m/%d/%Y'),'%Y-%m-%d')
    WHEN hire_date LIKE '%-%' THEN date_format(str_to_date(hire_date,'%m-%d-%Y'),'%Y-%m-%d')
	ELSE NULL
END;

SELECT hire_date FROM hr;
ALTER TABLE hr
MODIFY COLUMN hire_date DATE;

DESCRIBE hr;

SELECT termdate FROM hr;
UPDATE hr
SET termdate=  IF(termdate IS NOT NULL AND termdate != '', date(str_to_date(termdate, '%Y-%m-%d %H:%i:%s UTC')), '0000-00-00')
WHERE true;

ALTER TABLE hr
MODIFY COLUMN termdate DATE;

ALTER TABLE hr ADD COLUMN age INT;

UPDATE hr
SET birthdate=DATE_SUB(birthdate,interval 100 YEAR)
WHERE birthdate>='2060-01-01';
UPDATE hr
SET age=TIMESTAMPDIFF(YEAR,birthdate,CURDATE());
SELECT birthdate,age FROM hr;

SELECT 
MAX(age) AS eldest,
MIN(age) AS youngest
FROM hr;

SELECT COUNT(age) FROM hr
WHERE age = 18