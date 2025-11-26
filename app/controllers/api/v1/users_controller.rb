class Api::V1::UsersController < ApplicationController
  before_action :find_user, only: [ :update, :show, :destroy ]
  def index
    @users = User.all
    render json: { data: { users: @users }, status: :ok, message: "Users retreived successfully!" }, status: :ok
  end

  def show
    render json: { data: { user: @user }, status: :ok, message: "User retreived successfully!" }, status: :ok
  end

  def create
  end

  def new
    @user = User.new(user_params)
    if @user.save
      render json: { data: { user: @user, message: "User successfully created!" }, status: :created }, status: :created
    else
      render json: { error: { message: @user.errors.full_messages.join(", ") }, status: :unprocessable_entity }, status: :unprocessable_entity
    end
  end

  def update
  end

  def destroy
    @user.destroy
  rescue ActiveRecord::RecordNotFound
    render json: { error: { message: "user not found" }, status: :not_found }, status: :not_found
  end

  private

  def find_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:first_name, :middle_name, :lastname, :email)
  end
end
