require 'faker'

FactoryGirl.define do
  factory :position do
    affirmative { [true, false].sample }
    value { Faker::Lorem.word }
    criterion { Faker::Lorem.words(2) }
    debate { Debate.sample }
    user { User.find(id: rand(1..User.count))}
  end

end
