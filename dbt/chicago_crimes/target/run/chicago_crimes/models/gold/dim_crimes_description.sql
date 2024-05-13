
  
    

  create  table "CHICAGO_CRIMES"."public"."dim_crimes_description__dbt_tmp"
  
  
    as
  
  (
    

SELECT
    crime_description
    , crimes_description_hkey
FROM"CHICAGO_CRIMES"."snapshots"."snapshot_crimes_description"
WHERE dbt_valid_to IS NULL
  );
  