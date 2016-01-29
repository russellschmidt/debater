require 'faker'

FactoryGirl.define do
  factory :position do
    affirmative { rand(0..1) == 1 ? true : false }
    value { Faker::Lorem.word }
    criterion { Faker::Lorem.words(2) }
    debate { Debate.find(id: rand(1..Debate.count))}
    user { User.find(id: rand(1..User.count))}
  end

end
