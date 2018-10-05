module Api
  module V1
    class AuthenticationController < ApplicationController
      def authenticate
        auth_token = AuthenticateUser.new(params[:email], params[:password]).call

        if auth_token.present?
          render json: { auth_token: auth_token }
        else
          render json: { error: 'Invalid credentials.' }, status: :unauthorized
        end
      end
    end
  end
end
