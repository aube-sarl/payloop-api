class Api::V1::CurrenciesController < ApplicationController
  before_action :find_currency, only: [ :update, :show, :destroy ]
  def index
    @currencies = Currency.all
    render json: { data: { currencies: @currencies }, status: :ok, message: "Currencies retrieved successfully!" }, status: :ok
  end

  def show
    render json: { data: { currency: @currency }, status: :ok, message: "Currency retrieved successfully!" }, status: :ok
  end

  def create
    @currency = Currency.new(currency_params)
    if @currency.save
      render json: { data: { currency: @currency }, status: :created, message: "Currency created successfully!" }, status: :created
    else
      render json: { error: { message: @currency.errors.full_messages }, status: :unprocessable_entity }, status: :unprocessable_entity
    end
  end

  def update
    if @currency.update(currency_params)
      render json: { data: { currency: @currency }, status: :ok, message: }, status: :ok
    else
      render json: { error: { message: @currency.errors.full_messages }, status: :unprocessable_entity }, status: :unprocessable_entity
    end
  end

  def destroy
    @currency.destroy
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
