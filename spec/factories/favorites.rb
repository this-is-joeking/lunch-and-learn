FactoryBot.define do
  factory :favorite do
    user_id { rand(User.minimum(:id)..User.maximum(:id)) }
    country { Faker::Address.country }
    recipe_link { Faker::Internet.url }
    recipe_title { Faker::Food.dish }
  end
end
