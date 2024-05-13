{% snapshot crimes_snapshot %}

{{
    config(
        strategy='timestamp',
        unique_key='crimes_hkey',
        updated_at='updated_on'
    )
}}

SELECT * FROM {{ ref('crimes_bronze') }}

{% endsnapshot %}