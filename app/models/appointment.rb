class Appointment < ApplicationRecord
  belongs_to :doctor
  belongs_to :user

  enum status: {
    booked: 'booked',
    canceled: 'canceled',
  }
  validates :date, presence: true
  validate :appointment_date_in_future, if: -> { status == Appointment.statuses[:booked] }

  private

  def appointment_date_in_future
    errors.add(:date, 'Must be in the future') if date < Date.today
  end
end
