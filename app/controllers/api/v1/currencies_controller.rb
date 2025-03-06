class Api::V1::CurrenciesController < ApplicationController
  def index
    @currencies = Currency.all

    render json: {satus: "success", data: {}}
  end
end
