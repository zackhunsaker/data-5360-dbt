{{ config(materialized='table', schema='dw_oliver') }}

select
  PRODUCT_ID   as product_key,
  PRODUCT_ID,
  PRODUCT_NAME,
  DESCRIPTION,
  UNIT_PRICE
from {{ source('oliver_landing','product') }}
where coalesce(_FIVETRAN_DELETED, false) = false
