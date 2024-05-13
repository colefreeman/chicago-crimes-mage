{% snapshot snapshot_crimes_type %}

{{
    config(
        strategy='check',
        unique_key='crimes_type_hkey',
        check_cols=['crimes_type_hkey']
    )
}}
WITH
    types_ref as (
        SELECT
            "primary_type"
        FROM {{ ref('crimes_silver') }}
        GROUP BY "primary_type"
    ),
    types_key as (
        SELECT
            *
            , {{ dbt_utils.generate_surrogate_key(["primary_type"]) }} as crimes_type_hkey
        FROM types_ref
    )

SELECT * FROM types_key

{% endsnapshot %}