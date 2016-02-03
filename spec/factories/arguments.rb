require 'faker'

FactoryGirl.define do
  factory :argument do
    claim       { Faker::Lorem.sentence }
    warrant     { Faker::Lorem.sentence }
    impact      { Faker::Lorem.sentence }
    citation    { Faker::Lorem.sentence }
    contention  { Contention.all.sample }
  end

end
