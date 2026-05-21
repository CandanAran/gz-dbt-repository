SELECT
orders_id,
MIN(date_date) AS date_date,
ROUND(SUM(revenue), 1) AS revenue,
SUM(quantity) AS quantity,
ROUND(SUM(purchase_cost), 1) AS purchase_cost,
ROUND(SUM(margin), 1) AS margin

FROM {{ ref('int_sales_margin') }}
GROUP BY orders_id