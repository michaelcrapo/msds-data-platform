with source as (
    select * from {{ source('raw', 'order_payments') }}
),

renamed as (

    select 
        -- ids
        order_id,
        safe_cast(payment_sequential as int) as payment_sequential,
        -- attributes
        payment_type,
        safe_cast(payment_installments as int) as payment_installments,
        safe_cast(payment_value as numeric) as payment_value

    from source

)

select * from renamed