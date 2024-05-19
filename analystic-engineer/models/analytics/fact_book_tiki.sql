WITH book_tiki__source AS (
    SELECT 
        id
        , name
        , price
        , quantity
        , rating_average
        , publication_date
        , number_of_page
    FROM    
        `aesthetic-root-416403.tiki.tiki_book_data`
    WHERE 
        (authors IS NOT NULL AND authors != 'None') AND
        (publisher_vn IS NOT NULL AND publisher_vn != 'None') AND
        (manufacturer IS NOT NULL AND manufacturer != 'None')
)
, book_tiki__rename_columns AS(
    SELECT
        id AS book_key
        , name AS book_name 
        , price 
        , quantity
        , rating_average
        , publication_date
        , number_of_page
    FROM book_tiki__source
)
, book_tiki__cast_type AS(
    SELECT
        SAFE_CAST(book_key AS INTEGER) AS book_key
        , CAST(book_name AS STRING) AS book_name
        , SAFE_CAST(number_of_page AS INTEGER) AS number_of_page
        , CAST(price AS NUMERIC) AS price
        , SAFE_CAST(quantity AS INTEGER) AS quantity
        , SAFE_CAST(rating_average AS NUMERIC) AS rating_average
        , CAST(publication_date AS DATE) AS publication_date
    FROM 
        book_tiki__rename_columns
)

SELECT
    book_key
    , book_name
    , number_of_page
    , price
    , quantity
    , rating_average    
    , publication_date
FROM book_tiki__cast_type