class Api::V1::AccountsController < ApplicationController
  def index
    @accounts = Account.where({ user_id: params(:user_id) })

    render json: { status: "success", data: { accounts: @accounts } }
  end

  def create
    @account = Account.new(account_params)
    if @account.save
      render json: { status: "success", data: { account: @account } }, status: :created
    else
      render json: { status: "fail", error: { message: { EN: "Account not created", FR: "Compte non créé" } } }, status: :unprocessable_entity
    end
  end

  private

  def account_params
    params.require(:account).permit(:user_id, :currency, :linked_phone_number_network, :linked_phone_number)
  end
end
