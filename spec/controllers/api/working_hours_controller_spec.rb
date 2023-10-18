# spec/controllers/api/working_hours_controller_spec.rb

require 'rails_helper'

RSpec.describe Api::WorkingHoursController, type: :controller do
  describe 'GET index' do
    it 'returns a list of working hours' do
      doctor = create(:doctor)
      create(:working_hour, doctor: doctor)

      expected_json = {
        "start_time_am_pm": '09:00 AM',
        "end_time_am_pm": '05:00 PM'
      }.to_json

      get :index, params: { doctor_id: doctor.id }

      expect(response).to have_http_status(:success)
      expect(response.body).to eq(expected_json)
    end
  end
end
