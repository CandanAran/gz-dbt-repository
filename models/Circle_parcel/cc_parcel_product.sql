{{
  config(
    materialized='table',
    partition_by={
      "field": "date_purchase",
      "data_type": "date"
    }
  )
}}

SELECT
    p.parcel_id,
    pp.model_name,
    p.parcel_tracking,
    p.transporter,
    p.priority,
    p.date_purchase,
    p.date_shipping,
    p.date_delivery,
    p.date_cancelled,
    p.month_purchase,
    p.status,
    p.expedition_time,
    p.transport_time,
    p.delivery_time,
    p.delay,
    pp.quantity AS qty

FROM {{ ref('stg_cc_parcel_product') }} pp

LEFT JOIN {{ ref('cc_parcel') }} p
    ON pp.parcel_id = p.parcel_id