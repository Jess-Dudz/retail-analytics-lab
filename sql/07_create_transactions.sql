CREATE TABLE retail_lab.transactions (
    transaction_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    customer_id INT NOT NULL,
    store_id INT NOT NULL,
    transaction_ts TIMESTAMP NOT NULL,
    total_amount NUMERIC(10, 2) NOT NULL,
    purchase_channel VARCHAR(20) NOT NULL
        CHECK (purchase_channel IN ('in_store', 'curbside', 'delivery', 'online')),
    FOREIGN KEY (customer_id) REFERENCES retail_lab.customers(customer_id),
    FOREIGN KEY (store_id) REFERENCES retail_lab.stores(store_id)
);