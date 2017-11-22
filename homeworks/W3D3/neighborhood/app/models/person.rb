class Person < ApplicationRecord
  validates :name, :house, presence: true
  # "Don't check for the presence of the foreign_key (e.g. order_id);
  # check the presence of the associated object (e.g. order)."
  # also...
  # Rails 5 introduces a new behavior:
  # it automatically validates the presence of belongs_to associations

  belongs_to :house,
    class_name: 'House',
    foreign_key: :house_id,
    primary_key: :id
end
