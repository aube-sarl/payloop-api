class Api::V1::MobileMoneyTransactionsController < ApplicationController
  before_action :find_mobile_money_transaction, only: [ :show, :update ]
  before_action :find_account_by_account_id, only: [ :create ]

  def index
    @mobile_money_transactions = MobileMoneyTransaction.where(account_id: params[:account_id])
    render json: { status: "success", data: { mobile_money_transactions: @mobile_money_transactions } }
  end

  def show; end

  def update; end

  def create
    case mobile_money_transaction_params[:transaction_type]
    when "top_up"
      top_up
    when "withdraw"
      withdraw
    else
      render json: { status: "fail", error: { message: { EN: "Invalid transaction type", FR: "Type de transaction invalide" } } }, status: :unprocessable_entity
    end
  end

  private

  def find_mobile_money_transaction
    @mobile_money_transaction = MobileMoneyTransaction.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { status: "fail", error: { message: { FR: "Transaction non trouvée", EN: "Transaction not found" } } }, status: :not_found
  end

  def top_up
    ActiveRecord::Base.transaction do
      @mobile_money_transaction = MobileMoneyTransaction.new(
        mobile_money_transaction_params.merge(transaction_type: "deposit", amount: mobile_money_transaction_params[:amount].to_f)
      )

      @account.update!(balance: @account.balance + mobile_money_transaction_params[:amount].to_f)

      @mobile_money_transaction.save!
      render_created_mobile_money_transaction
    end
  rescue ActiveRecord::RecordInvalid, ActiveRecord::RecordNotSaved => e
    render json: { status: "fail", error: { message: { EN: "Transaction failed: #{e.message}", FR: "Transaction annulée, une erreur est survenue" } } }, status: :unprocessable_entity
  rescue StandardError => e
    render json: { status: "fail", error: { message: { EN: "An error occurred: #{e.message}", FR: "Une erreur s'est produite" } } }, status: :internal_server_error
  end

  def withdraw
    if @account.balance < mobile_money_transaction_params[:amount].to_f
      render json: { status: "fail", error: { message: {
        EN: "Your account balance is too low to complete this transaction.",
        FR: "Votre solde est insuffisant pour effectuer cette transaction."
      } } }, status: :unprocessable_entity
      return
    end

    ActiveRecord::Base.transaction do
      @mobile_money_transaction = MobileMoneyTransaction.new(
        mobile_money_transaction_params.merge(transaction_type: "withdraw", amount: mobile_money_transaction_params[:amount].to_f)
      )

      @account.update!(balance: @account.balance - mobile_money_transaction_params[:amount].to_f)

      @mobile_money_transaction.save!
      render_created_mobile_money_transaction
    end
  rescue ActiveRecord::RecordInvalid, ActiveRecord::RecordNotSaved => e
    render json: { status: "fail", error: { message: { EN: "Transaction failed: #{e.message}", FR: "Transaction annulée, une erreur est survenue" } } }, status: :unprocessable_entity
  rescue StandardError => e
    render json: { status: "fail", error: { message: { EN: "An error occurred: #{e.message}", FR: "Une erreur s'est produite" } } }, status: :internal_server_error
  end

  def render_created_mobile_money_transaction
    if @mobile_money_transaction.persisted?
      render json: { status: "success", data: { mobile_money_transaction: @mobile_money_transaction } }, status: :created
    else
      Rails.logger.error "Transaction Save Failed: #{@mobile_money_transaction.errors.full_messages}"
      render json: {
        status: "fail",
        error: {
          message: { EN: "Transaction failed", FR: "Transaction échouée" },
          details: @mobile_money_transaction.errors.full_messages
        }
      }, status: :unprocessable_entity
    end
  end

  def mobile_money_transaction_params
    params.require(:mobile_money_transaction).permit(:currency, :fees, :provider_reference_id, :transaction_type, :mobile_money_provider, :phone_number, :account_id, :amount)
  end

  def find_account_by_account_id
    @account = Account.find_by(id: mobile_money_transaction_params[:account_id])

    if @account.nil?
      render json: { status: "fail", error: { message: { FR: "Compte non trouvé", EN: "Account not found" } } }, status: :not_found
    end
  end
end
