{{ config(
    materialized='view',
) }}

SELECT
    districts_hkey
    , districts_hdiff
    , district_number
    , district_name
    , load_ts_utc
FROM {{ ref('bronze_districts') }}