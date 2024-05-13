{{
    config(
        materialized='view'
    )
}}
WITH source_data as (
    SELECT
        "id" AS crimes_id
        , "case_number"
        , "crime_date"
        , "block" AS address
        , "iucr"
        , "primary_type"
        , "description"
        , "location_description"
        , "arrest"
        , "domestic"
        , "beat"
        , "district"
        , "ward"
        , "community_area"
        , "x_coordinate"
        , "y_coordinate"
        , "crime_year"
        , "updated_on"
        , "lat"
        , "lng"
        , "location"
    
    FROM {{ source('mage_chicago_crimes', 'chicago_crimes_convert_addresses') }}
),
    hashed_keys as (
        select
            {{ dbt_utils.generate_surrogate_key(["crimes_id", "case_number"]) }}
            as crimes_hkey
            , {{
                dbt_utils.generate_surrogate_key(
                    ["crimes_id", "case_number", "x_coordinate", "y_coordinate"]
                )
            }} as crimes_hdiff
            , *
            --'{{ run_started_at }}' as load_ts_utc
        from source_data
    )
select *
from hashed_keys