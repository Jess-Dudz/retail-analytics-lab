SELECT loyalty_status, COUNT(*) AS total_customers
FROM retail_lab.customers
GROUP BY loyalty_status
ORDER BY total_customers DESC;

-- Question 2: Show customers who are age 40 or older
SELECT \* FROM retail\_lab.customers WHERE age >= 40;

-- Question 3: Show only gold customers age 40 or older
SELECT * 
FROM retail_lab.customers 
WHERE age >= 40 
AND loyalty_status = 'gold';

-- Question 4: Show customers who are either gold OR silver
SELECT *
FROM retail_lab.customers 
WHERE loyalty_status IN ('gold', 'silver');

-- Question 5: Show customers who are not gold or silver
SELECT *
FROM retail_lab.customers
WHERE loyalty_status NOT IN ('gold', 'silver');

-- Question 6: Show customers between ages 30 and 45
SELECT *
FROM retail_lab.customers
WHERE age BETWEEN 30 AND 45;

-- Question 7: Show customers who joined in 2026
SELECT *
FROM retail_lab.customers
WHERE join_date >= '2026-01-01' AND join_date < '2027-01-01';

-- Question 8: How many customers joined in 2026?
SELECT COUNT(*) AS total_customers_2026
FROM retail_lab.customers
WHERE join_date >= '2026-01-01' AND join_date < '2027-01-01';

-- Question 9: What is the average age of all customers?
SELECT round(AVG(age), 2) AS average_age   
FROM retail_lab.customers;

-- Question 10: What is the youngest and oldest customer age?
SELECT MIN(age) AS youngest_age, MAX(age) AS oldest_age
FROM retail_lab.customers;

-- Question 11: What is the average age by loyalty tier?
SELECT loyalty_status, ROUND(AVG(age), 2) AS average_age
FROM retail_lab.customers
GROUP BY loyalty_status;

-- Question 12: Which loyalty tier has the highest average age?
SELECT loyalty_status, ROUND(AVG(age), 2) AS average_age
FROM retail_lab.customers
GROUP BY loyalty_status
ORDER BY average_age DESC
LIMIT 1;    

-- Question 13: How many customers are in each age group?
SELECT
    CASE
        WHEN age < 30 THEN 'Under 30'
        WHEN age BETWEEN 30 AND 39 THEN '30-39'
        WHEN age BETWEEN 40 AND 49 THEN '40-49'
        WHEN age BETWEEN 50 AND 59 THEN '50-59'
        ELSE '60 and above'
    END AS age_group,
    COUNT(*) AS total_customers
FROM retail_lab.customers
GROUP BY age_group
ORDER BY MIN(age);