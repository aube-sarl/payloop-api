class Api::V1::TransactionsController < ApplicationController
  before_action :find_transactions, only: [ :show, :update ]
  def index
    @transactions = Transaction.where(sender_id: params[:account_id]).or(Transaction.where(receiver_id: params[:account_id]))

    render json: { status: "success", data: { transactions: @transactions.as_json(includes: [ :sender, :receiver ]) } }
  end

  def create
    begin
      # Select sender and receiver
      @sender = Account.find(transaction_params[:sender_id])
      @receiver = Account.find(transaction_params[:receiver_id])

    rescue ActiveRecord::RecordNotFound
      render json: {
        status: "fail",
        error: { message: { FR: "Envoyeur ou récepteur invalide", EN: "Invalid sender or receiver." } }
      }, status: :not_found
      return
    end

    # rescue for balance less than transaction
    if @sender[:balance] < transaction_params[:amount_sent]
      render json: { status: "fail", error: {
        message: {
          FR: "Vous n'avez pas assez d'argent pour performer cette transaction! Veuillez recharger votre compte.",
          EN: "You don't have enough money to make this transaction! Please top up your account."
          }
        }
      }
      return
    end

    begin
      ActiveRecord::Base.transaction do
        # Subtract sent amount from sender account
        @sender.update!(balance: @sender[:balance] - transaction_params[:amount_sent])

        # Add received amount to receiver account
        @receiver.update!(balance: @receiver[:balance] + transaction_params[:amount_received])

        # Save transaction record
        @transaction = Transaction.create!(transaction_params)
      end

      # If everything goes well
      render json: { status: "success", data: { message: "Transaction successful", transaction: @transaction } }, status: :ok

    rescue ActiveRecord::RecordInvalid, ActiveRecord::RecordNotSaved => e
      # Handle validation errors
      render json: { error: { message: { EN: "Transaction failed: #{e.message}", FR: "Transaction annullee, une erreur est survenue" } } }, status: :unprocessable_entity

    rescue StandardError => e
      # Handle any other unexpected errors
      render json: { error: "An error occurred: #{e.message}" }, status: :internal_server_error
    end
  end
  def show
    render json: { status: "success", data: { transaction: @transaction } }
  end

  def update
    if @transaction.update({ status: transaction_params[:status] })
      render json: { status: "success", data: { transaction: @transaction } }
    else
      render json: { status: "fail", error: { message: { EN: "Transaction not updated", FR: "Transaction non mis a jour" } } }, status: :unprocessable_entity
    end
  end

  private

  def transaction_params
    params.require(:transaction).permit(:sender_id, :receiver_id, :amount_sent, :currency_sent, :amount_received, :currency_received, :fees, :currency_fees, :transaction_type)
  end

  def find_transactions
    @transaction = Transaction.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { status: "fail", error: { message: { EN: "Transaction not found", FR: "Transaction non trouvee" } } }
  end
end
