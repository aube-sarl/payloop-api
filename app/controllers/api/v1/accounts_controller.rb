class Api::V1::AccountsController < ApplicationController
  def index
    @accounts = Account.where({ user_id: params(:user_id) })

    render json: { status: "success", data: { accounts: @accounts } }
  end
end
