WITH book_tiki__source AS (
    SELECT 
        id
        , ROW_NUMBER() OVER() AS sale_id
        , price
        , quantity
        , rating_average
        , publication_date
        , quantity * price AS gross_amount
    FROM    
        `aesthetic-root-416403.tiki.tiki_book_data`
    WHERE 
        (authors IS NOT NULL AND authors != 'None') AND
        (publisher_vn IS NOT NULL AND publisher_vn != 'None') AND
        (manufacturer IS NOT NULL AND manufacturer != 'None')
)
, book_tiki__rename_columns AS(
    SELECT
        sale_id
        , id AS book_key 
        , price 
        , quantity
        , rating_average
        , publication_date
        , gross_amount
    FROM book_tiki__source
)
, book_tiki__cast_type AS(
    SELECT
        CAST(sale_id AS INTEGER) AS sale_id
        , SAFE_CAST(book_key AS INTEGER) AS book_key
        , CAST(price AS NUMERIC) AS price
        , SAFE_CAST(quantity AS INTEGER) AS quantity
        , SAFE_CAST(rating_average AS NUMERIC) AS rating_average
        , CAST(publication_date AS DATE) AS publication_date
        , CAST(gross_amount AS NUMERIC) AS gross_amount
    FROM 
        book_tiki__rename_columns
)

SELECT
    sale_id
    , book_tiki__cast_type.book_key
    , COALESCE(price, -1) AS price
    , COALESCE(quantity, -1) AS quantity
    , rating_average    
    , book_tiki__cast_type.publication_date
    , COALESCE(gross_amount, -1) AS gross_amount
    , authors_key
    , COALESCE(manufacturer_key, 0) AS manufacturer_key
    , COALESCE(publisher_vn_key, 0) AS publisher_vn_key
    , COALESCE(translator_key, 0) AS translator_key
FROM book_tiki__cast_type
LEFT JOIN {{ ref('stg_fact_info_book') }} AS face_header USING (book_key)