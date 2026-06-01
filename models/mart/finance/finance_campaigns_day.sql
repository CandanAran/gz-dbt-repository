SELECT
    f.date_date AS date,
    f.operational_margin - c.ads_cost AS ads_margin,
    f.average_basket,
    f.operational_margin,
    c.ads_cost,
    c.impression AS ads_impression,
    c.click AS ads_clicks,
    f.quantity,
    f.revenue,
    f.purchase_cost,
    f.margin,
    f.shipping_fee,
    f.logcost AS log_cost,
    f.ship_cost
FROM {{ ref('finance_days') }} AS f
LEFT JOIN {{ ref('int_campaigns_day') }} AS c
    ON f.date_date = c.date_date
ORDER BY date DESC