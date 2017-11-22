require_relative 'dbconnection'
require 'byebug'

class ModelBase
  def self.all
    instances = QuestionsDBConnection.instance.execute(<<~SQL)
      SELECT
        *
      FROM
        #{self == Reply ? 'replie' : self}s
    SQL

    instances.map { |instance| self.new(instance) }
  end

  def self.find_by_id(id)
    instances = QuestionsDBConnection.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        #{self == Reply ? 'replie' : self}s
      WHERE
        id = ?
    SQL
    return nil if instances.empty?

    self.new(instances.first)
  end

  def self.where(options)
    i = 0
    where_string = ""
    options.each do |key, value|
      where_string << key.to_s << " = '" << value << "'"
      where_string << " AND " unless i == options.length - 1
      i += 1
    end
    QuestionsDBConnection.instance.execute(<<~SQL)
      SELECT
        *
      FROM
        #{self == Reply ? 'replie' : self}s
      WHERE
        #{where_string}
    SQL
  end

  def save
    self.id ? update : insert
  end
end
