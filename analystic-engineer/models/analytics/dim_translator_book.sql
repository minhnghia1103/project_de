WITH dim_translator_book__source AS(
    SELECT 
        ROW_NUMBER() OVER() AS id
        , dich_gia
    FROM    
        `aesthetic-root-416403.tiki.tiki_book_data`
    WHERE dich_gia != "None"
    GROUP BY dich_gia
)
, dim_translator_book__rename_column AS(
    SELECT
        id AS translator_key
        , dich_gia AS translator
    FROM dim_translator_book__source
)
, dim_translator_book__cast_type AS(
    SELECT
        CAST(translator_key AS INTEGER) AS translator_key
        , CAST(translator AS STRING) AS translator
    FROM 
        dim_translator_book__rename_column
)

SELECT 
    translator_key
    , translator
FROM dim_translator_book__cast_type