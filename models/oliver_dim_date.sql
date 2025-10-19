{{ config(materialized='table', schema='dw_oliver') }}

with cte_date as (
  select
      seq4() as day_num,
      dateadd(day, seq4(), '1990-01-01') as date_day
  from table(generator(rowcount => 22000))
)
select
  date_day as date_key,
  date_day,
  dayofweek(date_day) as day_of_week,
  month(date_day) as month_of_year,
  monthname(date_day) as month_name,
  quarter(date_day) as quarter_of_year,
  year(date_day) as year_number
from cte_date
