require_relative 'dbconnection'
require_relative 'user'
require_relative 'question'

class Reply
  def self.find_by_id(id)
    reply = QuestionsDBConnection.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        replies
      WHERE
        id = ?
    SQL
    return nil if reply.empty?

    Reply.new(reply.first)
  end

  attr_accessor :body, :user_id, :question_id, :reply_id
  attr_reader :id

  def initialize(options)
    @id = options['id']
    @body = options['body']
    @reply_id = options['reply_id']
    @question_id = options['question_id']
    @user_id = options['user_id']
  end

  def self.find_by_user_id(user_id)
    reply = QuestionsDBConnection.instance.execute(<<-SQL, user_id)
      SELECT
        *
      FROM
        replies
      WHERE
        user_id = ?
    SQL
    return nil if reply.empty?

    reply.map { |reply| Reply.new(reply) }
  end

  def self.find_by_question_id(question_id)
    reply = QuestionsDBConnection.instance.execute(<<-SQL, question_id)
      SELECT
        *
      FROM
        replies
      WHERE
        question_id = ?
    SQL
    return nil if reply.empty?

    reply.map { |reply| Reply.new(reply) }
  end

  def author
    User.find_by_id(self.user_id)
  end

  def question
    Question.find_by_id(self.question_id)
  end

  def parent_reply
    Reply.find_by_id(self.reply_id)
  end

  def child_replies
    reply = QuestionsDBConnection.instance.execute(<<-SQL, self.id)
      SELECT
        *
      FROM
        replies
      WHERE
        reply_id = ?
    SQL
    return nil if reply.empty?

    reply.map { |reply| Reply.new(reply) }
  end

  def save
    self.id ? update : insert
  end

  private

  def insert
    QuestionsDBConnection.instance.execute(<<-SQL, body, question_id, reply_id, user_id)
      INSERT INTO
        replies (body, question_id, reply_id, user_id)
      VALUES
        (?, ?, ?, ?)
    SQL
  end

  def update
    QuestionsDBConnection.instance.execute(<<-SQL, body, question_id, reply_id, user_id, id)
      UPDATE
        replies
      SET
        body = ?, question_id = ?, reply_id = ?, user_id = ?
      WHERE
        id = ?
      SQL
  end
end
