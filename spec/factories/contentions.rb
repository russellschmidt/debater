require 'faker'

FactoryGirl.define do
  factory :contention do
    topic   {Faker::Lorem.sentence}
    summary {Faker::Lorem.paragraph}
    speech  {Speech.all.sample}
    assertion_id nil
  end

end
