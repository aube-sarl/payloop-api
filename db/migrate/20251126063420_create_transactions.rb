class CreateTransactions < ActiveRecord::Migration[8.0]
  def change
    create_table :transactions do |t|
      t.integer :sender_account_id
      t.integer :receiver_account_id
      t.decimal :amount_sent
      t.decimal :amount_received
      t.decimal :sender_initial_balance
      t.decimal :receiver_initial_balance
      t.decimal :exchange_rate

      t.timestamps
    end
    add_foreign_key :transactions, :accounts, column: :sender_account_id
    add_foreign_key :transactions, :accounts, column: :receiver_account_id
    add_index :transactions, :sender_account_id
    add_index :transactions, :receiver_account_id
  end
end
