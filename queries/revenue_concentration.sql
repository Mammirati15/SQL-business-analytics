-- Revenue concentration analysis
-- Shows how revenue accumulates across customers ordered by lifetime value

WITH customer_revenue AS (
    SELECT
        customer_id,
        SUM(order_amount) AS total_revenue
    FROM orders
    GROUP BY customer_id
),
ranked_customers AS (
    SELECT
        customer_id,
        total_revenue,
        RANK() OVER (ORDER BY total_revenue DESC) AS revenue_rank,
        SUM(total_revenue) OVER (
            ORDER BY total_revenue DESC
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ) AS cumulative_revenue,
        SUM(total_revenue) OVER () AS overall_revenue
    FROM customer_revenue
)
SELECT
    customer_id,
    total_revenue,
    revenue_rank,
    cumulative_revenue,
    overall_revenue,
    cumulative_revenue * 1.0 / overall_revenue AS cumulative_revenue_pct
FROM ranked_customers
ORDER BY revenue_rank;
