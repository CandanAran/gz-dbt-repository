SELECT
    `Parcel_id` AS parcel_id,
    `Parcel_tracking` AS parcel_tracking,
    `Transporter` AS transporter,
    `Priority` AS priority,
    `Date_purCHase` AS purchase_date,
    `Date_sHIpping` AS shipping_date,
    `DATE_delivery` AS delivery_date,
    `DaTeCANcelled` AS cancelled_date

FROM {{ source('raw_data_circle', 'raw_cc_parcel') }}