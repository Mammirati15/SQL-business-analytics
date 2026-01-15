-- Purpose:
-- Calculate the average number of days between consecutive orders for each customer
-- Output:
-- - customer_id
-- - avg_days_between_orders

WITH ordered_orders AS (
    SELECT
        customer_id,
        order_date,
        LAG(order_date) OVER (
            PARTITION BY customer_id
            ORDER BY order_date
        ) AS previous_order_date
    FROM orders
),

order_gaps AS (
    SELECT
        customer_id,
        DATE_DIFF(
            'day',
            previous_order_date,
            order_date
        ) AS days_between_orders
    FROM ordered_orders
    WHERE previous_order_date IS NOT NULL
)

SELECT
    customer_id,
    AVG(days_between_orders) AS avg_days_between_orders
FROM order_gaps
GROUP BY customer_id
ORDER BY avg_days_between_orders;
