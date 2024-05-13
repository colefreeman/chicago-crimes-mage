{% snapshot snapshot_crimes_cases %}

{{
    config(
        strategy='check',
        unique_key='crimes_cases_hkey',
        check_cols=['crimes_cases_hkey']
    )
}}
WITH
    cases_ref as (
        SELECT
            "case_number"
        FROM {{ ref('crimes_silver') }}
        GROUP BY "case_number"
    ),
    cases_key as (
        SELECT
            *
            , {{ dbt_utils.generate_surrogate_key(["case_number"]) }} as crimes_cases_hkey
        FROM cases_ref
    )

SELECT * FROM cases_key

{% endsnapshot %}