class Api::V1::UsersController < ApplicationController
  def index
    @users = User.all

    render json: { status: "success", data: { users: @users } }
  end
end
