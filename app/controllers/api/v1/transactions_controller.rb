class Api::V1::TransactionsController < ApplicationController
  def index
  end

  def create
    @sender = Account.find(transaction_params[:sender_id])
    @receiver = Account.find(transaction_params[:receiver_id])
  # verify sender balance
  rescue @sender[:balance] < transaction_params[:amount_sent]
    render json: { status: "fail", error: { message: { EN: "You don't have enough money to perform this transaction", FR: "Vous n'avez pas assez d'argent pour effectuer cette transaction, veuillez recharger votre compte" } } }, status: :unprocessable_entity
  # Perform transaction
  @transaction = Transaction.new(transaction_params)
    if @transaction.save
      # Update account balances
      @sender.update(balance: @sender[:balance] - transaction_params[:amount_sent] - transaction_params[:fees])
      @receiver.update(balance: @receiver[:balance] + transaction_params[:amount_received])
      render json: { status: "success", data: { new_balance: @sender[:balance], transaction: @transaction } }
    else
      render json: { status: "fail", error: { message: { EN: "Couldn't perform transaction!", FR: "Une erreur est survenue, transaction non aboutis!" } } }
    end
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
