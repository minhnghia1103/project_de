WITH dim_info_book__source AS(
    SELECT 
        id
        , name 
        , number_of_page
    FROM    
        `aesthetic-root-416403.tiki.tiki_book_data`
    WHERE
        (authors IS NOT NULL AND authors != 'None') AND
        (publisher_vn IS NOT NULL AND publisher_vn != 'None') AND
        (manufacturer IS NOT NULL AND manufacturer != 'None')
)
, dim_info_book__rename_column AS(
    SELECT
        id AS book_key
        , name AS book_name 
        , number_of_page 
    FROM dim_info_book__source
)
, dim_info_book__cast_type AS(
    SELECT
        CAST(book_key AS INTEGER) AS book_key
        , CAST(book_name AS STRING) AS book_name
        , SAFE_CAST(number_of_page AS INTEGER) AS number_of_page
    FROM 
        dim_info_book__rename_column
)

SELECT 
    book_key
    , book_name
    , number_of_page
FROM dim_info_book__cast_type