
  
    

  create  table "CHICAGO_CRIMES"."public"."dim_crimes_type__dbt_tmp"
  
  
    as
  
  (
    

SELECT
    "primary_type"
    , ROW_NUMBER () OVER (ORDER BY "primary_type") AS crime_type_id
FROM "CHICAGO_CRIMES"."public"."crimes_silver"
GROUP BY "primary_type"
ORDER BY "primary_type"
  );
  