module Api
  module V1
    class TouristSightsController < ApplicationController
      def index
        capital = CountryFacade.get_capital(params[:country])
        require 'pry'; binding.pry
      end
    end
  end
end