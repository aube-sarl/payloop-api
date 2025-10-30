class Api::V1::UsersController < ApplicationController
  before_action :find_user, only: [ :edit, :update, :show, :destory ]
  def index
    @users = User.all
    render json: { data: { users: @users }, status: :ok, message: "Users retreived successfully!" }, status: :ok
  end

  def show
    render json: { data: { user: @user }, status: :ok, message: "User retreived successfully!" }, status: :ok
  end

  def create
  end

  private

  def find_user
    @user = User.find(params[:id])
  end

  def destroy
    @user.destroy
  rescue ActiveRecord::RecordNotFound
    render json: { error: { message: "user not found" }, status: :not_found }, status: :not_found
  end

  def user_params
    params.require(:user).permit(:firstname, :middlename, :lastname, :email)
  end
end
