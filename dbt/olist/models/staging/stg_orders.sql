with source as (
    select * from {{ source('raw', 'orders') }}
),

renamed as (
    select
        -- ids
        order_id,
        customer_id,

        -- attributes
        order_status,

        -- timestamps
        -- use datetime to keep track of clock time.  will need to remember time zone in the future
        safe_cast(order_purchase_timestamp as datetime) as purchased_at,
        safe_cast(order_approved_at as datetime) as approved_at,
        safe_cast(order_delivered_carrier_date as datetime) as delivered_to_carrier_at,
        safe_cast(order_delivered_customer_date as datetime) as delivered_to_customer_at,
        date(safe_cast(order_estimated_delivery_date as datetime)) as estimated_delivery_date
    from source
)
select * from renamed