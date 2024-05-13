

SELECT
    crime_description
    , crimes_description_hkey
FROM"CHICAGO_CRIMES"."snapshots"."snapshot_crimes_description"
WHERE dbt_valid_to IS NULL