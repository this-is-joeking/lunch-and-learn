module Api
  module V1
    class UsersController < ApplicationController
      def create
        user = User.create!(user_params)
        render json: UserSerializer.new(user), status: :created
      end

      private

      def user_params
        params.permit(:name, :email)
      end
    end
  end
end