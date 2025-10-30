class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :firstname
      t.string :lastname
      t.string :middlename
      t.string :emai
      t.string :phone_number

      t.timestamps
    end
  end
end
