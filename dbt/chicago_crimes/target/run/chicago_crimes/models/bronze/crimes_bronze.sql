
  create view "CHICAGO_CRIMES"."public"."crimes_bronze__dbt_tmp"
    
    
  as (
    
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
    
    FROM "CHICAGO_CRIMES"."public"."mage_chicago_crimes_convert_addresses"
),
    hashed_keys as (
        select
            md5(cast(coalesce(cast(crimes_id as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(case_number as TEXT), '_dbt_utils_surrogate_key_null_') as TEXT))
            as crimes_hkey
            , md5(cast(coalesce(cast(crimes_id as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(case_number as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(x_coordinate as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(y_coordinate as TEXT), '_dbt_utils_surrogate_key_null_') as TEXT)) as crimes_hdiff
            , *
            --'2024-05-08 17:50:35.996031+00:00' as load_ts_utc
        from source_data
    )
select *
from hashed_keys
  );