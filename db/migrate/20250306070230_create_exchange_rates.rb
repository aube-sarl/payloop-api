class CreateExchangeRates < ActiveRecord::Migration[8.0]
  def change
    create_table :exchange_rates do |t|
      t.integer :base_currency_id
      t.integer :target_currency_id
      t.decimal :exchange_rate

      t.timestamps
    end
    add_foreign_key :exchange_rates, :currencies, column: :base_currency_id
    add_index :exchange_rates, :base_currency_id
    add_foreign_key :exchange_rates, :currencies, column: :target_currency_id
    add_index :exchange_rates, :target_currency_id
  end
end
