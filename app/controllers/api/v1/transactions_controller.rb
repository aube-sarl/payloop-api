class Api::V1::TransactionsController < ApplicationController
  def index
    @transactions = Transaction.where(sender_id: params[:account_id]).or(Transaction.where(receiver_id: params[:account_id]))

    render json: { status: "success", data: { transactions: @transactions.as_json(includes: {sender: } ) } }
  end

  def create
  end

  def show
  end

  def update
  end

  private

  def transaction_params
  end

  def find_transactions
  end
end
