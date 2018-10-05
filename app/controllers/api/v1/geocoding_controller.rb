module Api
  module V1
    class GeocodingController < ApplicationController
      before_action :authenticate_request!

      def geocode
        result = ::GoogleGeocoder.geocode(params[:address])

        if result.success?
          render json: result.location, status: :ok
        else
          render json: { error: result.error_message }, status: :unprocessable_entity
        end
      end
    end
  end
end
