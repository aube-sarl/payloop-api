class Api::V1::ExchangeRatesController < ApplicationController
  before_action :find_exchange_rate, only: [ :update_one, :show_one ]
  def index
    @exchange_rates = ExchangeRate.all

    render json: { status: "success", data: { exchange_rates: @exchange_rates } }
  end

  def create
    @exchange_rate = ExchangeRate.new(exchange_rate_params)

    if @exchange_rate.save
      render json: { status: "success", data: { exchage_rate: @exchange_rate } }, status: :created
    else
      render json: { status: "fail", error: { message: "Couldn't create exchange rate" } }, status: :fail
    end
  end

  def update_one
    if @exchange_rate.update(exchange_rate_params)
      render json: { status: "success", data: { exchange_rate: @exchange_rate } }
    else
      render json: { status: "fail", error: { message: "Couldn't update exchange rate" } }
    end
  end

  def show_one
    render json: { status: "success", data: { exchange_rate: @exchange_rate } }
  end

  private

  def exchange_rate_params
    params.require(:exchange_rate).permit(:base_currency, :target_currency, :rate)
  end

  def find_exchange_rate
    @exchange_rate = ExchangeRate.find({ base_currency: params[:base_currency], target_currency: params[:target_currency] })
  end
end
