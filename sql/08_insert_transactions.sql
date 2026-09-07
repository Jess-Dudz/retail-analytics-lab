-- Seed synthetic transaction data for analysis practice.
-- Gold customers receive 6 transactions,
-- silver customers receive 4,
-- standard customers receive 3.

INSERT INTO retail_lab.transactions (
    customer_id,
    store_id,
    transaction_ts,
    total_amount,
    purchase_channel
)
SELECT
    c.customer_id,

    -- Assign a valid store_id from 1 through 15
    ((c.customer_id + g.n * 3) % 15) + 1 AS store_id,

    -- Create varied transaction dates and times during 2026
    TIMESTAMP '2026-01-01 08:00:00'
        + (((c.customer_id * 17 + g.n * 11) % 240) * INTERVAL '1 day')
        + (((c.customer_id * 3 + g.n * 2) % 14) * INTERVAL '1 hour')
        + (((c.customer_id * 7 + g.n * 13) % 60) * INTERVAL '1 minute')
        AS transaction_ts,

    -- Create varied transaction amounts,
    -- with slightly different spending patterns by loyalty tier
    ROUND(
        (
            CASE
                WHEN c.loyalty_status = 'gold' THEN 40
                WHEN c.loyalty_status = 'silver' THEN 28
                ELSE 18
            END
            + ((c.customer_id * 19 + g.n * 23) % 7000) / 100.0
        )::NUMERIC,
        2
    ) AS total_amount,

    -- Rotate through the four allowed purchase channels
    (ARRAY['in_store', 'curbside', 'delivery', 'online'])
        [((c.customer_id + g.n) % 4) + 1]
        AS purchase_channel

FROM retail_lab.customers AS c

CROSS JOIN LATERAL generate_series(
    1,
    CASE
        WHEN c.loyalty_status = 'gold' THEN 6
        WHEN c.loyalty_status = 'silver' THEN 4
        ELSE 3
    END
) AS g(n);