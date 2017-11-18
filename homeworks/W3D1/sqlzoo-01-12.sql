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

-- 07

SELECT DISTINCT
  building
FROM
  employees;

SELECT
  *
FROM
  buildings;

SELECT DISTINCT
  building_name, role
FROM
  buildings
LEFT JOIN
  employees ON employees.building = buildings.building_name;

-- 08

SELECT
  name, role
FROM
  employees
WHERE
  building IS NULL;

SELECT DISTINCT
  building_name
FROM
  buildings
LEFT OUTER JOIN
  employees ON employees.building = buildings.building_name
WHERE
  building IS NULL;

-- 09

SELECT
  title, (domestic_sales + international_sales) / 1000000 AS combined_sales
FROM
  movies
INNER JOIN
  boxoffice ON movies.id = boxoffice.movie_id;

SELECT
  title, rating * 10 AS rating_percentage
FROM
  movies
INNER JOIN
  boxoffice ON movies.id = boxoffice.movie_id;

SELECT
  title
FROM
  movies
WHERE
  year % 2 = 0;

-- 10

SELECT
  MAX(years_employed) AS max_years_employed
FROM
  employees;

SELECT
  role,
  AVG(years_employed) AS avg_yrs_in_role
FROM
  employees
GROUP BY
  role;

SELECT
  building,
  SUM(years_employed) AS total_years_employed
FROM
  employees
GROUP BY
  building;

-- 11

SELECT
  role,
  COUNT(*)
FROM
  employees
WHERE
  role = "Artist";

SELECT
  role,
  COUNT(name)
FROM
  employees
GROUP BY
  role;

SELECT
  role,
  SUM(years_employed)
FROM
  employees
GROUP BY
  role
HAVING
  role = "Engineer";
