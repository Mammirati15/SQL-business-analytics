-- Purpose:
-- Identify repeat vs one-time customers based on order history
--
-- Output:
-- - customer_id
-- - order_count
-- - customer_type (one_time | repeat)

WITH order_counts AS (
    SELECT
        customer_id,
        COUNT(order_id) AS order_count
    FROM orders
    GROUP BY customer_id
)

SELECT
    customer_id,
    order_count,
    CASE
        WHEN order_count = 1 THEN 'one_time'
        ELSE 'repeat'
    END AS customer_type
FROM order_counts
ORDER BY order_count DESC;
