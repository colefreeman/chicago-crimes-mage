{{
    config(
        materialized='view'
    )
}}

WITH
    date_hours as (
        SELECT
            *
            , date("crime_date") AS DATE_OF_CRIME
            ,{{ dbt_date.day_of_week("crime_date", isoweek=true) }} as day_of_week
            , DATE_PART('hour', crime_date) AS hour_of_day
        FROM {{ ref('crimes_snapshot') }}
        WHERE DBT_VALID_TO is null
    )
    
    --bronze_to_silver_crime_data

SELECT *
FROM date_hours