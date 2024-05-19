WITH dim_date__source AS (
    SELECT
        publication_date
    FROM 
         `aesthetic-root-416403.tiki.tiki_book_data`
    WHERE publication_date IS NOT NULL
)
, dim_date__enrich AS(
    SELECT
        publication_date
        , DATE_TRUNC(publication_date, DAY) AS day
        , FORMAT_DATE('%A', publication_date) AS day_of_week
        , FORMAT_DATE('%a', publication_date) AS day_of_week_short
        , DATE_TRUNC(publication_date, MONTH) AS year_month
        , FORMAT_DATE('%B', publication_date) AS month
        , DATE_TRUNC(publication_date, YEAR) AS year
        , EXTRACT(YEAR FROM publication_date) AS year_number
    FROM dim_date__source
)
SELECT 
  *
  , CASE 
    WHEN day_of_week_short IN ('Sat', 'Sun') THEN 'Weekend'
    WHEN day_of_week_short IN ('Mon', 'Tue', 'Wed', 'Thu', 'Fri') THEN 'Weekday'
    ELSE 'Invalid'
  END AS is_weekday_or_weekend
FROm dim_date__enrich
    
