FactoryBot.define do
  factory :food do
    association :user
    name { 'Rice' }
    measurement_unit { 'grams' }
    price { 1.5 }
    quantity { 100 }
  end
end
