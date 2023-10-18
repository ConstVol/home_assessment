class WorkingHourSerializer < ActiveModel::Serializer
  type 'working_hours'
  attributes :start_time_am_pm, :end_time_am_pm

  def start_time_am_pm
    object.start_time.strftime('%I:%M %p')
  end

  def end_time_am_pm
    object.end_time.strftime('%I:%M %p')
    end
end
