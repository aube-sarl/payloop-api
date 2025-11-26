class Api::V1::TransactionsController < ApplicationController
  before_action
  def index
    @transactions = Transaction.all
    render json: { data: { transactions: @transactions, message: "Transactions successfully retrieved!" } }, status: :ok
  end

  private
  def transaction_params
    params.require(:transaction).permit(:sender_account_id, :receiver_account_id, :amount_sent, :amount_received, :sender_initial_balance, :receiver_initial_balance, :exchange_rate, :transaction_fees, :status)
  end

  def set_transaction
    @transaction = Transaction.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: { message: "Transaction not found" } }, status: :not_found
  end

  def find_account(account_id)
    Account.find(account_id)
  rescue ActiveRecord::RecordNotFound
    render json: { error: { message: "Account with ID #{account_id} not found" } }, status: :not_found
  end

  def find_user(user_id)
    User.find(user_id)
  rescue ActiveRecord::RecordNotFound
    render json: { error: { message: "User with ID #{user_id} not found" } }, status: :not_found
  end
end
