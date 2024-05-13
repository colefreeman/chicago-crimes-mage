

WITH
    date_hours as (
        SELECT
            *
            , date("crime_date") AS DATE_OF_CRIME
            ,-- Monday(1) to Sunday (7)
        cast(date_part('isodow', crime_date) as integer) as day_of_week
            , DATE_PART('hour', crime_date) AS hour_of_day
        FROM "CHICAGO_CRIMES"."snapshots"."crimes_snapshot"
        WHERE DBT_VALID_TO is null
    )
    
    --bronze_to_silver_crime_data

SELECT * --EXCLUDE CRIME_DATE
FROM date_hours