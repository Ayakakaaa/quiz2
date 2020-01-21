FactoryBot.define do
  factory :idea do
    title { Faker::TvShows::Friends.character }
    description { Faker::TvShows::Friends.quote }
    association(:user, factory: :user)
  end
end
