# spec/factories/recipes.rb
FactoryBot.define do
  factory :recipe do
    name { Faker::Food.dish }
    description { Faker::Food.description }
    preparation_time { rand(10..120) }
    cooking_time { rand(10..300) }
    public { [true, false].sample }
    user
  end
end
