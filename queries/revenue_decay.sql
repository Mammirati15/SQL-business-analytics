-- Revenue decay analysis
-- Tracks how customer revenue changes over time since first purchase

WITH first_orders AS (
    SELECT
        customer_id,
        MIN(order_date) AS first_order_date
    FROM orders
    GROUP BY customer_id
),
orders_with_age AS (
    SELECT
        o.customer_id,
        o.order_date,
        o.order_amount,
        f.first_order_date,
        DATE_PART('day', o.order_date - f.first_order_date) AS days_since_first_order
    FROM orders o
    JOIN first_orders f
        ON o.customer_id = f.customer_id
),
bucketed_revenue AS (
    SELECT
        FLOOR(days_since_first_order / 30) AS month_since_first_order,
        SUM(order_amount) AS total_revenue,
        COUNT(DISTINCT customer_id) AS active_customers
    FROM orders_with_age
    GROUP BY FLOOR(days_since_first_order / 30)
)
SELECT
    month_since_first_order,
    total_revenue,
    active_customers,
    total_revenue * 1.0 / active_customers AS revenue_per_customer
FROM bucketed_revenue
ORDER BY month_since_first_order;
``
