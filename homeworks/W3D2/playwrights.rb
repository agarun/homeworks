require_relative "playdbconnection"
require_relative "plays"

class Playwright
  def self.all
    data = PlayDBConnection.instance.execute("SELECT * FROM playwrights")
    data.map { |datum| Playwright.new(datum) }
  end

  def self.find_by_name(name)
    playwright = PlayDBConnection.instance.execute(<<-SQL, name)
      SELECT
        *
      FROM
        playwrights
      WHERE
        name = ?
    SQL

    Playwright.new(playwright[0]) unless playwright.empty?
  end

  attr_accessor :name, :birth_year

  def initialize(options)
    @id = options['id']
    @name = options['name']
    @birth_year = options['birth_year']
  end

  def create
    raise "#{self} already in database" if @id

    PlayDBConnection.instance.execute(<<-SQL, name, birth_year)
      INSERT INTO
        playwrights (name, birth_year)
      VALUES
        (?, ?)
    SQL

    @id = PlayDBConnection.instance.last_insert_row_id
  end

  def update
    raise "#{self} not in database" unless @id

    PlayDBConnection.instance.execute(<<-SQL, name, birth_year, @id)
      UPDATE
        playwrights
      SET
        name = ?, birth_year = ?
      WHERE
        id = ?
    SQL
  end

  def get_plays
    raise "#{self} not in database" unless @id

    Play.find_by_playwright(name)
  end

  # #get_plays
  # plays = PlayDBConnection.instance.execute(<<-SQL, @id)
  #   SELECT
  #     *
  #   FROM
  #     plays
  #   WHERE
  #     playwright_id = ?
  # SQL
  # plays.map { |play| Play.new(play) }
end
