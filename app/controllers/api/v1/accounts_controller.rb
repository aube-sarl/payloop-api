class Api::V1::AccountsController < ApplicationController
  before_action :find_account, only: [ :update, :show  ]
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

  def update
    if  @account.update({ linked_phone_number_network: account_params[:linked_phone_number_network], linked_phone_number: account_params[:linked_phone_number] })
      render json: { status: "success", data: { account: @account } }
    else
      render json: { status: "fail", error: { message: { FR: "Compte non mis a jour.", EN: "Account not updated" } } }
    end
  end

  def show
  end

  private

  def account_params
    params.require(:account).permit(:user_id, :currency, :linked_phone_number_network, :linked_phone_number)
  end
end
