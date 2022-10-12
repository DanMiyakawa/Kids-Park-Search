FactoryBot.define do
  factory :customer do
    nickname { Faker::Lorem.characters(number:5) }
    email { Faker::Lorem.characters(number:10) }
  end
  factory :park do
    customer_id { Faker::Lorem.characters(number:1) }
    name { Faker::Lorem.characters(number:10) }
    introduction { Faker::Lorem.characters(number:30) }
    address { Faker::Lorem.characters(number:15) }
    genre_id { Faker::Lorem.characters(number:1) }
  end
end