module Api
  module V1
    class FavoritesController < ApplicationController
      before_action :find_user, only: :create
      def create
        if @user
          @user.favorites.create(favorite_params)
          render json: MessageSerializer.favorite_success, status: :created
        else
          render json: ErrorSerializer.invalid_key, status: :unauthorized
        end
      end

      private

      def favorite_params
        params.require(:favorite).permit(:country, :recipe_link, :recipe_title)
      end

      def find_user
        @user = User.find_by(api_key: params[:api_key])
      end
    end
  end
end