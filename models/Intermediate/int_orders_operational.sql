SELECT
o.*,
ROUND((o.margin + sh.shipping_fee) - sh.logcost - sh.ship_cost, 2) AS operational_margin,
sh.shipping_fee,
sh.logcost,
sh.ship_cost

FROM {{ ref('int_orders_margin') }} o
LEFT JOIN {{ ref('stg_raw__ship') }} sh
ON o.orders_id = sh.orders_id
