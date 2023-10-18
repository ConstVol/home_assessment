class Api::WorkingHoursController < ApplicationController
  def index
    render json: working_hours, serializer: WorkingHourSerializer
  end

  private

  def working_hours
    WorkingHour.find_by!(doctor_id: params[:doctor_id])
  end
end
