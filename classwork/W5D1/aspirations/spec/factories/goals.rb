FactoryBot.define do
  factory :goal do
    goal { Faker::Team.sport }
  end
end
