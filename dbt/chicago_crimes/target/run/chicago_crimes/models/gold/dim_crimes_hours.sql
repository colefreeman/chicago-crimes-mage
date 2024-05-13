
  
    

  create  table "CHICAGO_CRIMES"."public"."dim_crimes_hours__dbt_tmp"
  
  
    as
  
  (
    

SELECT
    daily_hour
    , ROW_NUMBER () OVER (ORDER BY "daily_hour") AS hour_id 
FROM "CHICAGO_CRIMES"."snapshots"."snapshot_crimes_hours"
WHERE dbt_valid_to IS NULL
ORDER BY hour_id
  );
  