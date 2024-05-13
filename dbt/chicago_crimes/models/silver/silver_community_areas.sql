{{ config(
    materialized='view'
) }}

SELECT 
    community_area_hkey
    , community_area_hdiff
    , community_area_number
    , community_name
    , load_ts_utc
FROM {{ ref('bronze_community_areas')}}