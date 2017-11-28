# == Schema Information
#
# Table name: artworks
#
#  id         :integer          not null, primary key
#  title      :string           not null
#  image_url  :string           not null
#  artist_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Artwork < ApplicationRecord
  validates :title, :image_url, :artist_id, presence: true
  validates :image_url, uniqueness: true

  # it would still work if `:artist_id` and `:title` were switched
  validates :artist_id, uniqueness: { scope: :title }

  belongs_to :artist,
    class_name: :User,
    foreign_key: :artist_id

  has_many :artwork_shares,
    class_name: :ArtworkShare,
    foreign_key: :artwork_id

  has_many :shared_viewers,
    through: :artwork_shares,
    source: :viewer

  has_many :comments,
    class_name: :Comment,
    foreign_key: :artwork_id
end
