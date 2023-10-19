class Api::WorkingHoursController < Api::BaseController
  def index
    send_response working_hours, :ok, WorkingHourSerializer
  end

  private

  def working_hours
    WorkingHour.find_by!(doctor_id: params[:doctor_id])
  end
end
