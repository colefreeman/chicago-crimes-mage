
  
    

  create  table "CHICAGO_CRIMES"."public"."dim_community_areas__dbt_tmp"
  
  
    as
  
  (
    

SELECT *
FROM "CHICAGO_CRIMES"."public"."silver_community_areas"
  );
  