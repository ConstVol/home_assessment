class Api::AppointmentsController < Api::BaseController
  before_action :validate_date_params, only: [:index]

  def index
    available_slots = AvailabilityProvider.provide(params)
    send_response available_slots
  end

  def create
    if slot_occupied?
      send_errors 'Slot is not available for booking', :unprocessable_entity
    elsif new_appointment.save
      send_response new_appointment, :created
    else
      send_errors new_appointment.errors.full_messages, :unprocessable_entity
    end
  end

  def update
    if appointment.update(appointment_params)
      send_response appointment
    else
      send_errors appointment.errors.full_messages, :unprocessable_entity
    end
  end

  def destroy
    if appointment.update(status: Appointment.statuses[:canceled])
      send_response appointment
    else
      send_errors appointment.errors.full_messages, :unprocessable_entity
    end
  end

  private

  def appointment
    Appointment.find_by(id: params[:id])
  end

  def new_appointment
    @new_appointment ||= Appointment.new(
      appointment_params
    ).tap { |a| a.assign_attributes(status: Appointment.statuses[:booked]) }
  end

  def appointment_params
    @appointment_params ||= params.require(:appointment).permit(:user_id, :date, :doctor_id)
  end

  def slot_occupied?
    Appointment.find_by(
      doctor_id: appointment_params[:doctor_id],
      date: appointment_params[:date],
      status: Appointment.statuses[:booked]
    )
  end

  def validate_date_params
    today = Date.today
    start_date = params[:start_date]&.to_date
    end_date = params[:end_date]&.to_date

    if start_date && start_date < today
      send_errors 'Start date must be today or in the future', :unprocessable_entity
    elsif end_date && end_date < today
      send_errors 'End date must be today or in the future', :unprocessable_entity
    elsif start_date && end_date && end_date < start_date
      send_errors 'End date must be the same or greater than the start date', :unprocessable_entity
    end
  end
end
