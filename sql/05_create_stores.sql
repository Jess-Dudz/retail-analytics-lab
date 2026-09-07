CREATE TABLE retail_lab.stores (
    store_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    store_name VARCHAR(100) NOT NULL,
    city VARCHAR(50) NOT NULL,
    state VARCHAR(50) NOT NULL,
    zip_code VARCHAR(5) NOT NULL,
    open_date DATE NOT NULL,
    store_type VARCHAR(50) NOT NULL
        CHECK (store_type IN ('standard', 'travel_stop', 'urban', 'suburban'))
);