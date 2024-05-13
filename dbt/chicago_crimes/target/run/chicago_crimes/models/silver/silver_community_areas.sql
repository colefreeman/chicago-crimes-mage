
  create view "CHICAGO_CRIMES"."public"."silver_community_areas__dbt_tmp"
    
    
  as (
    

SELECT 
    community_area_hkey
    , community_area_hdiff
    , community_area_number
    , community_name
    , load_ts_utc
FROM "CHICAGO_CRIMES"."public"."bronze_community_areas"
  );