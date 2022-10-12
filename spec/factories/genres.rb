FactoryBot.define do
  factory :genre, class: Genre do
    name { Faker::Lorem.characters(number: 5) }
  end
end