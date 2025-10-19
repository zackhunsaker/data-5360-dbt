{{ config(materialized='table', schema='dw_oliver') }}

select
  EMPLOYEE_ID  as employee_key,
  EMPLOYEE_ID,
  FIRST_NAME,
  LAST_NAME,
  EMAIL,
  PHONE_NUMBER,
  POSITION,
  HIRE_DATE
from {{ source('oliver_landing','employee') }}
where coalesce(_FIVETRAN_DELETED, false) = false
