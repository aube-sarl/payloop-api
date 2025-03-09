class Api::V1::MobileMoneyTransactionsController < ApplicationController
  before_action :find_mobile_money_transaction, only: [ :show, :update ]
  def index
    @mobile_money_transactions = MobileMoneyTransaction.where({ account_id: params[:account_id] })

    render json: { status: "success", data: { mobile_money_transactions: @mobile_money_transactions } }
  end

  def show
  end

  def update
  end

  def create
    @account = Account.find(mobile_money_transaction_params[:account_id])
    if @account.nil?
      render json: { status: "fail", error: { message: { FR: "Compte non trouve", EN: "Account not found" } } }, status: :not_found
      return
    end

    if mobile_money_transaction_params[:transaction_type] == "top_up"
      top_up
    elsif mobile_money_transaction_params[:transaction_type] == "withdraw"
      withdraw
    else
      render json: { status: "fail", error: { message: { EN: "Invalid transaction type", FR: "Type de transaction invalide" } } }, status: :unprocessable_entity
    end
  end

  private

  def find_mobile_money_transaction
    @mobile_money_transaction = MobileMoneyTransaction.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { status: "fail", error: { message: { FR: "Transaction non trouvee", EN: "Transaction not found" } } }, status: :not_found
  end

  def top_up
    ActiveRecord::Base.transaction do
      @mobile_money_transaction = MobileMoneyTransaction.new(
      mobile_money_transaction_params.merge(transaction_type: "deposit"))
    @account.update(balance: 0)
    @account.update(balance: @account[:balance] + mobile_money_transaction_params[:amount])
    render_created_mobile_money_transaction
  rescue ActiveRecord::RecordInvalid, ActiveRecord::RecordNotSaved => e
    # Handle validation errors
    render json: { error: { message: { EN: "Transaction failed: #{e.message}", FR: "Transaction annullee, une erreur est survenue" } } }, status: :unprocessable_entity

  rescue StandardError => e
    # Handle any other unexpected errors
    render json: { error: "An error occurred: #{e.message}" }, status: :internal_server_error
  end
  end

  def withdraw
    if account[:balance] < mobile_money_transaction_params[:amount]
      render json: { status: "fail", error: { message: {
        "EN": "Your account balance is too low to complete this transaction.",
        "FR": "Votre solde est insuffisant pour effectuer cette transaction." } } }, status: :unprocessable_entity
      return
    end

    ActiveRecord::Base.transaction do
      @mobile_money_transaction = MobileMoneyTransaction.new(
        mobile_money_transaction_params.merge(transaction_type: "withdraw"))
        @account.update(balance: @account[:balance] - mobile_money_transaction_params[:amount])
        render_created_mobile_money_transaction
      rescue ActiveRecord::RecordInvalid, ActiveRecord::RecordNotSaved => e
        # Handle validation errors
        render json: { error: { message: { EN: "Transaction failed: #{e.message}", FR: "Transaction annullee, une erreur est survenue" } } }, status: :unprocessable_entity

      rescue StandardError => e
        # Handle any other unexpected errors
        render json: { error: "An error occurred: #{e.message}" }, status: :internal_server_error
      end
  end

  def render_created_mobile_money_transaction
    if @mobile_money_transaction.save
      render json: { status: "success", data: { mobile_money_transaction: @mobile_money_transaction } }, status: :created
    else
      render json: { status: "fail", error: { message: { EN: "Transaction failed", FR: "Transaction echouee" } } }, status: :unprocessable_entity
    end
  end

  def mobile_money_transaction_params
    params.require(:mobile_money_transaction).permit(:currency, :fees, :provider_reference_id, :transaction_type, :mobile_money_provider, :phone_number, :account_id, :amount)
  end
end
