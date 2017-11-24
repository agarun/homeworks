class Response < ApplicationRecord
  
  validates :user_id, :answer_choice_id, presence: true
  validate :raspondent_cant_answer_the_same_question_twice
  validate :author_cant_respond_to_own_poll
  
  belongs_to :answer_choice,
    class_name: 'AnswerChoice', 
    foreign_key: :answer_choice_id,
    primary_key: :id 
    
  belongs_to :respondent,
    class_name: 'User',
    foreign_key: :user_id,
    primary_key: :id 
    
  has_one :question,
    through: :answer_choice,  
    source: :question
  
  def sibling_responses
    self.question.responses.where.not(id: self.id)
  end
    
  def respondent_already_answered?
    self.sibling_responses.exists?(user_id: self.user_id)
  end
  
  def raspondent_cant_answer_the_same_question_twice
    if respondent_already_answered?
      errors[:respondent] << 'You have already answered this question'
    end
  end
  
  # response.user_id cannot equal the question's poll's user_id
  # self.user_id != question.poll.author.id
  # .. :questions_author
  def questions_author
    self.question.poll.author.id
  end
  
  def author_responding?
    questions_author == self.user_id
  end
  
  def author_cant_respond_to_own_poll
    if author_responding?
      errors[:author] << 'you cant respond to your own question'
    end
  end
end