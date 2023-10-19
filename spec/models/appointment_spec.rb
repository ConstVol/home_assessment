require 'rails_helper'

RSpec.describe Appointment, type: :model do
  it 'validates the presence of date' do
    appointment = build(:appointment, date: nil)
    appointment.valid?
    expect(appointment.errors[:date]).to include("can't be blank")
  end

  context 'when status is booked' do
    it 'requires a date in the future' do
      appointment = build(:appointment, status: :booked, date: Date.yesterday)
      appointment.valid?
      expect(appointment.errors[:date]).to include('Must be in the future')

      appointment.date = Date.tomorrow
      appointment.valid?
      expect(appointment.errors[:date]).not_to include('Must be in the future')
    end
  end

  context 'when status is canceled' do
    it 'does not require a date in the future' do
      appointment = build(:appointment, status: :canceled, date: Date.yesterday)
      appointment.valid?
      expect(appointment.errors[:date]).not_to include('Must be in the future')
    end
  end
end
