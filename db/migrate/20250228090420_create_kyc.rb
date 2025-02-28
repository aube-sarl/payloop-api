class CreateKyc < ActiveRecord::Migration[8.0]
  def change
    create_table :kycs do |t|
      t.integer :user_id
      t.string :id_card_type
      t.string :id_Card_photo_url
      t.string :verification_status

      t.timestamps
    end
  end
end
