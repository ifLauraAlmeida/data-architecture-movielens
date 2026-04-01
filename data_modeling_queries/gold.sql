CREATE OR REPLACE VIEW `{{ID DO PROJETO NO GOOGLECLOUD}}.movielens_analytics.vw_movie_kpis` AS
SELECT 
    COUNT(DISTINCT movie_id) AS total_movies,
    COUNT(DISTINCT user_id) AS total_users,
    COUNT(*) AS total_ratings,
    AVG(rating) AS global_avg_rating
FROM `project-dad155f8-631b-42c2-8cc.movielens_analytics.fact_ratings`;


CREATE OR REPLACE VIEW `{{ID DO PROJETO NO GOOGLECLOUD}}.movielens_analytics.vw_top_movies` AS
SELECT 
    m.title,
    AVG(f.rating) AS avg_rating,
    COUNT(f.user_id) AS num_ratings
FROM `project-dad155f8-631b-42c2-8cc.movielens_analytics.fact_ratings` f
JOIN `project-dad155f8-631b-42c2-8cc.movielens_analytics.dim_movies` m ON f.movie_id = m.movie_id
GROUP BY 1
HAVING num_ratings > 100 
ORDER BY avg_rating DESC
LIMIT 10;


CREATE OR REPLACE VIEW `{{ID DO PROJETO NO GOOGLECLOUD}}.movielens_analytics.vw_ratings_heatmap` AS
SELECT 
    EXTRACT(DAYOFWEEK FROM rating_time) AS dia_semana,
    EXTRACT(HOUR FROM rating_time) AS hora_dia,
    COUNT(*) AS qtd_avaliacoes
FROM `project-dad155f8-631b-42c2-8cc.movielens_analytics.fact_ratings`
GROUP BY 1, 2;


CREATE OR REPLACE VIEW `{{ID DO PROJETO NO GOOGLECLOUD}}.movielens_analytics.vw_scatter_popularity_vs_quality` AS
SELECT 
    movie_id,
    COUNT(*) AS popularidade, -- Eixo X
    AVG(rating) AS qualidade    -- Eixo Y
FROM `project-dad155f8-631b-42c2-8cc.movielens_analytics.fact_ratings`
GROUP BY 1;


CREATE OR REPLACE VIEW `{{ID DO PROJETO NO GOOGLECLOUD}}.movielens_analytics.vw_user_activity` AS
SELECT 
    user_id,
    COUNT(*) AS total_ratings,
    MIN(rating_time) AS primeira_atividade,
    MAX(rating_time) AS ultima_atividade
FROM `project-dad155f8-631b-42c2-8cc.movielens_analytics.fact_ratings`
GROUP BY 1;


CREATE OR REPLACE VIEW `{{ID DO PROJETO NO GOOGLECLOUD}}.movielens_analytics.vw_genre_performance` AS
SELECT 
    genero,
    AVG(f.rating) AS avg_rating,
    COUNT(*) AS total_ratings
FROM `project-dad155f8-631b-42c2-8cc.movielens_analytics.dim_movies` m
CROSS JOIN UNNEST(SPLIT(m.genres, '|')) AS genero
JOIN `project-dad155f8-631b-42c2-8cc.movielens_analytics.fact_ratings` f ON m.movie_id = f.movie_id
GROUP BY 1;