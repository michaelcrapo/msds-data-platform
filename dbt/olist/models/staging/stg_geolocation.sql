with source as (
    select * from {{ source('raw', 'geolocation') }}
),
renamed as (

    select 
        geolocation_zip_code_prefix,
        safe_cast(geolocation_lat as float) as geolocation_lat,
        safe_cast(geolocation_lng as float) as geolocation_lng,
        geolocation_city,
        geolocation_state
    from source

)

select * from renamed