module Api
  module V1
  class RecipesController < ApplicationController
  def index
    recipes = RecipeFacade.by_country(params[:country])
    render json: RecipeSerializer.new(recipes), status: :ok
  end
  end
  end
end
