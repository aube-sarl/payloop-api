class CreateAccounts < ActiveRecord::Migration[8.0]
  def change
    create_table :accounts do |t|
      t.integer :user_id, null: false
      t.string :account_number, null: false
      t.string :currency_code, null: false
      t.decimal :balance, precision: 15, scale: 2, default: 0.0, null: false
      t.timestamps
    end
    add_index :accounts, :user_id
    add_index :accounts, :account_number, unique: true
    add_index :accounts, :currency_code
    add_foreign_key :accounts, :users, column: :user_id
    add_foreign_key :accounts, :currencies, column: :currency_code, primary_key: "code"
  end
end
