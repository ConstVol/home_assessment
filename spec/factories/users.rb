# spec/factories/users.rb

FactoryBot.define do
  factory :user do
    name { Faker::Name.name }  # You can use Faker gem to generate random names
  end
end
