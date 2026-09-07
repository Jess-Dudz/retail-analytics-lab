--Show each transaction with the customer’s first name, last name, loyalty status, transaction amount, and transaction time.
SELECT 
    t.transaction_id,
    c.first_name,
    c.last_name,
    c.loyalty_status,
    t.total_amount,
    t.transaction_ts
FROM retail_lab.transactions AS t
JOIN retail_lab.customers AS c
    ON t.customer_id = c.customer_id;

-- Question 2: Show each transaction with customer and store details
SELECT 
    t.transaction_id,
    c.first_name,
    c.last_name,
    c.loyalty_status,
    s.store_name,
    s.city,
    s.store_type,
    t.total_amount,
    t.transaction_ts
FROM retail_lab.transactions AS t
JOIN retail_lab.customers AS c
    ON t.customer_id = c.customer_id
JOIN retail_lab.stores AS s
    ON t.store_id = s.store_id;


-- Question 3: Which stores have the most transactions?
SELECT 
    s.store_name,
    COUNT(t.transaction_id) AS transaction_count
FROM retail_lab.transactions AS t
JOIN retail_lab.stores AS s
    ON t.store_id = s.store_id
GROUP BY s.store_name
ORDER BY transaction_count DESC;

-- Question 4: Which stores generated the most total revenue?
SELECT 
    s.store_name,
    SUM(t.total_amount) AS total_revenue
FROM retail_lab.transactions AS t
JOIN retail_lab.stores AS s
    ON t.store_id = s.store_id
GROUP BY s.store_name
ORDER BY total_revenue DESC;

-- Question 5: What are transaction count, total revenue, and average transaction value by store?
SELECT 
    s.store_name,
    COUNT(t.transaction_id) AS transaction_count,
    SUM(t.total_amount) AS total_revenue,
    ROUND(AVG(t.total_amount), 2) AS average_transaction_value
FROM retail_lab.transactions AS t
JOIN retail_lab.stores AS s
    ON t.store_id = s.store_id
GROUP BY s.store_name
ORDER BY total_revenue DESC;

-- Question 6: What is total revenue and average transaction value by loyalty tier?
SELECT 
    c.loyalty_status,
    SUM(t.total_amount) AS total_revenue,
    ROUND(AVG(t.total_amount), 2) AS average_transaction_value
FROM retail_lab.transactions AS t
JOIN retail_lab.customers AS c
    ON t.customer_id = c.customer_id   
GROUP BY c.loyalty_status
ORDER BY total_revenue DESC;

-- Question 7: How many transactions does each loyalty tier generate?
SELECT 
    c.loyalty_status,
    COUNT(t.transaction_id) AS transaction_count
FROM retail_lab.transactions AS t
JOIN retail_lab.customers AS c
    ON t.customer_id = c.customer_id
GROUP BY c.loyalty_status
ORDER BY transaction_count DESC;

-- Question 8: Summarize customer and transaction performance by loyalty tier
SELECT
    c.loyalty_status,
    COUNT(DISTINCT c.customer_id) AS customer_count,
    COUNT(t.transaction_id) AS transaction_count,
    SUM(t.total_amount) AS total_revenue,
    ROUND(AVG(t.total_amount), 2) AS average_transaction_value
FROM retail_lab.transactions AS t
JOIN retail_lab.customers AS c
    ON t.customer_id = c.customer_id
GROUP BY c.loyalty_status
ORDER BY total_revenue DESC;