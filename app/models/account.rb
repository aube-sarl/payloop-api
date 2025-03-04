class Account < ApplicationRecord
  validates :currency, presence: true
  validates :linked_phone_number_network, presence: true
  validates :linked_phone_number, presence: true

  belongs_to :user, foreign_key: :user_id
end
