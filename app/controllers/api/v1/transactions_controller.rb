class Api::V1::TransactionsController < ApplicationController
  def index
  end

  def create
    @sender = Account.find(transaction_params[:sender_id])
    @receiver = Account.find(transaction_params[:receiver_id])
  end

  def show
  end

  def update
  end

  private

  def transaction_params
    params.require(:transaction).permit(:sender_id, :receiver_id, :amount_sent, :currency_sent, :amount_received, :received_currency, :fees, :fees_currency, :transaction_type)
  end
end
