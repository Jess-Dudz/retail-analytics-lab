-- Question 1: Which hour of the day generates the most revenue?
SELECT
    EXTRACT(HOUR FROM transaction_ts) AS transaction_hour,
    SUM(total_amount) AS total_revenue
FROM retail_lab.transactions
GROUP BY transaction_hour
ORDER BY total_revenue DESC;

-- Question 2: Which store-hour combinations generate the most revenue overall?
SELECT
    s.store_name,
    EXTRACT(HOUR FROM t.transaction_ts) AS transaction_hour,
    SUM(t.total_amount) AS total_revenue
FROM retail_lab.transactions AS t
JOIN retail_lab.stores AS s
    ON t.store_id = s.store_id  
GROUP BY s.store_name, transaction_hour
ORDER BY total_revenue DESC;

-- Question 3: What is the single highest-revenue hour for each store?
SELECT
    s.store_name,
    EXTRACT(HOUR FROM t.transaction_ts) AS transaction_hour,
    SUM(t.total_amount) AS total_revenue,
    ROW_NUMBER() OVER (
        PARTITION BY s.store_name
        ORDER BY SUM(t.total_amount) DESC
    ) AS revenue_rank
FROM retail_lab.transactions AS t
JOIN retail_lab.stores AS s
    ON t.store_id = s.store_id
GROUP BY s.store_name, transaction_hour
ORDER BY s.store_name, total_revenue DESC;

-- Question 4: What is the single highest-revenue hour for each store?
SELECT *
FROM (
    SELECT
        s.store_name,
        EXTRACT(HOUR FROM t.transaction_ts) AS transaction_hour,
        SUM(t.total_amount) AS total_revenue,
        ROW_NUMBER() OVER (
            PARTITION BY s.store_name
            ORDER BY SUM(t.total_amount) DESC
        ) AS revenue_rank
    FROM retail_lab.transactions AS t
    JOIN retail_lab.stores AS s
        ON t.store_id = s.store_id
    GROUP BY s.store_name, transaction_hour
) AS ranked_revenue
WHERE revenue_rank = 1;


