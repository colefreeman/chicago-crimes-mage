{{ config(
    materialized='table'
) 
}}

SELECT
    crime_description
    , crimes_description_hkey
FROM{{ ref('snapshot_crimes_description') }}
WHERE dbt_valid_to IS NULL