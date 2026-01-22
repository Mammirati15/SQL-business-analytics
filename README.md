# SQL Business Analytics

A small collection of SQL queries focused on common business analytics questions in eCommerce and subscription-style products.

The goal of this repo is to demonstrate how SQL can be used to answer real product and revenue questions — not to showcase every possible SQL feature.

## Schema used for the queries built

- customers(customer_id, country)
- orders(order_id, customer_id, order_date, order_amount)

## Included Analyses

- Monthly revenue and order volume
- Customer lifetime revenue and order count
- Repeat vs one-time customer classification
- Average time between customer orders
- Revenue concentration across top customers
- Revenue decay after first purchase
- Cohort-based retention analysis

Each query is written to be readable and easy to reason about, with brief comments explaining the intent.
