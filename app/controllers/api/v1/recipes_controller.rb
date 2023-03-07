module Api
  module V1
    class RecipesController < ApplicationController
      def index
        params[:country] = CountryFacade.random unless params[:country]
        # TODO refactor this to not use a country facade, instead we can call the
        # country service in the recipe facade if params[:country] is nil
        recipes = RecipeFacade.by_country(params[:country])
        render json: RecipeSerializer.new(recipes), status: :ok
      end
    end
  end
end
