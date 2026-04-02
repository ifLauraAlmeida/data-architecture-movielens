CREATE OR REPLACE TABLE `{{ID DO PROJETO NO GOOGLECLOUD}}.movielens_analytics.dim_movies`
AS
SELECT
  SAFE_CAST(movieId AS INT64) AS movie_id,
  TRIM(REGEXP_REPLACE(title, r'\(\d{4}\)', '')) AS title,
  SAFE_CAST(REGEXP_EXTRACT(title, r'\((\d{4})\)') AS INT64) AS release_year,
  genres
FROM `project-dad155f8-631b-42c2-8cc.movielens.movies`;


CREATE OR REPLACE TABLE `project-dad155f8-631b-42c2-8cc.movielens_analytics.fact_ratings`
AS

WITH raw_data AS (
  SELECT 
    userId, movieId, rating, tstamp, 'history' AS source 
  FROM `project-dad155f8-631b-42c2-8cc.movielens.user_rating_history`
  
  UNION ALL
  
  SELECT 
    userId, movieId, rating, tstamp, 'additional' AS source 
  FROM `project-dad155f8-631b-42c2-8cc.movielens.ratings_for_additional_users`
)

SELECT
  SAFE_CAST(userId AS INT64) AS user_id,
  SAFE_CAST(movieId AS INT64) AS movie_id,
  SAFE_CAST(rating AS FLOAT64) AS rating,
  COALESCE(
    SAFE_CAST(tstamp AS TIMESTAMP),
    TIMESTAMP_SECONDS(SAFE_CAST(tstamp AS INT64))
  ) AS rating_time,
  source
FROM raw_data
WHERE 
  rating IS NOT NULL 
  AND SAFE_CAST(rating AS FLOAT64) != -1.0;