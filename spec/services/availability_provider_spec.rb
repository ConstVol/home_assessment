require 'rails_helper'

RSpec.describe AvailabilityProvider do
  let(:doctor) { create(:doctor) }
  let(:user) { create(:user) }
  let(:working_hour) { create(:working_hour, doctor: doctor) }

  describe '.provide' do
    it 'returns only available time slots' do
      create(:working_hour, doctor: doctor)
      tomorrow = Date.tomorrow
      free_slot_time = Time.new(
        tomorrow.year, tomorrow.month, tomorrow.day, 12, 0, 0
      ).change(offset: '+0000')

      booked_time = Time.new(
        tomorrow.year, tomorrow.month, tomorrow.day, 13, 0, 0
      ).change(offset: '+0000')

      create(
        :appointment,
        doctor: doctor,
        user: user,
        status: :booked,
        date: booked_time
      )

      available_slots = AvailabilityProvider.provide(doctor_id: doctor.id, start_date: Date.tomorrow)

      expect(available_slots).to include(free_slot_time)
      expect(available_slots).not_to include(booked_time)
      expect(available_slots.length).to eq(7)
    end

    it 'returns eight free time slots' do
      create(:working_hour, doctor: doctor)

      available_slots = AvailabilityProvider.provide(doctor_id: doctor.id, start_date: Date.tomorrow)

      expect(available_slots.length).to eq(8)
    end
  end
end
