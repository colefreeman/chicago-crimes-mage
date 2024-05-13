WITH 
    ranked_records AS (
        SELECT 
            "address"
            , "location_description"
            , "lat"
            , "lng"
            , "location"
            , md5(cast(coalesce(cast(address as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(location_description as TEXT), '_dbt_utils_surrogate_key_null_') as TEXT)) AS loc_hashed_key
            , ROW_NUMBER() OVER (PARTITION BY md5(cast(coalesce(cast(address as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(location_description as TEXT), '_dbt_utils_surrogate_key_null_') as TEXT)) ORDER BY "address") AS "row_num"
        FROM 
            "CHICAGO_CRIMES"."public"."crimes_silver"
)
SELECT 
    "address"
    , "location_description"
    , "lat"
    , "lng"
    , "location"
    , "loc_hashed_key"
    , ROW_NUMBER() OVER (ORDER BY "address") AS "crimes_loc_id"
FROM 
    ranked_records
WHERE 
    "row_num" = 1
ORDER BY 
    "address"