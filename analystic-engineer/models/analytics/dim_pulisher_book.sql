WITH dim_publisher_vn_book__source AS(
    SELECT 
        ROW_NUMBER() OVER() AS id
        , publisher_vn
    FROM    
        `aesthetic-root-416403.tiki.tiki_book_data`
    WHERE publisher_vn != "None"
    GROUP BY publisher_vn
)
, dim_publisher_vn_book__rename_column AS(
    SELECT
        id AS publisher_vn_key
        , publisher_vn 
    FROM dim_publisher_vn_book__source
)
, dim_publisher_vn_book__cast_type AS(
    SELECT
        CAST(publisher_vn_key AS INTEGER) AS publisher_vn_key
        , CAST(publisher_vn AS STRING) AS publisher_vn
    FROM 
        dim_publisher_vn_book__rename_column
)

SELECT 
    publisher_vn_key
    , publisher_vn
FROM dim_publisher_vn_book__cast_type