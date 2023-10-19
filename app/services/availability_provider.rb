# Service object

class AvailabilityProvider
  APPOINTMENT_DURATION = 1.hour.freeze

  def self.provide(params)
    new(params).provide
  end

  attr_reader :doctor_id, :start_date, :end_date, :appointment_duration

  def initialize(params)
    @doctor_id = params[:doctor_id]
    @start_date = params[:start_date]&.to_date || Date.today
    @end_date = params[:end_date]&.to_date || start_date
  end

  def provide
    build_availability
  end

  private

  def build_availability
    available_slots = []
    (start_date..end_date).each do |date|
      next if date.saturday? || date.sunday?

      available_slots += free_time_slots(date)
    end
    available_slots
  end

  def free_time_slots(date)
    available_slots = []

    target_time = add_target_date(date, working_hours.start_time)
    end_time = add_target_date(date, working_hours.end_time)
    while target_time + APPOINTMENT_DURATION <= end_time
      available_slots << target_time if available?(target_time)
      target_time += APPOINTMENT_DURATION
    end
    available_slots
  end

  def appointments
    @appointments ||= Appointment.where(
      doctor_id: doctor_id, date: (start_date - 1)...(end_date + 1), status: Appointment.statuses[:booked]
    )
  end

  def working_hours
    @working_hours ||= WorkingHour.find_by!(doctor_id: doctor_id)
  end

  def time_now
    @time_now ||= DateTime.now
  end

  def add_target_date(target_date, time)
    Time.new(target_date.year, target_date.month, target_date.day, time.hour, time.min).change(offset: '+0000')
  end

  def available?(target_time)
    time_now < target_time && appointments.none? { |a| a.date == target_time }
  end
end
