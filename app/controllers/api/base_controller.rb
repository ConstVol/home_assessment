module Api
  class BaseController < ActionController::Base
    private

    def send_response(object, status = :ok, serializer = nil)
      if serializer
        render json: object, status: status, serializer: serializer
      else
        render json: object, status: status
      end
    end

    def send_errors(error, status)
      render json: { errors: error }, status: status
    end
  end
end
