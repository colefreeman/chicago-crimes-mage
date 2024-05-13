
  create view "CHICAGO_CRIMES"."public"."silver_beats__dbt_tmp"
    
    
  as (
    

SELECT
    beats_hkey
    , beats_hdiff
    , district
    , sector
    , beat
    , beat_number
    , load_ts_utc
FROM "CHICAGO_CRIMES"."public"."bronze_beats"
  );