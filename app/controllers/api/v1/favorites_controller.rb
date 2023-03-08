module Api
  module V1
    class FavoritesController < ApplicationController
      before_action :find_user, only: [:create, :index]

      def create
        @user.favorites.create(favorite_params)
        render json: MessageSerializer.favorite_success, status: :created
      end

      def index
        render json: FavoriteSerializer.new(@user.favorites), status: :ok
      end

      private

      def favorite_params
        params.require(:favorite).permit(:country, :recipe_link, :recipe_title)
      end

      def find_user
        @user = User.find_by(api_key: params[:api_key])
        
        render json: ErrorSerializer.invalid_key, status: :unauthorized unless @user
      end
    end
  end
end
