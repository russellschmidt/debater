require 'faker'

FactoryGirl.define do
  factory :user do
    email         { Faker::Internet.free_email }
    password      { Faker::Internet.password(8) }
    confirmed_at  { Faker::Time.between(DateTime.now - 10, DateTime.now) }
  end
end
