class Api::V1::ExchangeRatesController < ApplicationController
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
end
