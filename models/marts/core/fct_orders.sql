
--call stage payments
with payments as (

    select * from {{ref('stg_payments')}}

),

--call stage orders
orders as(

    select * from {{ ref('stg_orders') }}

),

--get the sum total of the amount that each customer has spent.
order_payments as (

    select
        order_id,
        sum(case when status = 'success' then amount end) as amount

    from payments
    group by 1

),

--join together and select all of the relevant data.
final as (

    select 
        orders.order_id,
        orders.customer_id,
        orders.order_date,
        coalesce(order_payments.amount, 0) as amount
    
    from orders
    left join order_payments using (order_id)

)


--retrieve final data.
select * from final

