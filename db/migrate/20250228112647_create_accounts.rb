class CreateAccounts < ActiveRecord::Migration[8.0]
  def change
    create_table :accounts do |t|
      t.integer :user_id
      t.decimal :balance
      t.string :currency
      t.string :linked_phone_number_provider
      t.string :linked_phone_number

      t.timestamps
    end
    add_foreign_key :accounts, :users, column: :user_id
    add_index :accounts, :user_id
  end
end
