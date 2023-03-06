module Api
  module V1
    class TouristSightsController < ApplicationController
      def index
        capital_info = CountryFacade.get_capital(params[:country])
        tourism_sights = SightsFacade.sights_near(capital_info[:longitude], capital_info[:latitude])
        require 'pry'; binding.pry
      end
    end
  end
end