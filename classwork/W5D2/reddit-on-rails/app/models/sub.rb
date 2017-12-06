class Sub < ApplicationRecord
  validates :title, :description, presence: true
  
  belongs_to :mod,
    class_name: :User
    
  has_many :post_subs,
    foreign_key: :sub_id,
    inverse_of: :sub
  
  has_many :posts,
    through: :post_subs,
    source: :post
end
