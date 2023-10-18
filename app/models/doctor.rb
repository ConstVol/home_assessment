class Doctor < ApplicationRecord
  has_many :appointments
  has_one :working_hour
end
