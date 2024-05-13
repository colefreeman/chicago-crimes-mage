
  create view "CHICAGO_CRIMES"."public"."bronze_beats__dbt_tmp"
    
    
  as (
    

WITH
src_data_beats as (
    SELECT
        "the_geom" AS shape_map --Text
        , "DISTRICT" AS district --Number
        , "SECTOR" AS sector --Number
        , "BEAT" AS beat --Number
        , "BEAT_NUM" AS beat_number --Number
        
    FROM "CHICAGO_CRIMES"."public"."beats"
),
    hashed_beats_data as (
        SELECT
        md5(cast(coalesce(cast(beat_number as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(beat as TEXT), '_dbt_utils_surrogate_key_null_') as TEXT)) as beats_hkey
        , md5(cast(coalesce(cast(beat_number as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(beat as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(sector as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(district as TEXT), '_dbt_utils_surrogate_key_null_') as TEXT)) as beats_hdiff
        , *
        , '2024-05-08 17:50:35.996031+00:00' as load_ts_utc
        FROM src_data_beats
    )
SELECT * FROM hashed_beats_data
  );