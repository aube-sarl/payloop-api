class CreateCurrencies < ActiveRecord::Migration[8.0]
  def change
    create_table :currencies, id: false do |t|
      t.string :code, primary_key: true
      t.string :name
      t.string :symbol

      t.timestamps
    end
  end
end
