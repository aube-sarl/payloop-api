class Api::V1::AccountsController < ApplicationController
  def index
    @accounts = Account.all
    render json: { data: { accounts: @accounts }, status: :ok, message: "Accounts retrieved successfully!" }, status: :ok
  end

  def show
    render json: { data: { account: @account }, status: :ok, message: "Account retrieved successfully!" }, status: :ok
  end

  def create
    @account = Account.new(account_params)
    if @account.save
      render json: { data: { account: @account }, status: :created, message: "Account created successfully!" }, status: :created
    else
      render json: { error: { message: @account.errors.full_messages }, status: :unprocessable_entity }, status: :unprocessable_entity
    end
  end

  private

  def find_account
    @account = Account.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: { message: "Account not found" }, status: :not_found }, status: :not_found
  end

  def account_params
    params.require(:account).permit(:user_id, :account_number, :currency_code, :balance)
  end
end
