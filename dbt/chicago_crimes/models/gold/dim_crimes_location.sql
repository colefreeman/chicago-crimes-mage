WITH 
    ranked_records AS (
        SELECT 
            "address"
            , "location_description"
            , "lat"
            , "lng"
            , "location"
            , {{ dbt_utils.generate_surrogate_key(['address', 'location_description']) }} AS loc_hashed_key
            , ROW_NUMBER() OVER (PARTITION BY {{ dbt_utils.generate_surrogate_key(['address', 'location_description']) }} ORDER BY "address") AS "row_num"
        FROM 
            {{ ref('crimes_silver') }}
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