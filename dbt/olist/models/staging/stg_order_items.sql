with source as (
    select * from {{ source('raw', 'order_items') }}
),

renamed as (

    select 

        -- ids
        order_id,
        safe_cast(order_item_id as int) as order_item_id,
        product_id,
        seller_id,
        
        -- date
        safe_cast(shipping_limit_date as datetime) as shipping_limit_at,
        
        -- pricing
        safe_cast(price as numeric) as price, 
        safe_cast(freight_value as numeric) as freight_value
        

    from source

)

select * from renamed