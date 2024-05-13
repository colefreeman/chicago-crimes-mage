
  
    

  create  table "CHICAGO_CRIMES"."public"."dim_districts__dbt_tmp"
  
  
    as
  
  (
    

SELECT *
FROM "CHICAGO_CRIMES"."public"."silver_districts"
  );
  