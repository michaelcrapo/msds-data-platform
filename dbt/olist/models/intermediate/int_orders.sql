with orders as (
    select * from {{ ref('stg_orders') }}
),

order_items as (
    -- one row per order: item count, total price, total freight
    select 
        order_id,
        count(order_id) as item_count,
        sum(price) as total_price,
        sum(freight_value) as total_freight_value

    from {{ ref('stg_order_items') }}
    group by order_id
),

order_payments as (
    -- one row per order: total paid, number of payments, main payment type
    select 
        order_id,
        sum(payment_value) as total_paid,
        count(*) as number_of_payments,
        count(distinct payment_type) as payment_type_count,
        array_agg(payment_type order by payment_value desc, payment_sequential limit 1)[offset(0)] as main_payment_type

    from {{ ref('stg_order_payments') }}
    group by order_id
),

latest_review as (
    select
        order_id,
        review_score,
        review_comment_message is not null as has_review_comment

    from {{ ref('stg_order_reviews') }}
    qualify row_number() over(
        partition by order_id
        order by review_answer_at desc, review_id
    ) = 1
),
customers as (
    select customer_id, customer_unique_id from {{ ref('stg_customers') }}
),

final as (
    select 
        orders.*,

        customers.customer_unique_id,

        order_items.item_count,
        order_items.total_price,
        order_items.total_freight_value,
        order_items.total_price + order_items.total_freight_value as order_total,

        order_payments.total_paid,
        order_payments.number_of_payments,
        order_payments.payment_type_count,
        order_payments.main_payment_type,

        latest_review.review_score,
        latest_review.has_review_comment,

        -- flag for if delivered
        order_status='delivered' as is_delivered,
        -- positive = late
        date_diff(
            date(orders.delivered_to_customer_at), orders.estimated_delivery_date, day
        ) as delivery_delay_days,
        -- check for diff in paid and collected for pmt plans (interest can make diff)
        order_payments.total_paid - (order_items.total_price + order_items.total_freight_value) as payment_difference

    from orders
    left join customers using (customer_id)
    left join order_items using (order_id)
    left join order_payments using (order_id)
    left join latest_review using (order_id)
)

select * from final