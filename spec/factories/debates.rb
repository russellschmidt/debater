require 'faker'

FactoryGirl.define do
  factory :debate do
    resolution {Faker::Lorem.sentence(20)}
    creator_id {rand(1..User.count)}
  end

end
