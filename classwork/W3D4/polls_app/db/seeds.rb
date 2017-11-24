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
# poll = {'Rate Thanksgiving meal' => {'Turkey'=> [3,2,1], 'Pecan Pie' => [3,2,1], 'Stuffing' => [3,2,1]}, 
#         'Favorite AppAcademy TA' => {'Mashu'=> ['Yes', 'No'], 'Ommi'=> ['Yes', 'No'], 'Alex'=> ['Yes', 'No'], 'Moe'=> ['Yes', 'No'], 'Mike'=> ['Yes', 'No']}, 
#         'Rate AppAcdemy topics' => {'SQL' => [5,4,3,2,1], 'Ruby'=> [5,4,3,2,1], 'BigO'=> [5,4,3,2,1]}} 


user.each { |name| User.create({username: name}) }

# i = 1 # user / poll
# j = 1 # ques
# 
# poll.each do |poll_title, ques_data|
#   Poll.create(title: poll_title, user_id: i)
# 
#   ques_data.each do |question, choices|
#     Question.create(text: question, poll_id: i)
#     choices.each_with_index {|answer| AnswerChoice.create(text: answer, question_id: j )}
#     j += 1
#   end
# 
#   i += 1 
# end

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






