WITH dim_manufacturer_book__source AS(
    SELECT 
        ROW_NUMBER() OVER() AS id
        , manufacturer
    FROM    
        `aesthetic-root-416403.tiki.tiki_book_data`
    WHERE manufacturer != "None"
    GROUP BY manufacturer
)
, dim_manufacturer_book__rename_column AS(
    SELECT
        id AS manufacturer_key
        , manufacturer 
    FROM dim_manufacturer_book__source
)
, dim_manufacturer_book__cast_type AS(
    SELECT
        CAST(manufacturer_key AS INTEGER) AS manufacturer_key
        , CAST(manufacturer AS STRING) AS manufacturer
    FROM 
        dim_manufacturer_book__rename_column
)
, dim_manufacturer_book__add_underfined_record(
    SELECT
        manufacturer_key
        , manufacturer
    FROM 
        dim_manufacturer_book__rename_column

    UNION ALL
    SELECT 
    0 AS manufacturer_key
    , 'Undefined' AS manufacturer
)

SELECT 
    manufacturer_key
    , manufacturer
FROM dim_manufacturer_book__add_underfined_record