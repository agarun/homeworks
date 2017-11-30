class Cat < ApplicationRecord
  COLORS = ['blue', 'red', 'green', 'yellow', 'teal']
  validates :color, inclusion: { in: COLORS, message: "%{value} is not a valid color" }
  validates :sex, inclusion: { in: %w[M F], message: "You have to choose between 'M' or 'F'." }
  validates :color, :name, :sex, :description, presence: true

  # or `include ActionView::Helpers::DateHelper` and simply call `time_ago_in_words()`
  def age
    ActionController::Base.helpers.time_ago_in_words(birth_date)
  end

  has_many :rental_requests,
    foreign_key: :cat_id,
    class_name: :CatRentalRequest,
    dependent: :destroy
end
