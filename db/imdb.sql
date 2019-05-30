DROP TABLE castings;
DROP TABLE stars;
DROP TABLE movies;

CREATE TABLE stars
(
  first_name VARCHAR(255),
  last_name VARCHAR(255),
  id SERIAL4 PRIMARY KEY
);

CREATE TABLE movies
(
  title VARCHAR(255),
  genre VARCHAR(255),
  budget INT4,
  id SERIAL4 PRIMARY KEY
);

CREATE TABLE castings
(
  movie_id INT4,
  star_id INT4,
  fee INT4,
  id SERIAL4 PRIMARY KEY
);
