
  
    

  create  table "CHICAGO_CRIMES"."public"."dim_beats__dbt_tmp"
  
  
    as
  
  (
    

SELECT *
FROM "CHICAGO_CRIMES"."public"."silver_beats"
  );
  