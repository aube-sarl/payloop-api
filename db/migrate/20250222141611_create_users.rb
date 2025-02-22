class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :full_name, null: false
      t.string :email, null: false, unique: true
      t.string :phone_number, null: false, unique: true
      t.date :date_of_birth, null: false
      t.string :national_id, null: false, unique: true
      t.string :kyc_type
      t.string :kyc_status, default: "pending" # Can be 'pending', 'verified', or 'rejected'
      t.string :profile_photo_url

      t.timestamps
    end

    add_index :users, :email, unique: true
    add_index :users, :phone_number, unique: true
    add_index :users, :national_id, unique: true
  end
end
