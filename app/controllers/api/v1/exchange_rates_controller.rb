class Api::V1::ExchangeRatesController < ApplicationController
  before_action :find_exchange_rate, only: [ :update, :show ]
  before_action :find_exchange_rates_by_currencies, only: [ :update_exchange_rate_by_currencies, :show_exchange_rate_by_currencies ]
  def index
    @exchange_rates = ExchangeRate.includes(:base_currency, :target_currency)

    render json: {
      status: "success",
      data: {
        exchange_rates: @exchange_rates.as_json(
          include: {
            base_currency: { only: [ :id, :code, :name, :country ] },
            target_currency: { only: [ :id, :code, :name, :country ] }
          },
          except: [ :created_at, :updated_at ]
        )
      }
    }
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
    update_exchange_rate
  end

  def update_exchange_rate_by_currencies
    update_exchange_rate
  end


  def show_exchange_rate_by_currencies
    render_exchange_rate
  end

  def show
    render_exchange_rate
  end

  private

  def render_exchange_rate
    render json: { status: "success", data: { exchange_rate: @exchange_rate.as_json(
      include: {
        base_currency: { only: [ :id, :code, :name, :country ] },
        target_currency: { only: [ :id, :code, :name, :country ] }
      },
      except: [ :created_at, :updated_at ]
    ) } }
  end

  def update_exchange_rate
    if @exchange_rate.update(exchange_rate_params)
      render json: { status: "success", data: { exchange_rate: @exchange_rate, message: { FR: "Taux d'echange mis a jour", EN: "Exchange rate update." } } }
    else
      render json: { status: "fail", error: { message: { FR: "Echec de la mise a jour du taux d'echange", EN: "Couldn't update exchange rate" } } }, status: :unprocessable_entity
    end
  end


  def exchange_rate_params
    params.require(:exchange_rate).permit(:base_currency_id, :target_currency_id, :exchange_rate)
  end

  def find_exchange_rate
    @exchange_rate = ExchangeRate.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { status: "fail", error: { message: { FR: "Taux d'echange non trouve", EN: "Exchange rate not found" } } }
  end


  def find_exchange_rates_by_currencies
    base_currency = Currency.find_by(code: params[:base_currency])
    target_currency = Currency.find_by(code: params[:target_currency])

    if base_currency.nil? || target_currency.nil?
      render json: { status: "fail", message: { FR: "Devises invalides", EN: "Invalid currencies" } }, status: :not_found
      return
    end

    @exchange_rate = ExchangeRate.find_by(base_currency_id: base_currency.id, target_currency_id: target_currency.id)

    if @exchange_rate.nil?
      render json: { status: "fail", error: { message: { FR: "Taux d'échange non trouvé", EN: "Exchange rate not found" } } }, status: :not_found
    end
  end
end
