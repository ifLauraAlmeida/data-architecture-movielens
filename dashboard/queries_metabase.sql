/**
 * MAPEAMENTO DE VIEWS GOLD -> COMPONENTES DO DASHBOARD
 * * Este projeto utiliza uma camada semântica na Gold para que o 
 * Metabase execute apenas consultas simples, garantindo performance.
 */

-- 1. KPIs de Cabeçalho (Cards)
-- Alimenta: Total de Users, Filmes e Avaliações
SELECT 
    total_movies, 
    total_users, 
    total_ratings 
FROM `{{PROJECT_ID}}.movielens_analytics.vw_movie_kpis`;


-- 2. Ranking de Popularidade (Bar Chart)
-- Alimenta: Top 10 Filmes Mais Populares
SELECT 
    title, 
    num_ratings 
FROM `{{PROJECT_ID}}.movielens_analytics.vw_top_movies`
LIMIT 10;


-- 3. Matriz de Valor (Scatter Plot)
-- Alimenta: Popularidade vs. Qualidade Média
SELECT 
    popularidade, 
    qualidade 
FROM `{{PROJECT_ID}}.movielens_analytics.vw_scatter_popularity_vs_quality`;


-- 4. Análise Térmica (Heatmap)
-- Alimenta: Atividade de Avaliações por Horário e Dia da Semana
SELECT 
    dia_semana, 
    hora_dia, 
    qtd_avaliacoes 
FROM `{{PROJECT_ID}}.movielens_analytics.vw_ratings_heatmap`;


-- 5. Performance de Nicho (Bubble Chart)
-- Alimenta: Engajamento vs. Avaliação por Gênero
SELECT 
    genero, 
    avg_rating, 
    total_ratings 
FROM `{{PROJECT_ID}}.movielens_analytics.vw_genre_performance`;


-- 6. Histórico de Retenção (Line Chart)
-- Alimenta: Volume Histórico de Interações (Ano/Mês)
SELECT 
    ultima_atividade as data,
    total_ratings
FROM `{{PROJECT_ID}}.movielens_analytics.vw_user_activity`
ORDER BY data ASC;