# Allow READ_ACTIONS access without authentication
class OpenReadController < ApplicationController
  # Allow unauthenticated access to these actions
  READ_ACTIONS = [:index, :show]
  skip_before_action :authenticate, only: READ_ACTIONS

  # but set current_user if a token is present
  before_action :set_current_user, only: READ_ACTIONS
  def set_current_user
    # for access to authenticate method
    t = ActionController::HttpAuthentication::Token
    @current_user = t.authenticate(self) do |token, _opts|
      User.find_by(token: token)
    end
  end

  private :set_current_user
end
