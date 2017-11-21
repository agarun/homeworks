# == Schema Information
#
# Table name: countries
#
#  name        :string       not null, primary key
#  continent   :string
#  area        :integer
#  population  :integer
#  gdp         :integer

require_relative './sqlzoo.rb'

# BONUS QUESTIONS: These problems require knowledge of aggregate
# functions. Attempt them after completing section 05.

def highest_gdp
  # Which countries have a GDP greater than every country in Europe? (Give the
  # name only. Some countries may have NULL gdp values)
  execute(<<-SQL)
    SELECT
      c1.name
    FROM
      countries AS c1
    WHERE
      c1.gdp > (
        SELECT
          MAX(c2.gdp)
        FROM
          countries AS c2
        WHERE
          c2.continent = 'Europe'
      )
  SQL
end

def largest_in_continent
  # Find the largest country (by area) in each continent. Show the continent,
  # name, and area.
  execute(<<-SQL)
    SELECT
      c1.continent,
      c1.name,
      c1.area
    FROM
      countries AS c1
    WHERE
      c1.area = (
        SELECT
          MAX(c2.area)
        FROM
          countries AS c2
        WHERE
          c1.continent = c2.continent
      )
  SQL
end

def large_neighbors
  # Some countries have populations more than three times that of any of their
  # neighbors (in the same continent). Give the countries and continents.
  execute(<<-SQL)
    SELECT
      c1.name,
      c1.continent
    FROM
      countries AS c1
    WHERE
      c1.population > 3 * (
        SELECT
          MAX(c2.population)
        FROM
          countries AS c2
        WHERE
          c1.name != c2.name AND
          c1.continent = c2.continent
      )
  SQL
end