WITH stg_infor_book_tiki__source AS (
    SELECT 
        id
        , publication_date
        , publisher_vn
        , manufacturer
        , dich_gia
        , authors
    FROM    
        `aesthetic-root-416403.tiki.tiki_book_data`
    WHERE 
        (authors IS NOT NULL AND authors != 'None') AND
        (publisher_vn IS NOT NULL AND publisher_vn != 'None') AND
        (manufacturer IS NOT NULL AND manufacturer != 'None')
)
, stg_infor_book_tiki__rename_columns AS(
    SELECT
        id AS book_key
        , publication_date
        , publisher_vn
        , manufacturer
        , dich_gia
        , authors
    FROM stg_infor_book_tiki__source
)
, stg_infor_book_tiki__cast_type AS(
    SELECT
        SAFE_CAST(book_key AS INTEGER) AS book_key
        , CAST(publication_date AS DATE) AS publication_date
        , publisher_vn
        , manufacturer
        , dich_gia
        , authors
    FROM 
        stg_infor_book_tiki__rename_columns
)

SELECT
    book_key   
    , publication_date
    , publisher_vn_key
    , manufacturer_key
    , translator_key
    , authors_key
FROM stg_infor_book_tiki__cast_type
LEFT JOIN {{ ref('dim_authors_book') }} AS dim_authors_book ON stg_infor_book_tiki__cast_type.authors = dim_authors_book.authors
LEFT JOIN {{ ref('dim_pulisher_book') }} AS dim_pulisher_book ON stg_infor_book_tiki__cast_type.publisher_vn = dim_pulisher_book.publisher_vn
LEFT JOIN {{ ref('dim_manufacturer_book') }} AS dim_manufacturer_book ON stg_infor_book_tiki__cast_type.manufacturer = dim_manufacturer_book.manufacturer
LEFT JOIN {{ ref('dim_translator_book') }} AS dim_translator_book ON stg_infor_book_tiki__cast_type.dich_gia = dim_translator_book.translator