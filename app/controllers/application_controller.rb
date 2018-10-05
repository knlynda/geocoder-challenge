class ApplicationController < ActionController::API
  def authenticate_request!
    return if AuthorizeApiRequest.new(request.headers).call

    render json: { error: 'Not Authorized.' }, status: :unauthorized
  end
end
