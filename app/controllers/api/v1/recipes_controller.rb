module Api
  module V1
    class RecipesController < ApplicationController
      before_action :check_if_country_is_empty, only: :index
      def index
        recipes = RecipeFacade.by_country(params[:country])
        if recipes.is_a?(Array)
          render json: RecipeSerializer.new(recipes), status: :ok
        else
          render json: ErrorSerializer.invalid_country(params[:country]), status: :bad_request
        end
      end

      private

      def check_if_country_is_empty
        return unless params[:country] == ''

        render json: { data: [] }, status: :ok
      end
    end
  end
end
