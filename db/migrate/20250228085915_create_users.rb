class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :email
      t.string :phone_number
      t.string :first_name
      t.string :last_name
      t.string :middle_name
      t.date :birthday
      t.string :profile_url
      t.string :nationality

      t.timestamps
    end
  end
end
