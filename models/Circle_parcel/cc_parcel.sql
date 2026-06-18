SELECT
    p.parcel_id,
    p.parcel_tracking,
    p.transporter,
    p.priority,

    SAFE.PARSE_DATE('%B %d, %Y', p.purchase_date) AS date_purchase,
    SAFE.PARSE_DATE('%B %d, %Y', p.shipping_date) AS date_shipping,
    SAFE.PARSE_DATE('%B %d, %Y', p.delivery_date) AS date_delivery,
    SAFE.PARSE_DATE('%B %d, %Y', p.cancelled_date) AS date_cancelled,

    EXTRACT(MONTH FROM SAFE.PARSE_DATE('%B %d, %Y', p.purchase_date)) AS month_purchase,

    CASE
        WHEN p.cancelled_date IS NOT NULL THEN 'Cancelled'
        WHEN p.delivery_date IS NOT NULL THEN 'Delivered'
        WHEN p.shipping_date IS NOT NULL THEN 'In Transit'
        ELSE 'In Progress'
    END AS status,

    DATE_DIFF(
        SAFE.PARSE_DATE('%B %d, %Y', p.shipping_date),
        SAFE.PARSE_DATE('%B %d, %Y', p.purchase_date),
        DAY
    ) AS expedition_time,

    DATE_DIFF(
        SAFE.PARSE_DATE('%B %d, %Y', p.delivery_date),
        SAFE.PARSE_DATE('%B %d, %Y', p.shipping_date),
        DAY
    ) AS transport_time,

    DATE_DIFF(
        SAFE.PARSE_DATE('%B %d, %Y', p.delivery_date),
        SAFE.PARSE_DATE('%B %d, %Y', p.purchase_date),
        DAY
    ) AS delivery_time,

    DATE_DIFF(
        SAFE.PARSE_DATE('%B %d, %Y', p.delivery_date),
        SAFE.PARSE_DATE('%B %d, %Y', p.shipping_date),
        DAY
    ) AS delay,

    SUM(pp.quantity) AS qty,
    COUNT(DISTINCT pp.model_name) AS nb_model

FROM {{ ref('stg_cc_parcel') }} p

LEFT JOIN {{ ref('stg_cc_parcel_product') }} pp
    ON p.parcel_id = pp.parcel_id

GROUP BY
    p.parcel_id,
    p.parcel_tracking,
    p.transporter,
    p.priority,
    p.purchase_date,
    p.shipping_date,
    p.delivery_date,
    p.cancelled_date