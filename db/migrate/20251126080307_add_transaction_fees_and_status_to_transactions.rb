class AddTransactionFeesAndStatusToTransactions < ActiveRecord::Migration[8.0]
  def change
    add_column :transactions, :transaction_fees, :decimal
    add_column :transactions, :status, :string
  end
end
