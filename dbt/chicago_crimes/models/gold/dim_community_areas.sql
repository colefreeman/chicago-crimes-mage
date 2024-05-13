{{ config(
    materialized='table'
) }}

SELECT *
FROM {{ ref('silver_community_areas') }}