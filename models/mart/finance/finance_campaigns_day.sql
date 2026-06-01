SELECT
    f.date_date AS date,
    f.operational_margin - COALESCE(c.ads_cost, 0) AS ads_margin,
    f.average_basket,
    f.operational_margin,
    COALESCE(c.ads_cost, 0) AS ads_cost,
    COALESCE(c.impression, 0) AS ads_impression,
    COALESCE(c.click, 0) AS ads_clicks, 
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