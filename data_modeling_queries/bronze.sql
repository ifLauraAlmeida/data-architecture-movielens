CREATE OR REPLACE EXTERNAL TABLE `{{ID DO PROJETO NO GOOGLECLOUD}}.movielens.belief_data` (
  userId STRING,
  movieId STRING,
  isSeen STRING,
  watchData STRING,
  userElicitRating STRING,
  userPredictRating STRING,
  userCertainty	STRING,
  tstamp STRING,
  movie_idx STRING,
  source STRING,
  systemPredictRating STRING,

)
OPTIONS (
  format = 'CSV',
  uris = ['gs://movielens_beliefs_conjunto_de_dados_2024/bronze/belief_data.csv'],
  skip_leading_rows = 1 -- Assumindo que a primeira linha é o cabeçalho
);


CREATE OR REPLACE EXTERNAL TABLE `{{ID DO PROJETO NO GOOGLECLOUD}}.movielens.movie_elicitation_set` (
  movieId STRING,
  month_idx STRING,
  source STRING,
  tstamp STRING,

)
OPTIONS (
  format = 'CSV',
  uris = ['gs://movielens_beliefs_conjunto_de_dados_2024/bronze/movie_elicitation_set.csv'],
  skip_leading_rows = 1 -- Assumindo que a primeira linha é o cabeçalho
);


CREATE OR REPLACE EXTERNAL TABLE `{{ID DO PROJETO NO GOOGLECLOUD}}.movielens.movies`(
  movieId	STRING,
  title STRING,
  genres STRING,

)
OPTIONS (
  format = 'CSV',
  uris = ['gs://movielens_beliefs_conjunto_de_dados_2024/bronze/movies.csv'],
  skip_leading_rows = 1 -- Assumindo que a primeira linha é o cabeçalho
);


CREATE OR REPLACE EXTERNAL TABLE `{{ID DO PROJETO NO GOOGLECLOUD}}.movielens.ratings_for_additional_users`(
  userId STRING,
  movieId	STRING,
  rating STRING,
  tstamp STRING,

)
OPTIONS (
  format = 'CSV',
  uris = ['gs://movielens_beliefs_conjunto_de_dados_2024/bronze/ratings_for_additional_users.csv'],
  skip_leading_rows = 1 -- Assumindo que a primeira linha é o cabeçalho
);


CREATE OR REPLACE EXTERNAL TABLE `{{ID DO PROJETO NO GOOGLECLOUD}}.movielens.user_rating_history`(
  userId STRING,
  movieId	STRING,
  rating STRING,
  tstamp STRING,

)
OPTIONS (
  format = 'CSV',
  uris = ['gs://movielens_beliefs_conjunto_de_dados_2024/bronze/user_rating_history.csv'],
  skip_leading_rows = 1 -- Assumindo que a primeira linha é o cabeçalho
);


CREATE OR REPLACE EXTERNAL TABLE `{{ID DO PROJETO NO GOOGLECLOUD}}.movielens.user_recommendation_history`(
  userId STRING,
  tstamp STRING,
  movieId STRING,
  predictedRating STRING,

)
OPTIONS (
  format = 'CSV',
  uris = ['gs://movielens_beliefs_conjunto_de_dados_2024/bronze/user_recommendation_history.csv'],
  skip_leading_rows = 1 -- Assumindo que a primeira linha é o cabeçalho
);


