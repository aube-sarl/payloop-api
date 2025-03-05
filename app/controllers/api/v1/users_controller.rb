class Api::V1::UsersController < ApplicationController
  before_action :find_user, only: [ :update, :destroy, :show ]
  def index
    @users = User.all
    render json: { status: "success", data: { users: @users } }
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render json: { status: "success", data: { user: @user } }, status: :created
    else
      render json: { status: "fail", error: { message: { EN: "Couldn't create user", FR: "N'a pas pu creer l'utilisateur" } } }, status: :unprocessable_entity
    end
  end

  def update
    if @user.update(user_params)
      render json: { status: "success", message: { EN: "User successfully updated", FR: "Utilisateur mis à jour avec success." } }
    else
    end
  end

  def show
    render json: { status: "success", data: { user: @user } }
  end

  def destroy
    @user.destroy
  rescue ActiveRecord::RecordNotDestroyed
    render json: { status: "fail", error: { message: { EN: "User not deleted", FR: "Utilisateur non supprimé" } } }, status: :unprocessable_entity
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :middle_name, :email, :phone_number)
  end

  def find_user
    @user = User.find(params[:user_id])
  rescue ActiveRecord::RecordNotFound
    render json: { status: "fail", error: { message: { EN: "Couldn't find user.", FR: "N'a pas pu trouver l'utilisateur." } } }
  end
end
