FactoryBot.define do
  factory :user do
    name { Faker::Name.first_name}
    sequence(:email) { |n| Faker::Internet.email.sub("@", 
    "-#{n}@") }
    password {'supersecret'}
  end
end
