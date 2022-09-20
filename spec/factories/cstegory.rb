FactoryBot.define do
  factory :category do
    name { Faker::Lorem.characters(number:10) }
  end
end