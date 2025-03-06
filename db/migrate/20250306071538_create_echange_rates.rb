class CreateEchangeRates < ActiveRecord::Migration[8.0]
  def change
    create_table :echange_rates do |t|
      t.timestamps
    end
  end
end
