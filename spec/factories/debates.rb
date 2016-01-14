require 'faker'

FactoryGirl.define do
  factory :debate do
    title {Faker::Lorem.sentence}
    topic {Faker::Lorem.paragraph}
    user  {User.sample}
  end
end
