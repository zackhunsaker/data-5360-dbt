{{ config(materialized='table', schema='dw_oliver') }}

-- Grain: one row per employee per certification awarded date
select
  e.employee_key,
  d.date_key,
  c.certification_name,
  c.certification_cost

from {{ ref('stg_employee_certifications') }} c
join {{ ref('oliver_dim_employee') }} e
    on lower(c.email) = lower(e.email)
join {{ ref('oliver_dim_date') }} d
    on d.date_day = c.certification_awarded_date
