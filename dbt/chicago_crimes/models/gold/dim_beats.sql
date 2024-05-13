{{ config(
    materialized='table'
) }}

SELECT *
FROM {{ ref('silver_beats') }}