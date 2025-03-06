class Api::V1::CurrenciesController < ApplicationController
  def index
    @currencies = Currency.all

    render json: { satus: "success", data: { currencies: @currencies } }
  end

  def create
    @currency = Currency.new(currency_params)

    if @currency.save
      render json: { status: "success", data: { currency: @currency, messsage: { FR: "Devise ajoutee avec succes", EN: "Currency successfully added" } } }, status: :created
    else
      render json: { status: "fail", error: { message: { FR: "Devise non ajoutee", EN: "Currency not added" } } }, status: :unprocessable_entity
    end
  end

  private

  def currency_params
    params.require(:currency).permit(:code, :name, :country)
  end
end
