class Api::V1::CurrenciesController < ApplicationController
  before_action :find_currency, only: [ :update, :show, :destory ]
  def index
    @currencies = Currency.all
    render json: { data: { currencies: @currencies }, status: :ok, message: "Currencies retrieved successfully!" }, status: :ok
  end

  def show
    render json: { data: { currency: @currency }, status: :ok, message: "Currency retrieved successfully!" }, status: :ok
  end

  def create
  end

  def new
    @currency = Currency.new(currency_params)
  end

  def update
    if @currency.update(currency_params)
      render json: { data: { currency: @currency }, status: :ok, message: }
    end
  end

  private

  def find_currency
    @currency = Currency.find(params[:code])
  rescue ActiveRecord::RecordNotFound
    render json: { error: { message: "Currency not found" }, status: :not_found }, status: :not_found
  end

  def currency_params
    params.require(:currency).permit(:code, :name, :symbol)
  end
end
