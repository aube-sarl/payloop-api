class AddExchangeRateToCurrencies < ActiveRecord::Migration[8.0]
  def change
    add_column :currencies, :exchange_rate, :decimal
  end
end
