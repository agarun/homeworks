FactoryBot.define do
  factory :user do
    username { Faker::Internet.user_name }
    password { Faker::Internet.password(6) }
    
    factory :user_with_valid_password do
      username 'jerry'
      password 'valid_password'
    end
    
    factory :invalid_user do
      username ''
    end
  end
end
