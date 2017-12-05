class Goal < ApplicationRecord
  validates :goal, presence: true
  
  belongs_to :user
  # has_many :comments
end
