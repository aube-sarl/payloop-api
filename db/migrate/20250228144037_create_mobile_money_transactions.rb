class CreateMobileMoneyTransactions < ActiveRecord::Migration[8.0]
  def change
    create_table :mobile_money_transactions do |t|
      t.integer :account_id
      t.string :phone_number
      t.string :status
      t.string :provider_reference_id
      t.string :transaction_type
      t.decimal :amount
      t.string :currency

      t.timestamps
    end
    add_foreign_key :mobile_money_transactions, :accounts, column: :account_id
    add_index :mobile_money_transactions, :account_id
  end
end
