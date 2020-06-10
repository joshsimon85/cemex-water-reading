FactoryBot.define do
  factory :user do
    full_name { Faker::Name.name }
    email     { Faker::Internet.email }
    password  { Faker::Internet.password(min_length: 6) }
    admin     { false }
  end
end
