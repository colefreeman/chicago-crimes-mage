{{ config(
    materialized='table'
)
}}

SELECT
    daily_hour
    , ROW_NUMBER () OVER (ORDER BY "daily_hour") AS hour_id 
FROM {{ ref('snapshot_crimes_hours') }}
WHERE dbt_valid_to IS NULL
ORDER BY hour_id 