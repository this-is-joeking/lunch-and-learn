FactoryBot.define do
  factory :user do
    name { Faker::TvShows::BojackHorseman.character }
    email { Faker::Internet.email(name: name) }
  end
end
