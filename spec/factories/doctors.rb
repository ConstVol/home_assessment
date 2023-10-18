# spec/factories/doctors.rb

FactoryBot.define do
  factory :doctor do
    name { Faker::Name.name }
    specialization { Faker::Lorem.word }
  end
end
