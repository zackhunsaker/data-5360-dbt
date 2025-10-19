{{ config(materialized='table', schema='dw_oliver') }}

-- Grain: one row per order line (ORDER_LINE_ID)
select
  p.product_key,
  c.customer_key,
  e.employee_key,
  s.store_key,
  d.date_key,

  o.ORDER_ID,
  ol.ORDER_LINE_ID,
  ol.QUANTITY,
  ol.UNIT_PRICE,
  (ol.QUANTITY * ol.UNIT_PRICE)::number(18,2) as line_amount
from {{ source('oliver_landing','orderline') }} ol
join {{ source('oliver_landing','orders') }}   o  on ol.ORDER_ID   = o.ORDER_ID
join {{ ref('oliver_dim_product') }}   p  on ol.PRODUCT_ID  = p.PRODUCT_ID
join {{ ref('oliver_dim_customer') }}  c  on o.CUSTOMER_ID  = c.CUSTOMER_ID
join {{ ref('oliver_dim_employee') }}  e  on o.EMPLOYEE_ID  = e.EMPLOYEE_ID
join {{ ref('oliver_dim_store') }}     s  on o.STORE_ID     = s.STORE_ID
join {{ ref('oliver_dim_date') }}      d  on d.date_day     = o.ORDER_DATE
where coalesce(ol._FIVETRAN_DELETED, false) = false
  and coalesce(o._FIVETRAN_DELETED,  false) = false
