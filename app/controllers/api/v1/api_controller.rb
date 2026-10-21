class Api::V1::ApiController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods

  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  rescue_from ActionController::ParameterMissing, with: :bad_request

  private

  def authenticate_api_user!
    authenticate_or_request_with_http_token do |token, _options|
      ActiveSupport::SecurityUtils.secure_compare(token, Rails.application.credentials.api_token)
    end
  end

  def request_http_token_authentication(realm = "Application", message = nil)
    render json: { errors: ["Invalid or missing token"] }, status: :unauthorized
  end

  def not_found(exception)
    render json: { errors: ["Record not found"] }, status: :not_found
  end

  def bad_request(exception)
    render json: { errors: [exception.message] }, status: :bad_request
  end
end