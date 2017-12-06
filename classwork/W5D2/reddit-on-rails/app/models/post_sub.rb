class PostSub < ApplicationRecord
  validates :post, uniqueness: { scope: [:sub] }
  
  belongs_to :sub
  belongs_to :post
end
