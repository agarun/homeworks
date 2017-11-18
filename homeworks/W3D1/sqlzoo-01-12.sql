-- 01

SELECT
  *
FROM
  movies;

-- 02

SELECT
  title
FROM
  movies
WHERE
  id = 6;

SELECT
  title
FROM
  movies
WHERE
  year BETWEEN 2000 AND 2010;

SELECT
  title, year
FROM
  movies
WHERE
  year <= 2003;

-- 03

SELECT
  title
FROM
  movies
WHERE
  title LIKE "toy story%";

SELECT
  title
FROM
  movies
WHERE
  director != "John Lasseter";

SELECT
  title
FROM
  movies
WHERE
  title LIKE "WALL-_";

-- 04

SELECT DISTINCT
  director
FROM
  movies
ORDER BY
  director ASC;

SELECT
  title
FROM
  movies
ORDER BY
  YEAR DESC
LIMIT 4;

SELECT
  title
FROM
  movies
ORDER BY
  title ASC
LIMIT 5 OFFSET 5;

-- 05

SELECT
  city, population
FROM
  north_american_cities
WHERE
  country = "Canada";

SELECT
  city
FROM
  north_american_cities
WHERE
  country = "United States"
ORDER BY
  latitude DESC;

SELECT
  city
FROM
  north_american_cities
WHERE
  longitude < -87.7
ORDER BY
  longitude ASC;

SELECT
  city
FROM
  north_american_cities
WHERE
  country = "Mexico"
ORDER BY
  population DESC
LIMIT 2;

SELECT
  city, population
FROM
  north_american_cities
WHERE
  country = "United States"
ORDER BY
  population DESC
LIMIT 2 OFFSET 2;

-- 06

SELECT
  title, domestic_sales, international_sales
FROM
  movies
INNER JOIN
  boxoffice ON movies.id = boxoffice.movie_id;

SELECT
  title, domestic_sales, international_sales
FROM
  movies
INNER JOIN
  boxoffice ON movies.id = boxoffice.movie_id
WHERE
  international_sales > domestic_sales;

SELECT
  title, domestic_sales, international_sales
FROM
  movies
INNER JOIN
  boxoffice ON movies.id = boxoffice.movie_id
ORDER BY
  rating DESC;
