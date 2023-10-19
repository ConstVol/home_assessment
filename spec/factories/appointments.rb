FactoryBot.define do
  factory :appointment do
    date { '2023-10-19 15:00' }
    doctor { nil }
    user { nil }
    status { 'booked' }
  end
end
