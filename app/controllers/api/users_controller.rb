class Api::UsersController < ApplicationController
  def index
    @users  = User.all
    render json: { data: { users: @users }, status: :ok }, status: :ok
  end

  def show
    render json: { data: { user: @user }, status: :ok }, status: :ok
  end

  def create
  end
  private

  def user
    @user ||= User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:firstname, :lastname, :middlename, :email)
  end
end
