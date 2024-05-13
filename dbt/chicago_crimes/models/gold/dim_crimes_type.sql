{{
    config(
        materialized='table'
    )
}}

SELECT
    "primary_type"
    , "crimes_type_hkey"
FROM {{ ref('snapshot_crimes_type') }}
WHERE dbt_valid_to IS NULL