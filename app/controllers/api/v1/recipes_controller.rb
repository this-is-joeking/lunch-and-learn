module Api
  module V1
    class RecipesController < ApplicationController
      def index
        params[:country] = CountryFacade.random unless params[:country]

        recipes = RecipeFacade.by_country(params[:country])
        render json: RecipeSerializer.new(recipes), status: :ok
      end
    end
  end
end
