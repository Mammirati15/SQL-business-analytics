-- Customer revenue summary
--
-- Tables:
-- customers(customer_id, signup_date, country)
-- orders(order_id, customer_id, order_date, order_amount)
--
-- Goal:
-- For each customer:
--   - first order date
--   - total lifetime revenue
--   - number of orders
--   - revenue rank within country

WITH customer_summary AS (
    SELECT
        c.customer_id,
        c.country,
        MIN(o.order_date) AS first_order_date,
        SUM(o.order_amount) AS total_revenue,
        COUNT(o.order_id) AS order_count
    FROM customers c
    JOIN orders o
      ON c.customer_id = o.customer_id
    GROUP BY
        c.customer_id,
        c.country
)

SELECT
    customer_id,
    first_order_date,
    total_revenue,
    order_count,
    RANK() OVER (
        PARTITION BY country
        ORDER BY total_revenue DESC
    ) AS revenue_rank_in_country
FROM customer_summary;


