# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :news do
    title   { Faker::Lorem.words(rand(4) + 2).join(' ') }
    content { Faker::Lorem.paragraphs(rand(3) + 1).join("\n") }
    published_at { 1.day.ago }
  end
end
