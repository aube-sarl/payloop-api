class Api::V1::UsersController < ApplicationController
  def index
    @users = User.all
    render json: {status: "success", data: {users: @users}}, status: :success
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render json: { status: "success", data: { user: @user } }, status: :created
    else
      render json: {status: "fail", error: { message: ""}}
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :middle_name, :email, :phone_number)
  end

  def find_user
    @user = User.find(params[:user_id])
  rescue
  end
end
