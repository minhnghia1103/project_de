WITH dim_authors_book__source AS(
    SELECT 
        ROW_NUMBER() OVER() AS id
        ,authors
    FROM    
        `aesthetic-root-416403.tiki.tiki_book_data`
    WHERE authors != "None"
    GROUP BY authors
)
, dim_authors_book__rename_column AS(
    SELECT
        id AS authors_key
        , authors AS authors_name 
    FROM dim_authors_book__source
)
, dim_authors_book__cast_type AS(
    SELECT
        CAST(authors_key AS INTEGER) AS authors_key
        , CAST(authors_name AS STRING) AS authors_name
    FROM 
        dim_authors_book__rename_column
)

SELECT 
    authors_key
    , authors_name
FROM dim_authors_book__cast_type