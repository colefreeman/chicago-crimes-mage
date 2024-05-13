

SELECT
    crimes_cases_hkey
    , case_number
FROM "CHICAGO_CRIMES"."snapshots"."snapshot_crimes_cases"
WHERE dbt_valid_to IS NULL