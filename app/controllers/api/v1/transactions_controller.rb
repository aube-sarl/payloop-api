class Api::V1::TransactionsController < ApplicationController
  def index
  end

  def create
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
