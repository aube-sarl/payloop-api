class Api::V1::TransactionsController < ApplicationController
  before_action :set_transaction, only: [ :show, :update ]
  def index
    @transactions = Transaction.all
    render json: { data: { transactions: @transactions, message: "Transactions successfully retrieved!" } }, status: :ok
  end

  def create
    @sender_account = find_account(transaction_params[:sender_account_id])
    @receiver_account = find_account(transaction_params[:receiver_account_id])

    if @sender_account.balance < transaction_params[:amount_sent].to_d + transaction_params[:transaction_fees].to_d
      render json: { error: { message: "Insufficient funds in sender's account" } }, status: :unprocessable_entity
    end
    @transaction = Transaction.new(transaction_params, sender_initial_balance: @sender_account.balance, receiver_initial_balance: @receiver_account.balance)
    if @transaction.save
      @sender_account.update(balance: @sender_account.balance - transaction_params[:amount_sent].to_d - transaction_params[:transaction_fees].to_d)
      @receiver_account.update(balance: @receiver_account.balance + transaction_params[:amount_received].to_d)
      render json: { data: { transaction: @transaction, message: "Transaction successfully created!" } }, status: :created
    else
      render json: { error: { message: @transaction.errors.full_messages.join(", ") } }, status: :unprocessable_entity
    end
  end

  def show
    render json: { data: { transaction: @transaction, message: "Transaction successfully retrieved!" }, status: :ok }, status: :ok
  end

  def update
    if @transaction.update(transaction_params)
      render json: { data: { transaction: @transaction, message: "Transaction successfully updated!" } }, status: :ok
    else
      render json: { error: { message: @transaction.errors.full_messages.join(", ") }, status: :unprocessable_entity }, status: :unprocessable_entity
    end
  end

  private

  def transaction_params
    params.require(:transaction).permit(:sender_account_id, :receiver_account_id, :amount_sent, :amount_received, :exchange_rate, :transaction_fees, :status)
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
