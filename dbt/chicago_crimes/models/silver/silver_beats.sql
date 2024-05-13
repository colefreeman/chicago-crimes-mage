{{ config(
    materialized='view'
) }}

SELECT
    beats_hkey
    , beats_hdiff
    , district
    , sector
    , beat
    , beat_number
    , load_ts_utc
FROM {{ ref('bronze_beats') }}