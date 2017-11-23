# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

TagTopic.create([
  { tag_name: 'sports' },
  { tag_name: 'music' },
  { tag_name: 'news' },
  { tag_name: 'video games' },
  { tag_name: 'food' }
])

Tagging.create([
  { tag_topic_id: 1, shortened_url_id: 1},
  { tag_topic_id: 1, shortened_url_id: 2},
  { tag_topic_id: 1, shortened_url_id: 3},
  { tag_topic_id: 2, shortened_url_id: 3},
  { tag_topic_id: 2, shortened_url_id: 1},
  { tag_topic_id: 3, shortened_url_id: 2},
  { tag_topic_id: 3, shortened_url_id: 1},
  { tag_topic_id: 4, shortened_url_id: 3},
  { tag_topic_id: 5, shortened_url_id: 1},
  { tag_topic_id: 5, shortened_url_id: 2}
  ])
