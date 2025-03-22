-- QUESTIONS

-- 1. What is the gender breakdown of employees in the company?
SELECT gender, COUNT(*) AS COUNT FROM hr
WHERE age>=18 AND termdate='0000-00-00'
GROUP BY gender;
-- 2. What is the race/ethnicity breakdown of employees in the company?
SELECT race, COUNT(*) AS COUNT FROM hr
WHERE age>=18 AND termdate='0000-00-00'
GROUP BY race
ORDER BY COUNT DESC;
-- 3. What is the age distribution of employees in the company?
SELECT 
	CASE 
    WHEN age >=18 AND age<=24 THEN '18-24'
    WHEN age >=25 AND age<=34 THEN '25-34'
    WHEN age >=35 AND age<=44 THEN '35-44'
    WHEN age >=45 AND age<=54 THEN '45-54'
    WHEN age >=55 AND age<=64 THEN '55-64'
    ELSE '65+'
END AS age_group,gender,COUNT(*) AS count
FROM hr
WHERE age>=18 AND termdate='0000-00-00'
GROUP BY age_group, gender
ORDER BY age_group, gender;
-- 4. How many employees work at headquarters versus remote locations?
SELECT location, COUNT(*) AS COUNT FROM hr
WHERE age>=18 AND termdate='0000-00-00'
GROUP BY location;
-- 5. What is the average length of employment for employees who have been terminated?
SELECT ROUND(AVG(DATEDIFF(termdate,hire_date))/365,0) AS average_length_employment
FROM hr
WHERE termdate<=CURDATE() AND age>=18 AND termdate<>'0000-00-00';
-- 6. How does the gender distribution vary across departments and job titles?
SELECT department,jobtitle,gender,COUNT(*) AS count
FROM hr
WHERE age>=18 AND termdate='0000-00-00'
GROUP BY department,jobtitle,gender
ORDER BY department;
-- 7. What is the distribution of job titles across the company?
SELECT jobtitle,COUNT(*) AS count
FROM hr
WHERE age>=18 AND termdate='0000-00-00'
GROUP BY jobtitle
ORDER BY jobtitle DESC;
-- 8. Which department has the highest turnover rate?
SELECT
department,
total_count,
terminated_count,
terminated_count/total_count AS termination_rate
FROM(
 SELECT department,
 COUNT(*) AS total_count,
 SUM(CASE WHEN termdate<=curdate() AND termdate<>'0000-00-00' THEN 1 ELSE 0 END) AS terminated_count
 FROM hr
 WHERE age>=18
 GROUP BY department)
 AS subquery
 ORDER BY termination_rate DESC;
-- 9. What is the distribution of employees across locations by city and state?
SELECT location_state, COUNT(*) AS count
FROM hr
WHERE age>=18 AND termdate='0000-00-00'
GROUP BY location_state 
ORDER by location_state,count DESC;
-- 10. How has the company's employee count changed over time based on hire and term dates?
SELECT 
year,
hire,
terminate,
hire-terminate AS net_change,
((hire-terminate)*100)/hire AS net_change_percentage
FROM(
	SELECT 
		YEAR(hire_date) AS year,
		COUNT(*) AS hire,
		SUM(CASE WHEN termdate<>'0000-00-00' AND termdate<=curdate() THEN 1 ELSE 0 END) AS terminate
FROM hr
WHERE age>=18
GROUP BY year) AS subquery
ORDER BY year ASC;
-- 11. What is the tenure distribution for each department?
SELECT 
department,round(avg(datediff(termdate,hire_date)/365),0) AS avg_tenure
FROM hr
WHERE age>=18 AND termdate<>'0000-00-00' AND termdate<=curdate()
GROUP BY department;
-- 12. what are the number of active employees?
SELECT COUNT(*) AS number_of_active_employee
FROM hr
WHERE age>=18 AND termdate='0000-00-00'