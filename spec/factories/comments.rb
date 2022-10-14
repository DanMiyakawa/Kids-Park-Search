FactoryBot.define do
  factory :comment, class: Comment do
    comment { Faker::Lorem.characters(number:20) }
  end
end