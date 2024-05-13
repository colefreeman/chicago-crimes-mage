
      
  
    

  create  table "CHICAGO_CRIMES"."snapshots"."snapshot_crimes_type"
  
  
    as
  
  (
    

    select *,
        md5(coalesce(cast(crimes_type_hkey as varchar ), '')
         || '|' || coalesce(cast(now()::timestamp without time zone as varchar ), '')
        ) as dbt_scd_id,
        now()::timestamp without time zone as dbt_updated_at,
        now()::timestamp without time zone as dbt_valid_from,
        nullif(now()::timestamp without time zone, now()::timestamp without time zone) as dbt_valid_to
    from (
        


WITH
    types_ref as (
        SELECT
            "primary_type"
        FROM "CHICAGO_CRIMES"."public"."crimes_silver"
        GROUP BY "primary_type"
    ),
    types_key as (
        SELECT
            *
            , md5(cast(coalesce(cast(primary_type as TEXT), '_dbt_utils_surrogate_key_null_') as TEXT)) as crimes_type_hkey
        FROM types_ref
    )

SELECT * FROM types_key

    ) sbq



  );
  
  