require_relative 'dbconnection'
require_relative 'user'
require_relative 'question'

class QuestionLike
  def self.find_by_id(id)
    question_like = QuestionsDBConnection.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        question_likes
      WHERE
        id = ?
    SQL
    return nil if question_like.empty?

    QuestionLike.new(question_like.first)
  end

  def self.likers_for_question_id(question_id)
    question_likers = QuestionsDBConnection.instance.execute(<<-SQL, question_id)
      SELECT
        users.*
      FROM
        question_likes
      JOIN
        users ON question_likes.user_id = users.id
      WHERE
        question_likes.question_id = ?
    SQL
    return nil if question_likers.empty?

    question_likers.map { |liker| User.new(liker) }
  end

  def self.num_likes_for_question_id(question_id)
    question_likers = QuestionsDBConnection.instance.execute(<<-SQL, question_id)
      SELECT
        COUNT(*)
      FROM
        question_likes
      JOIN
        users ON question_likes.user_id = users.id
      WHERE
        question_likes.question_id = ?
    SQL
    return nil if question_likers.nil?

    question_likers.first.values.first
  end

  def self.most_liked_questions(n)
    questions = QuestionsDBConnection.instance.execute(<<-SQL, n)
      SELECT
        questions.*
      FROM
        question_likes
      JOIN
        questions ON question_likes.question_id = questions.id
      GROUP BY
        questions.id
      ORDER BY
        COUNT(*) DESC
      LIMIT
        ?
    SQL
    return nil if questions.empty?

    questions.map { |question| Question.new(question) }
  end

  def self.liked_questions_for_user_id(user_id)
    question_liked = QuestionsDBConnection.instance.execute(<<-SQL, user_id)
      SELECT
        questions.*
      FROM
        questions
      JOIN
        question_likes ON question_likes.question_id = questions.id
      WHERE
        question_likes.user_id = ?
    SQL
    return nil if question_liked.empty?

    question_liked.map { |liked| Question.new(liked) }
  end

  attr_accessor :user_id, :question_id
  attr_reader :id

  def initialize(options)
    @id = options['id']
    @user_id = options['user_id']
    @question_id = options['question_id']
  end
end
