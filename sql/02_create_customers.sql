CREATE TABLE retail_lab.customers (
    customer_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    phone_number VARCHAR(15),
    zip_code VARCHAR(5),
    join_date DATE,
    age INT,
    loyalty_status VARCHAR(20)
);