
## Table overview

* raw.customers:
    - grain: one row per order, metadata for customer
    - customer_id: key to orders dataset
    - customer_unique_id: unique identifier for customer
    - keys: customer_id + customer_unique_id
* raw.geolocation:
    - grain: location data for zipcode/lat lon.  use to plot maps, find distances btwn sellers&customers
    - key: zip_code_prefix, key btwn sellers and order_customer
* raw.order_items:
    - key: order_id + order_item_id + product_id + seller_id
    - use order_item_id to see # of purchases of item in single order
        > total order_item value: sum of price of each item in unique order_id
        > total freight: sum of freight value
        > total order value is: sum of all price and freight
    - merge orders, products, sellers tables
* raw.order_payments:
    - join with order_items
    - data about orders payment options
    - key: order_id
    - idea is customer can pay in installments, with different forms of pmt. 
* raw.order_reviews:
    - reviews made by customer for each order
    - key: review_id + order_id
    - join with orders
* raw.orders: 
    - core dataset. every other dataset is joined with this using order id.  
    - grain: 
    - key: order_id + customer_id
    - rows: 
* raw.products:
    - data about products sold by olist
    - key: product_id
    - join with order_items
* raw.sellers:
    - data about each seller that fullfilled order.  find location of seller and id of seller that fulfilled order
    - key: seller_id
    - join with order_items
* raw.product_category_name_translation:
    - category key to translate to from portuguese to english



# interesting question
* what do the top 10% customers have to say about the products in reviews (what is frequency of each score)
* what are the reasons sited n the 1-3 star reviews.  what are the key reviews in 4-5
* who are the top sellers by total sales.  
* does the famous "80/20" rule for sales volume and customers apply to each product?
