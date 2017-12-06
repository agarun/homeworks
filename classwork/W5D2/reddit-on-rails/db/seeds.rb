# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.destroy_all
Sub.destroy_all
Post.destroy_all
PostSub.destroy_all

u1 = User.create!(username: "bobby", password: "also_bobby")
u2 = User.create!(username: "joey", password: "also_joey")

s1 = Sub.create!(title: "food", description: "lots of food here", mod_id: u1.id)
s2 = Sub.create!(title: "cars", description: "lots of cars here", mod_id: u2.id)

p1 = Post.create!(title: "wow, food", content: "yum", author_id: u2.id)
p2 = Post.create!(title: "wow, cars", content: "wow!", author_id: u1.id)
p3 = Post.create!(title: "wow, more cars", content: "wow ! ! !", author_id: u1.id)
p4 = Post.create!(title: "generic content here", content: "can it get any more generic", author_id: u2.id)

PostSub.create!(post_id: p1.id, sub_id: s1.id)
PostSub.create!(post_id: p2.id, sub_id: s2.id)
PostSub.create!(post_id: p3.id, sub_id: s2.id)
PostSub.create!(post_id: p4.id, sub_id: s1.id)
PostSub.create!(post_id: p4.id, sub_id: s2.id)