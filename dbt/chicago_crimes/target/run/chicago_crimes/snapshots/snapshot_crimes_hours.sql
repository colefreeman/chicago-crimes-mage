
      
  
    

  create  table "CHICAGO_CRIMES"."snapshots"."snapshot_crimes_hours"
  
  
    as
  
  (
    

    select *,
        md5(coalesce(cast(crimes_hour_hkey as varchar ), '')
         || '|' || coalesce(cast(now()::timestamp without time zone as varchar ), '')
        ) as dbt_scd_id,
        now()::timestamp without time zone as dbt_updated_at,
        now()::timestamp without time zone as dbt_valid_from,
        nullif(now()::timestamp without time zone, now()::timestamp without time zone) as dbt_valid_to
    from (
        


WITH
    hours_ref as (
        SELECT
            "hour_of_day" AS daily_hour
        FROM "CHICAGO_CRIMES"."public"."crimes_silver"
        GROUP BY daily_hour
    ),
    hours_key as (
        SELECT
            *
            , md5(cast(coalesce(cast(daily_hour as TEXT), '_dbt_utils_surrogate_key_null_') as TEXT)) as crimes_hour_hkey
        FROM hours_ref
    )

SELECT * FROM hours_key



    ) sbq



  );
  
  