module AccountsHelper
  def create_account
    @account = Account.new(account_params)
    if @account.save
      render json: { data: { account: @account }, status: :created, message: "Account created successfully!" }, status: :created
    else
      render json: { error: { message: @account.errors.full_messages }, status: :unprocessable_entity }, status: :unprocessable_entity
    end
  end
end
