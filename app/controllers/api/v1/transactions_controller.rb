class Api::V1::TransactionsController < ApplicationController
  before_action :find_transactions, only: [ :show, :update ]
  def index
    @transactions = Transaction.where(sender_id: params[:account_id]).or(Transaction.where(receiver_id: params[:account_id]))

    render json: { status: "success", data: { transactions: @transactions.as_json(includes: [ :sender, :receiver ]) } }
  end

  def create
    @Transaction = Transaction.new(transaction_params)
    if @transaction.save
      render json: { status: "success", data: { transaction: @transaction } }, status: :created
    else
      render json: { status: "fail", error: { message: { FR: "Transaction annnulee", EN: "Transaction aborted" } } }
    end
  end

  def show
    render json: { status: "success", data: { transaction: @transaction } }
  end

  def update
    if @transaction.update()
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
