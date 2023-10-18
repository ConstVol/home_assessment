FactoryBot.define do
  factory :appointment do
    date { "2023-10-18 22:34:55" }
    doctor { nil }
    user { nil }
    status { "MyString" }
  end
end
