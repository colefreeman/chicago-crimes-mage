{{ config(
    materialized='table'
) }}

SELECT *
FROM {{ ref('silver_districts') }}