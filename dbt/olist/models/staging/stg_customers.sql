with source as (
    select * from {{ source('raw', 'customers') }}
),

renamed as (

    select 
        -- id
        customer_id,
        customer_unique_id,

        -- attributes
        customer_zip_code_prefix,
        customer_city,
        customer_state
        

    from source

)

select * from renamed