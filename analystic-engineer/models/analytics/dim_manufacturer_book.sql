WITH dim_manufacturer_book__source AS(
    SELECT 
        ROW_NUMBER() OVER() AS id
        ,manufacturer
    FROM    
        `aesthetic-root-416403.tiki.tiki_book_data`
    WHERE manufacturer != "None"
    GROUP BY manufacturer
)
, dim_manufacturer_book__rename_column AS(
    SELECT
        id AS manufacturer_key
        , manufacturer AS manufacturer_name 
    FROM dim_manufacturer_book__source
)
, dim_manufacturer_book__cast_type AS(
    SELECT
        CAST(manufacturer_key AS INTEGER) AS manufacturer_key
        , CAST(manufacturer_name AS STRING) AS manufacturer_name
    FROM 
        dim_manufacturer_book__rename_column
)

SELECT 
    manufacturer_key
    , manufacturer_name
FROM dim_manufacturer_book__cast_type