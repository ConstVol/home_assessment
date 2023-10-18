# spec/factories/working_hours.rb

FactoryBot.define do
  factory :working_hour do
    association :doctor

    start_time { '09:00:00' }
    end_time { '17:00:00' }
  end
end

