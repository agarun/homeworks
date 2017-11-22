require_relative 'dbconnection'
require_relative 'user'
require_relative 'reply'
require_relative 'questionfollow'
require_relative 'questionlike'

class Question < ModelBase
  def self.find_by_author_id(author_id)
    question = QuestionsDBConnection.instance.execute(<<-SQL, author_id)
    SELECT
    *
    FROM
    questions
    WHERE
    user_id = ?
    SQL
    return nil if question.empty?

    Question.new(question.first)
  end

  def self.most_followed(n)
    QuestionFollow.most_followed_questions(n)
  end

  def self.most_liked(n)
    QuestionLike.most_liked_questions(n)
  end

  attr_accessor :title, :body, :user_id
  attr_reader :id

  def initialize(options)
    @id = options['id']
    @title = options['title']
    @body = options['body']
    @user_id = options['user_id']
  end

  def author
    User.find_by_id(self.user_id)
  end

  def replies
    Reply.find_by_question_id(self.id)
  end

  def followers
    QuestionFollow.followers_for_question_id(self.id)
  end

  def likers
    QuestionLike.likers_for_question_id(self.id)
  end

  def num_likes
    QuestionLike.num_likes_for_question_id(self.id)
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
    QuestionsDBConnection.instance.execute(<<-SQL, title, body, user_id)
      INSERT INTO
        questions (title, body, user_id)
      VALUES
        (?, ?, ?)
    SQL
  end

  def update
    QuestionsDBConnection.instance.execute(<<-SQL, title, body, user_id, id)
      UPDATE
        questions
      SET
        title = ?, body = ?, user_id = ?
      WHERE
        id = ?
      SQL
  end
end
