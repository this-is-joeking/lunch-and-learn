module Api
  module V1
    class TouristSightsController < ApplicationController
      def index
        capital_coordinates = CountryFacade.capital_coordinates(params[:country])
        tourism_sights = SightFacade.sights_near(capital_coordinates[:longitude], capital_coordinates[:latitude])
        render json: TouristSightSerializer.new(tourism_sights), status: :ok
      end
    end
  end
end