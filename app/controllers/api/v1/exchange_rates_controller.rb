class Api::V1::ExchangeRatesController < ApplicationController
  before_action :find_exchange_rate, only: [ :update ]
  def index
    @exchange_rates = ExchangeRate.include(:base_currency, :target_currency)

    render json: { status: "success", data: { exchange_rates: @exchange_rates } }
  end

  def create
    @exchange_rate = ExchangeRate.new(exchange_rate_params)

    if @exchange_rate.save
      render json: { status: "success", data: { exchange_rate: @exchange_rate, message: { FR: "Taux d'echange cree avec succes", EN: "Exchange rate successfully created." } } }, status: :created
    else
      render json: { status: "fail", error: { message: { FR: "Echec de la creation du taux d'echange", EN: "Couldn't create exchange rate" } } }, status: :unprocessable_entity
    end
  end

  def update
    if @exchange_rate.update(exchange_rate_params)
      render json: { status: "success", data: { exchange_rate: @exchange_rate, message: { FR: "Taux d'echange mis a jour", EN: "Exchange rate update." } } }
    else
      render json: { status: "fail", error: { message: { FR: "Echec de la mise a jour du taux d'echange", EN: "Couldn't update exchange rate" } } }, status: :unprocessable_entity
    end
  end

  private

  def exchange_rate_params
    params.require(:exchange_rate).permit(:base_currency_id, :target_currency_id, :rate)
  end

  def find_exchange_rate
    @exchange_rate = ExchangeRate.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { status: "fail", error: { message: { FR: "Taux d'echange non trouve", EN: "Exchange rate not found" } } }
  end
end
