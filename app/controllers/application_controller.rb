#
class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods
  include ActionController::Serialization

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  before_action :authenticate

  private

  attr_reader :current_user

  def authenticate
    authenticate_or_request_with_http_token do |token, _options|
      @current_user = User.find_by token: token
    end
  end

  def record_not_found
    render json: { message: 'Not Found' }, status: :not_found
  end
end
