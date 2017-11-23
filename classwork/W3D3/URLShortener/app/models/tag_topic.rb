class TagTopic < ApplicationRecord
  validates :tag_name, presence: true, uniqueness: true

  has_many :taggings,
    primary_key: :id,
    foreign_key: :tag_topic_id,
    class_name: "Tagging"

  has_many :shortened_urls,
    through: :taggings,
    source: :shortened_url

  # def popular_links
  #   links_for_topic = self.shortened_urls
  #   counted_links = links_for_topic.map { |link| [link.long_url, link.num_clicks] }
  #   counted_links.sort.reverse.take(5)
  # end

  def popular_links
    self
      .shortened_urls
      .joins(:visits)
      .order('COUNT(visits.id) DESC')
      .select('long_url, short_url, COUNT(visits.id) AS num_visits')
      .limit(5)
  end
end
