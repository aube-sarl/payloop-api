class Api::V1::AccountsController < ApplicationController
  def index
  end

  def create
    @account = Account.new(account_params)
    if @account.save
      render json: { status: "success", data: { account: @account } }, status: :created
    else
      render json: { status: "fail", error: { message: "Couldn't create account" } }, status: :unprocessable_entity
    end
  end

  private
  def account_params
    params.require(:account).permit(:user_id, :currency, :linked_phone_number_provider, :linked_phone_number)
  end
end
a
