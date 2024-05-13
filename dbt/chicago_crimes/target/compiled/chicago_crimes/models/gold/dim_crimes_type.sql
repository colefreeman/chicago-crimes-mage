

SELECT
    "primary_type"
    , "crimes_type_hkey"
FROM "CHICAGO_CRIMES"."snapshots"."snapshot_crimes_type"
GROUP BY "primary_type"
ORDER BY "primary_type"