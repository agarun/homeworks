require 'securerandom'

class ShortenedUrl < ApplicationRecord
  validates :user_id, :long_url, presence: true
  validates :short_url, presence: true, uniqueness: true

  def self.random_code
    code = SecureRandom.urlsafe_base64

    while ShortenedUrl.exists?(code)
      code = SecureRandom.urlsafe_base64
    end

    code
  end

  def self.generate_code(user, long_url_string)
    ShortenedUrl.create!(
      user_id: user.id,
      short_url: ShortenedUrl.random_code,
      long_url: long_url_string
    )
  end
  
  belongs_to :submitter,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: 'User'

  has_many :visits,
    primary_key: :id,
    foreign_key: :shortened_url_id,
    class_name: 'Visit'

  has_many :visitors,
    -> { distinct },
    through: :visits,
    source: :visitor

  has_many :taggings,
    primary_key: :id,
    foreign_key: :shortened_url_id,
    class_name: 'Tagging'

  has_many :tag_topics,
    -> { distinct },
    through: :taggings,
    source: :tag_topic

  def num_clicks
    self.visits.count
  end

  def num_uniques
    self.visitors.count
  end

  def num_recent_uniques
    self.visitors.where("visits.updated_at > ?", 10.minutes.ago).count
  end
end
