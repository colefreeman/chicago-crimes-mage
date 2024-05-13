
      
  
    

  create  table "CHICAGO_CRIMES"."snapshots"."snapshot_crimes_description"
  
  
    as
  
  (
    

    select *,
        md5(coalesce(cast(crimes_description_hkey as varchar ), '')
         || '|' || coalesce(cast(now()::timestamp without time zone as varchar ), '')
        ) as dbt_scd_id,
        now()::timestamp without time zone as dbt_updated_at,
        now()::timestamp without time zone as dbt_valid_from,
        nullif(now()::timestamp without time zone, now()::timestamp without time zone) as dbt_valid_to
    from (
        


WITH
    description_ref as (
        SELECT
            "description" as crime_description
        FROM "CHICAGO_CRIMES"."public"."crimes_silver"
        GROUP BY "crime_description"
    ),
    description_key as (
        SELECT
            *
            , md5(cast(coalesce(cast(crime_description as TEXT), '_dbt_utils_surrogate_key_null_') as TEXT)) as crimes_description_hkey
        FROM description_ref
    )

SELECT * FROM description_key

    ) sbq



  );
  
  