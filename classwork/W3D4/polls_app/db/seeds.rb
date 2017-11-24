# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.destroy_all
Poll.destroy_all
AnswerChoice.destroy_all
Response.destroy_all
Question.destroy_all

user = ['Aaron', 'Elena'] # , 'Nakodila']

user.each { |name| User.create({username: name}) }

User.create(username: 'Aaron')

Poll.create(title: 'Rate Thanksgiving meal', user_id: User.find_by(username: 'Aaron').id)

Question.create(text: 'Turkey', poll_id: Poll.find_by(title: 'Rate Thanksgiving meal').id)

AnswerChoice.create(text: 3, question_id: Question.find_by(text: 'Turkey').id)
AnswerChoice.create(text: 2, question_id: Question.find_by(text: 'Turkey').id)
AnswerChoice.create(text: 1, question_id: Question.find_by(text: 'Turkey').id)

Question.create(text: 'Pecan Pie', poll_id: Poll.find_by(title: 'Rate Thanksgiving meal').id)

AnswerChoice.create(text: 3, question_id: Question.find_by(text: 'Pecan Pie').id)
AnswerChoice.create(text: 2, question_id: Question.find_by(text: 'Pecan Pie').id)
AnswerChoice.create(text: 1, question_id: Question.find_by(text: 'Pecan Pie').id)

Question.create(text: 'Stuffing', poll_id: Poll.find_by(title: 'Rate Thanksgiving meal').id)

AnswerChoice.create(text: 3, question_id: Question.find_by(text: 'Stuffing').id)
AnswerChoice.create(text: 2, question_id: Question.find_by(text: 'Stuffing').id)
AnswerChoice.create(text: 1, question_id: Question.find_by(text: 'Stuffing').id)

Response.create(
  user_id: User.find_by(username: 'Elena').id,
  answer_choice_id: AnswerChoice.find_by(text: 1, question_id: Question.find_by(text: 'Turkey').id).id
)

Response.create(
  user_id: User.find_by(username: 'Elena').id,
  answer_choice_id: AnswerChoice.find_by(text: 3, question_id: Question.find_by(text: 'Pecan Pie').id).id
)

Response.create(
  user_id: User.find_by(username: 'Elena').id,
  answer_choice_id: AnswerChoice.find_by(text: 2, question_id: Question.find_by(text: 'Stuffing').id).id
)

Response.create(
  user_id: User.find_by(username: 'Elena').id,
  answer_choice_id: AnswerChoice.find_by(text: 1, question_id: Question.find_by(text: 'Stuffing').id).id
)

Poll.create(title: 'Favorite AppAcademy TA', user_id: User.find_by(username: 'Elena').id)

Question.create(text: 'Ommi', poll_id: Poll.find_by(title: 'Favorite AppAcademy TA').id)

AnswerChoice.create(text: 'Yes', question_id: Question.find_by(text: 'Ommi').id)
AnswerChoice.create(text: 'No', question_id: Question.find_by(text: 'Ommi').id)

Question.create(text: 'Alex', poll_id: Poll.find_by(title: 'Favorite AppAcademy TA').id)

AnswerChoice.create(text: 'Yes', question_id: Question.find_by(text: 'Alex').id)
AnswerChoice.create(text: 'No', question_id: Question.find_by(text: 'Alex').id)

Question.create(text: 'Moe', poll_id: Poll.find_by(title: 'Favorite AppAcademy TA').id)

AnswerChoice.create(text: 'Yes', question_id: Question.find_by(text: 'Moe').id)
AnswerChoice.create(text: 'No', question_id: Question.find_by(text: 'Moe').id)

Response.create(
  user_id: User.find_by(username: 'Aaron').id,
  answer_choice_id: AnswerChoice.find_by(text: 'Yes', question_id: Question.find_by(text: 'Ommi').id).id
)

Response.create(
  user_id: User.find_by(username: 'Aaron').id,
  answer_choice_id: AnswerChoice.find_by(text: 'Yes', question_id: Question.find_by(text: 'Alex').id).id
)

Response.create(
  user_id: User.find_by(username: 'Aaron').id,
  answer_choice_id: AnswerChoice.find_by(text: 'Yes', question_id: Question.find_by(text: 'Moe').id).id
)
