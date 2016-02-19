# Everything except AuthController should inherit from this
class ProtectedController < ApplicationController
  before_action :authenticate
end
