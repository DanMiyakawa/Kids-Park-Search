FactoryBot.define do
  factory :contact, class: Contact do
    title { Faker::Lorem.characters(number:10) }
    body { Faker::Lorem.characters(number:30) }
    customer
  end
end