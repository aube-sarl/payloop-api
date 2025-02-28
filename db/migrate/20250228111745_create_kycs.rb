class CreateKycs < ActiveRecord::Migration[8.0]
  def change
    create_table :kycs do |t|
      t.integer :user_id
      t.string :id_card_type
      t.string :id_Card_photo_url
      t.string :verification_status

      t.timestamps
    end
    add_foreign_key :kycs, :users, column: :user_id
    add_index :kycs, :user_id
  end
end
