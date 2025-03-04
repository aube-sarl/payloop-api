class CreateTransactions < ActiveRecord::Migration[8.0]
  def change
    create_table :transactions do |t|
      t.integer :sender_id
      t.decimal :amount_sent
      t.string :currency_sent
      t.integer :receiver_id
      t.decimal :amount_received
      t.string :currency_received
      t.decimal :fees
      t.string :currency_fees
      t.string :transaction_type

      t.timestamps
    end
    add_foreign_key :transactions, :accounts, column: :sender_id
    add_foreign_key :transactions, :accounts, column: :receiver_id
    add_index :transactions, :sender_id
    add_index :transactions, :receiver_id
  end
end
