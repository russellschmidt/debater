require 'faker'

FactoryGirl.define do
  factory :debate do
    title {Faker::Lorem.sentence}
    topic {Faker::Lorem.paragraph}
    user  {User.find(rand(1..(User.count-1)))}
  end
end
