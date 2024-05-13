
      
  
    

  create  table "CHICAGO_CRIMES"."snapshots"."snapshot_crimes_cases"
  
  
    as
  
  (
    

    select *,
        md5(coalesce(cast(crimes_cases_hkey as varchar ), '')
         || '|' || coalesce(cast(now()::timestamp without time zone as varchar ), '')
        ) as dbt_scd_id,
        now()::timestamp without time zone as dbt_updated_at,
        now()::timestamp without time zone as dbt_valid_from,
        nullif(now()::timestamp without time zone, now()::timestamp without time zone) as dbt_valid_to
    from (
        


WITH
    cases_ref as (
        SELECT
            "case_number"
        FROM "CHICAGO_CRIMES"."public"."crimes_silver"
        GROUP BY "case_number"
    ),
    cases_key as (
        SELECT
            *
            , md5(cast(coalesce(cast(case_number as TEXT), '_dbt_utils_surrogate_key_null_') as TEXT)) as crimes_cases_hkey
        FROM cases_ref
    )

SELECT * FROM cases_key

    ) sbq



  );
  
  