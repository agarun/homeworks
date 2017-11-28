# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or create!d alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create!([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create!(name: 'Luke', movie: movies.first)

#
# Table name: artworks
#
#  id         :integer          not null, primary key
#  title      :string           not null
#  image_url  :string           not null
#  artist_id  :integer          not null
#  create!d_at :datetime         not null
#  updated_at :datetime         not null
#

#
# Table name: artwork_shares
#
#  id         :integer          not null, primary key
#  artwork_id :integer          not null
#  viewer_id  :integer          not null
#  create!d_at :datetime         not null
#  updated_at :datetime         not null
#

# Table name: users
#
#  id         :integer          not null, primary key
#  create!d_at :datetime         not null
#  updated_at :datetime         not null
#  username   :string           not null
#

User.destroy_all
Artwork.destroy_all
ArtworkShare.destroy_all
Comment.destroy_all

u1 = User.create!(username: "Bob")
u2 = User.create!(username: "Barb")
u3 = User.create!(username: "Ivan")
u4 = User.create!(username: "Sarah")
u5 = User.create!(username: "Brandon")
u6 = User.create!(username: "Aaron") # 6
u7 = User.create!(username: "I view only")
u8 = User.create!(username: "I also view only")

a1 = Artwork.create!(title: "Starry Night", image_url: "google.com", artist_id: u1.id)
a2 = Artwork.create!(title: "Irises", image_url: "amazon.com", artist_id: u1.id)
a3 = Artwork.create!(title: "Persistence of Time", image_url: "time.com", artist_id: u2.id)
a4 = Artwork.create!(title: "The Elephants", image_url: "elephnat.com", artist_id: u3.id)
a5 = Artwork.create!(title: "The Elephants 2", image_url: "elephnat2.com", artist_id: u3.id)
a6 = Artwork.create!(title: "The Elephants 3", image_url: "elephnat3.com", artist_id: u3.id)
a7 = Artwork.create!(title: "ABCD", image_url: "abcd.com", artist_id: u4.id)
a8 = Artwork.create!(title: "Wall 2", image_url: "wall.com", artist_id: u5.id)
a9 = Artwork.create!(title: "Stars", image_url: "stars.com", artist_id: u6.id)
a10 = Artwork.create!(title: "Squiggly", image_url: "wiggles.com", artist_id: u6.id)
a11 = Artwork.create!(title: "Cube", image_url: "cubez.com", artist_id: u6.id)

ArtworkShare.create!(artwork_id: a1.id, viewer_id: u6.id)
ArtworkShare.create!(artwork_id: a1.id, viewer_id: u5.id)
ArtworkShare.create!(artwork_id: a2.id, viewer_id: u4.id)
ArtworkShare.create!(artwork_id: a4.id, viewer_id: u1.id)
ArtworkShare.create!(artwork_id: a3.id, viewer_id: u3.id)
ArtworkShare.create!(artwork_id: a5.id, viewer_id: u6.id)
ArtworkShare.create!(artwork_id: a6.id, viewer_id: u7.id)
ArtworkShare.create!(artwork_id: a8.id, viewer_id: u8.id)
ArtworkShare.create!(artwork_id: a2.id, viewer_id: u1.id)
ArtworkShare.create!(artwork_id: a2.id, viewer_id: u5.id)
ArtworkShare.create!(artwork_id: a1.id, viewer_id: u8.id)
ArtworkShare.create!(artwork_id: a9.id, viewer_id: u6.id)
ArtworkShare.create!(artwork_id: a8.id, viewer_id: u7.id)

Comment.create!(
  user_id: u4.id,
  artwork_id: a11.id,
  body: "Dude this is sick!"
)

Comment.create!(
  user_id: u2.id,
  artwork_id: a6.id,
  body: "Dude this is awesome!"
)

Comment.create!(
  user_id: u5.id,
  artwork_id: a2.id,
  body: "Dude this is okay!"
)

Comment.create!(
  user_id: u1.id,
  artwork_id: a10.id,
  body: "Dude this is awful!"
)

