{{
    config(
        materialized='table'
    )
}}

SELECT
    crimes_cases_hkey
    , case_number
FROM {{ ref('snapshot_crimes_cases') }}
WHERE dbt_valid_to IS NULL 