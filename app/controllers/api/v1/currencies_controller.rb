class Api::V1::CurrenciesController < ApplicationController
  def index
    @currencies = Currency.all

    render json: {satus: "success", data: {currencies: @currencies}}
  end

  def create

  end

  private

  def currency_params
    params.require(:currency).permit(:code, :name)
  end

end
