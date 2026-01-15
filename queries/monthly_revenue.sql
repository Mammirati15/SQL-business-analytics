-- Purpose:
-- Analyze monthly revenue and order volume over time
--
-- Output:
-- - month
-- - total_revenue
-- - order_count
-- - avg_order_value

SELECT
    DATE_TRUNC('month', order_date) AS month,
    SUM(order_amount) AS total_revenue,
    COUNT(order_id) AS order_count,
    AVG(order_amount) AS avg_order_value
FROM orders
GROUP BY 1
ORDER BY month;
