FactoryBot.define do
  factory :user do
    full_name    { Faker::Name.name }
    email        { Faker::Internet.email }
    password     { Faker::Internet.password(min_length: 6) }
    admin        { false }
    confirmed_at { Time.now }
    suspended    { false }
  end

  factory :water_meter_reading do
    user_id { Faker::Number.number }
    reading { Faker::Number.decimal }

    trait :with_image do
      image { Rack::Test::UploadedFile.new('spec/support/assets/test_image.jpeg', 'image/jpeg') }
    end
  end

  factory :invitation do
    email   { Faker::Internet.email }
    user_id { Faker::Number.number }
    admin   { false }
  end

  factory :audit do
    types = ['User', 'Water Meter Reading', 'Invitations']
    actions = ['update', 'destroy', 'create']

    created_by  { Faker::Name.name }
    record_id   { Faker::Lorem.word }
    action_type { types.sample }
    record_type { actions.sample }
  end
end
