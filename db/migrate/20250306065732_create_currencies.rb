class CreateCurrencies < ActiveRecord::Migration[8.0]
  def change
    create_table :currencies do |t|
      t.string :code, unique: true
      t.string :name
      t.string :country

      t.timestamps
    end
  end
end
