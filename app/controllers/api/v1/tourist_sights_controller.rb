module Api
  module V1
    class TouristSightsController < ApplicationController
      def index
        capital_info = CountryFacade.get_capital(params[:country])
        tourism_sights = SightFacade.sights_near(capital_info[:longitude], capital_info[:latitude])
        render json: TouristSightSerializer.new(tourism_sights), status: :ok
      end
    end
  end
end