FactoryBot.define do
  factory :park, class: Park do
    name { Faker::Lorem.characters(number:10) }
    introduction { Faker::Lorem.characters(number:30) }
    address { Faker::Lorem.characters(number:15) }
    genre
  end
end