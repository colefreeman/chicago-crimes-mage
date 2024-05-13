{% snapshot snapshot_crimes_hours %}

{{
    config(
        strategy='check',
        unique_key='crimes_hour_hkey',
        check_cols=['crimes_hour_hkey']
    )
}}
WITH
    hours_ref as (
        SELECT
            "hour_of_day" AS daily_hour
        FROM {{ ref('crimes_silver') }}
        GROUP BY daily_hour
    ),
    hours_key as (
        SELECT
            *
            , {{ dbt_utils.generate_surrogate_key(["daily_hour"]) }} as crimes_hour_hkey
        FROM hours_ref
    )

SELECT * FROM hours_key



{% endsnapshot %}