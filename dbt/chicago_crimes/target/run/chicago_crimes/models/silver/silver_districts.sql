
  create view "CHICAGO_CRIMES"."public"."silver_districts__dbt_tmp"
    
    
  as (
    

SELECT
    districts_hkey
    , districts_hdiff
    , district_number
    , district_name
    , load_ts_utc
FROM "CHICAGO_CRIMES"."public"."bronze_districts"
  );