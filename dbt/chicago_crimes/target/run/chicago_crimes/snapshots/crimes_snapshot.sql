
      update "CHICAGO_CRIMES"."snapshots"."crimes_snapshot"
    set dbt_valid_to = DBT_INTERNAL_SOURCE.dbt_valid_to
    from "crimes_snapshot__dbt_tmp092750097548" as DBT_INTERNAL_SOURCE
    where DBT_INTERNAL_SOURCE.dbt_scd_id::text = "CHICAGO_CRIMES"."snapshots"."crimes_snapshot".dbt_scd_id::text
      and DBT_INTERNAL_SOURCE.dbt_change_type::text in ('update'::text, 'delete'::text)
      and "CHICAGO_CRIMES"."snapshots"."crimes_snapshot".dbt_valid_to is null;

    insert into "CHICAGO_CRIMES"."snapshots"."crimes_snapshot" ("crimes_hkey", "crimes_hdiff", "crimes_id", "case_number", "crime_date", "address", "iucr", "primary_type", "description", "location_description", "arrest", "domestic", "beat", "district", "ward", "community_area", "x_coordinate", "y_coordinate", "crime_year", "updated_on", "lat", "lng", "location", "dbt_updated_at", "dbt_valid_from", "dbt_valid_to", "dbt_scd_id")
    select DBT_INTERNAL_SOURCE."crimes_hkey",DBT_INTERNAL_SOURCE."crimes_hdiff",DBT_INTERNAL_SOURCE."crimes_id",DBT_INTERNAL_SOURCE."case_number",DBT_INTERNAL_SOURCE."crime_date",DBT_INTERNAL_SOURCE."address",DBT_INTERNAL_SOURCE."iucr",DBT_INTERNAL_SOURCE."primary_type",DBT_INTERNAL_SOURCE."description",DBT_INTERNAL_SOURCE."location_description",DBT_INTERNAL_SOURCE."arrest",DBT_INTERNAL_SOURCE."domestic",DBT_INTERNAL_SOURCE."beat",DBT_INTERNAL_SOURCE."district",DBT_INTERNAL_SOURCE."ward",DBT_INTERNAL_SOURCE."community_area",DBT_INTERNAL_SOURCE."x_coordinate",DBT_INTERNAL_SOURCE."y_coordinate",DBT_INTERNAL_SOURCE."crime_year",DBT_INTERNAL_SOURCE."updated_on",DBT_INTERNAL_SOURCE."lat",DBT_INTERNAL_SOURCE."lng",DBT_INTERNAL_SOURCE."location",DBT_INTERNAL_SOURCE."dbt_updated_at",DBT_INTERNAL_SOURCE."dbt_valid_from",DBT_INTERNAL_SOURCE."dbt_valid_to",DBT_INTERNAL_SOURCE."dbt_scd_id"
    from "crimes_snapshot__dbt_tmp092750097548" as DBT_INTERNAL_SOURCE
    where DBT_INTERNAL_SOURCE.dbt_change_type::text = 'insert'::text;

  