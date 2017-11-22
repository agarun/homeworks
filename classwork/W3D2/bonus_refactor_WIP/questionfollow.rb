require_relative 'dbconnection'
require_relative 'user'
require_relative 'question'

class QuestionFollow < ModelBase
  def self.followers_for_question_id(question_id)
    question_follow = QuestionsDBConnection.instance.execute(<<-SQL, question_id)
      SELECT
        users.*
      FROM
        question_follows
      JOIN
        users ON question_follows.user_id = users.id
      WHERE
        question_id = ?
    SQL
    return nil if question_follow.empty?

    question_follow.map { |user| User.new(user) }
  end

  def self.followed_questions_for_user_id(user_id)
    question_follow = QuestionsDBConnection.instance.execute(<<-SQL, user_id)
      SELECT
        questions.*
      FROM
        question_follows
      JOIN
        questions ON question_follows.question_id = questions.id
      WHERE
        question_follows.user_id = ?
    SQL
    return nil if question_follow.empty?

    question_follow.map { |user| Question.new(user) }
  end

  def self.most_followed_questions(n)
    question_follow = QuestionsDBConnection.instance.execute(<<-SQL, n)
      SELECT
        questions.*
      FROM
        question_follows
      JOIN
        questions ON question_follows.question_id = questions.id
      GROUP BY
        questions.id
      ORDER BY
        COUNT(questions.user_id) DESC
      LIMIT
        ?
    SQL
    return nil if question_follow.empty?

    question_follow.map { |user| Question.new(user) }
  end

  attr_accessor :user_id, :question_id
  attr_reader :id

  def initialize(options)
    @id = options['id']
    @user_id = options['user_id']
    @question_id = options['question_id']
  end
end
