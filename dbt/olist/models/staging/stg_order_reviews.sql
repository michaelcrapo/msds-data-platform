with source as (
    select * from {{ source('raw', 'order_reviews') }}
),

renamed as (

    select 

        -- ids
        review_id,
        order_id,

        -- attributes
        safe_cast(review_score as int) as review_score,
        nullif(trim(review_comment_title), '') as review_comment_title,
        nullif(trim(review_comment_message), '') as review_comment_message,
        
        -- datetimes
        date(safe_cast(review_creation_date as datetime)) as review_creation_date,
        safe_cast(review_answer_timestamp as datetime) as review_answer_at


    from source

)

select * from renamed