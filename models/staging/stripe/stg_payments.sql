select 
    id as payment_id,
    orderid as order_id,
    paymentmethod as payment_method,
    status,
    -- amount from Stripe is represented in cents
    {{ cents_to_dollars('amount') }} as payment_amount,
    created as payment_created_at,
    _batched_at as payment_batched_at
from {{ source('stripe', 'payment') }}