class Api::V1::AccountsController < ApplicationController
  def index
  end

  def create
  end

  private
  def account_params
    params.require(:account).permit(:user_id, :currency, :linked_phone_number_provider, :linked_phone_number)
  end
end
