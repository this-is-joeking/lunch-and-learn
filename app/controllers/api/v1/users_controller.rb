module Api
  module V1
    class UsersController < ApplicationController
    rescue_from ActiveRecord::RecordInvalid, with: :render_error

      def create
        user = User.create!(user_params)
        render json: UserSerializer.new(user), status: :created
      end

      private

      def user_params
        params.permit(:name, :email)
      end

      def render_error(error)
        render json: ErrorSerializer.user_error(error.message), status: :unprocessable_entity
      end
    end
  end
end
