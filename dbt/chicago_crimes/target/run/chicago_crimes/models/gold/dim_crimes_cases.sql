
  
    

  create  table "CHICAGO_CRIMES"."public"."dim_crimes_cases__dbt_tmp"
  
  
    as
  
  (
    

SELECT
    crimes_cases_hkey
    , case_number
FROM "CHICAGO_CRIMES"."snapshots"."snapshot_crimes_cases"
WHERE dbt_valid_to IS NULL
  );
  