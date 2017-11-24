class Question < ApplicationRecord
  validates :text, :poll_id, presence: true
  
  has_many :answer_choices,
    class_name: 'AnswerChoice',
    foreign_key: :question_id,
    primary_key: :id
    
  belongs_to :poll,
    class_name: 'Poll',
    foreign_key: :poll_id,
    primary_key: :id
    
  has_many :responses,
    through: :answer_choices,
    source: :responses
  
  def title
    poll.title
  end
  
  # N + 1 method
  def results
    # { answer choice text => count of responses }
    results_hash = Hash.new(0)

    answer_choices.each do |choice|
      # results_hash[choice.question.text] += choice.responses.length 
      results_hash[choice.text] += choice.responses.length 
    end
    
    results_hash
  end
  
  # 2 query method
  def new_results
    results_hash = {}

    answer_choices.includes(:responses).each do |choice|
      # results_hash[choice.question.text] = choice.responses.length
      results_hash[choice.text] = choice.responses.length
    end
    
    results_hash
  end
  
  def sql_results
    a_c = self.answer_choices
      .select("answer_choices.text, COUNT(responses.id) AS num_of_responses")
      .joins(<<-SQL)
        LEFT OUTER JOIN
          responses ON answer_choices.id = responses.answer_choice_id
      SQL
      .group("answer_choices.id")
      
    results_hash = {}
    
    a_c.each do |choice|
      results_hash[choice.text] = choice.responses.length
    end
    
    results_hash
  end   
end