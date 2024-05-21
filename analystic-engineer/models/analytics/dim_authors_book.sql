WITH dim_authors_book__source AS(
    SELECT 
        ROW_NUMBER() OVER() AS id
        , authors
    FROM    
        `aesthetic-root-416403.tiki.tiki_book_data`
    WHERE authors != "None"
    GROUP BY authors
)
, dim_authors_book__rename_column AS(
    SELECT
        id AS authors_key
        , authors  
    FROM dim_authors_book__source
)
, dim_authors_book__cast_type AS(
    SELECT
        CAST(authors_key AS INTEGER) AS authors_key
        , CAST(authors AS STRING) AS authors
    FROM 
        dim_authors_book__rename_column
)

SELECT 
    authors_key
    , authors
FROM dim_authors_book__cast_type