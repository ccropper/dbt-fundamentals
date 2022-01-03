with payments as (
    select * 
    from {{ ref('stg_payments') }}
),

orders as (
    select * 
    from {{ ref('stg_orders') }}
),

order_payments as (
    select
        order_id,
        sum(case when status = 'success' then payment_amount end) as amount

    from payments
    group by 1
),

final as (
    select 
        o.order_id,
        o.customer_id,
        coalesce(p.amount, 0.00) as amount
    from orders o
    left join order_payments p on o.order_id = p.order_id
)

select * from final
