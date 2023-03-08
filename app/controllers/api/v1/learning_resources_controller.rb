module Api
  module V1
    class LearningResourcesController < ApplicationController
      before_action :validate_params, only: :show

      def show
        learning_resource = LearningResourceFacade.by_country(params[:country])

        if learning_resource.is_a?(LearningResource)
          render json: LearningResourceSerializer.new(learning_resource), status: :ok
        else 
          render json: ErrorSerializer.invalid_country(params[:country]), status: :bad_request
        end
      end

      private

      def validate_params
        return if params[:country].present?

        if params[:country] == ''
          render json: ErrorSerializer.missing_value('country'), status: :bad_request
        else
          render json: ErrorSerializer.missing_param('country'), status: :bad_request
        end
      end
    end
  end
end
