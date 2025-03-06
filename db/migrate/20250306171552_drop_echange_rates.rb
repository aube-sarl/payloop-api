class DropEchangeRates < ActiveRecord::Migration[8.0]
  def change
    drop_table :echange_rates
  end
end
