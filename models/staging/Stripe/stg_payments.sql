select
    orderid as order_id,
    id as payment_id,
    amount / 100 as amount,
    created as created_at,
    paymentmethod as payment_method,
    status


from stripe.payment