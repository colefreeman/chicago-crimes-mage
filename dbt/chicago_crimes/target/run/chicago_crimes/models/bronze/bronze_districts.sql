
  create view "CHICAGO_CRIMES"."public"."bronze_districts__dbt_tmp"
    
    
  as (
    
WITH
src_data_district as (
    SELECT
        "the_geom" AS shape_map --Text
        , "DIST_NUM" AS district_number --Number
        , "DIST_LABEL" AS district_name --Number
        
    FROM "CHICAGO_CRIMES"."public"."districts"
),
    hashed_beats_data as (
        SELECT
        md5(cast(coalesce(cast(district_number as TEXT), '_dbt_utils_surrogate_key_null_') as TEXT)) as districts_hkey
        , md5(cast(coalesce(cast(district_number as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(district_name as TEXT), '_dbt_utils_surrogate_key_null_') as TEXT)) as districts_hdiff
        , *
        , '2024-05-08 17:50:35.996031+00:00' as load_ts_utc
        FROM src_data_district
    )
SELECT * FROM hashed_beats_data
  );