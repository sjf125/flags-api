#
class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]

  # GET /users
  def index
    @users = User.all

    render json: @users
  end

  # GET /users/1
  def show
    if current_user == @user
      render json: @user, serializer: CurrentUserSerializer, root: 'user'
    else
      render json: @user
    end
  end

  # PATCH /users/1
  def update
    if current_user == @user
      if @user.update(user_params)
        head :no_content
      else
        render json: @user.errors, status: :unprocessable_entity
      end
    else
      head :unauthorized
    end
  end

  # DELETE /users/1
  def destroy
    if current_user == @user
      @user.destroy
      head :no_content
    else
      head :unauthorized
    end
  end

  def set_user
    @user = User.find(params[:id])
  end

  private :set_user
end
