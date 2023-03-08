module Api
  module V1
    class LearningResourcesController < ApplicationController
      before_action :validate_params, only: :show
      def show
        learning_resource = LearningResourceFacade.by_country(params[:country])

        render json: LearningResourceSerializer.new(learning_resource), status: :ok
      end

      private

      def validate_params
        return if params[:country]

        render json: ErrorSerializer.missing_param('country'), status: :bad_request
      end
    end
  end
end
