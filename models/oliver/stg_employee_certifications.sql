{{ config(materialized='table', schema='dw_oliver') }}

select
  EMPLOYEE_ID,
  FIRST_NAME,
  LAST_NAME,
  EMAIL,
  -- Parse JSON fields from the CERTIFICATION_JSON column
  (parse_json(CERTIFICATION_JSON):certification_name)::string           as certification_name,
  (parse_json(CERTIFICATION_JSON):certification_cost)::float            as certification_cost,
  try_to_date((parse_json(CERTIFICATION_JSON):certification_awarded_date)::string) as certification_awarded_date
from ZACKHUNSAKER.oliver_dw_source.employee_certifications
