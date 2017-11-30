# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Cat.destroy_all
CatRentalRequest.destroy_all

Cat.create!(birth_date: '2015/01/02', color: 'yellow', name: 'Spot', sex: 'F', description: 'Spotty cat.')
felix = Cat.create!(birth_date: '2014/06/02', color: 'red', name: 'Felix', sex: 'M', description: 'Felix is a cat.')
whiskers = Cat.create!(birth_date: '2005/01/02', color: 'green', name: 'Whiskers', sex: 'F', description: 'Ive got whiskers')
Cat.create!(birth_date: '2016/01/02', color: 'yellow', name: 'Spots sister', sex: 'F', description: 'Spotty cats sister.')
Cat.create!(birth_date: '2009/01/02', color: 'teal', name: 'Coco', sex: 'F', description: 'COCO')

CatRentalRequest.create!(cat_id: felix.id, start_date: '2013/05/05', end_date: '2016/05/05', status: 'APPROVED')
CatRentalRequest.create!(cat_id: felix.id, start_date: '2014/05/05', end_date: '2016/05/05', status: 'DENIED')
CatRentalRequest.create!(cat_id: whiskers.id, start_date: '2013/05/05', end_date: '2014/05/05', status: 'APPROVED')
CatRentalRequest.create!(cat_id: whiskers.id, start_date: '2015/05/05', end_date: '2016/05/05', status: 'APPROVED')