module Api
  module V1
    class LearningResourcesController < ApplicationController
      def show
        learning_resource = LearningResourceFacade.by_country(params[:country])

        render json: LearningResourceSerializer.new(learning_resource), status: :ok
      end
    end
  end
end
