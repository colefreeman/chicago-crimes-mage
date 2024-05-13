
  create view "CHICAGO_CRIMES"."public"."bronze_community_areas__dbt_tmp"
    
    
  as (
    
WITH
src_data_community_area as (
    SELECT
        "the_geom" AS shape_map
        , "PERIMETER" AS perimeter 
        , "AREA" AS area 
        , "COMAREA_" AS comarea 
        , "COMAREA_ID" AS comarea_id 
        , "AREA_NUMBE" AS community_area_number 
        , "COMMUNITY" AS community_name
        , "AREA_NUM_1" AS area_num_1 
        , "SHAPE_AREA" AS shape_area 
        , "SHAPE_LEN" AS shape_len
        
    FROM "CHICAGO_CRIMES"."public"."community_areas"
),
    hashed_beats_data as (
        SELECT
        md5(cast(coalesce(cast(community_area_number as TEXT), '_dbt_utils_surrogate_key_null_') as TEXT)) as community_area_hkey
        , md5(cast(coalesce(cast(community_area_number as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(community_name as TEXT), '_dbt_utils_surrogate_key_null_') as TEXT)) as community_area_hdiff
        , *
        , '2024-05-08 17:50:35.996031+00:00' as load_ts_utc
        FROM src_data_community_area
    )
SELECT * FROM hashed_beats_data
  );