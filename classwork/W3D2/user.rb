require_relative 'dbconnection'
require_relative 'question'
require_relative 'user'
require_relative 'reply'
require_relative 'questionfollow'

class User
  def self.find_by_id(id)
    user = QuestionsDBConnection.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        users
      WHERE
        id = ?
    SQL
    return nil if user.empty?

    User.new(user.first)
  end

  def self.find_by_name(fname, lname)
    user = QuestionsDBConnection.instance.execute(<<-SQL, fname, lname)
      SELECT
        *
      FROM
        users
      WHERE
        fname = ? AND lname = ?
    SQL
    return nil if user.empty?

    User.new(user.first)
  end

  attr_accessor :fname, :lname
  attr_reader :id

  def initialize(options)
    @id = options['id']
    @fname = options['fname']
    @lname = options['lname']
  end

  def authored_questions
    Question.find_by_author_id(self.id)
  end

  def authored_replies
    Reply.find_by_user_id(self.id)
  end

  def followed_questions
    QuestionFollow.followed_questions_for_user_id(self.id)
  end

  def liked_questions
    QuestionLike.liked_questions_for_user_id(self.id)
  end

  def average_karma
    QuestionsDBConnection.instance.execute(<<-SQL, self.id)
      SELECT
        CAST(COUNT(question_likes.id) AS FLOAT) / COUNT(DISTINCT(questions.id))
        -- (COUNT(DISTINCT(questions.id))) -- number of questions
        -- (COUNT(question_likes.id)) -- number of likes for all questions
      FROM
        questions
      LEFT OUTER JOIN
        question_likes ON questions.id = question_likes.question_id
      WHERE
        questions.user_id = ?
    SQL
  end

  def save
    if self.id
      update
    else
      insert
    end
  end

  private

  def insert
    QuestionsDBConnection.instance.execute(<<-SQL, self.fname, self.lname)
      INSERT INTO
        users(fname, lname)
      VALUES
        (?, ?)
    SQL
  end

  def update
    QuestionsDBConnection.instance.execute(<<-SQL, self.fname, self.lname, self.id)
      UPDATE
        users
      SET
        fname = ?, lname = ?
      WHERE
        id = ?
      SQL
  end
end
