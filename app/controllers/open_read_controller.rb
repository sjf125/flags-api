# Allow READ_ACTIONS access without authentication
class OpenReadController < ApplicationController
  # for access to token_and_options method
  TokenAuth = ActionController::HttpAuthentication::Token
  READ_ACTIONS = [:index, :show]
  skip_before_action :authenticate, only: READ_ACTIONS
  before_action :set_current_user, only: READ_ACTIONS

  private

  # set current_user if unset and token present
  def set_current_user
    return if current_user
    tok_opts = TokenAuth.token_and_options(request)
    @current_user =
      User.find_by(token: tok_opts.first) if tok_opts
  end
end
