class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordInvalid, with: :render_error

  private

  def render_error(error)
    render json: ErrorSerializer.user_error(error.message), status: :unprocessable_entity
  end
end
