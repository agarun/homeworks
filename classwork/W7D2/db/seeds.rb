# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

t1 = Todo.create!(title: 'wash dog', body: 'use soap')
t2 = Todo.create!(title: 'get popcorn recipe', body: 'use soap')
t3 = Todo.create!(title: 'wash car', body: 'use popcorn')
t4 = Todo.create!(title: 'wash popcorn', body: 'dont use soap')
