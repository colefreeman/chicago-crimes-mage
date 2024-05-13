{% snapshot snapshot_crimes_description %}

{{
    config(
        strategy='check',
        unique_key='crimes_description_hkey',
        check_cols=['crimes_description_hkey']
    )
}}
WITH
    description_ref as (
        SELECT
            "description" as crime_description
        FROM {{ ref('crimes_silver') }}
        GROUP BY "crime_description"
    ),
    description_key as (
        SELECT
            *
            , {{ dbt_utils.generate_surrogate_key(["crime_description"]) }} as crimes_description_hkey
        FROM description_ref
    )

SELECT * FROM description_key

{% endsnapshot %}