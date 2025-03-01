class Transaction < ApplicationRecord
  validates :amount_sent, presence: true
  validates :amount_received, presence: true
  validates :amount_received, presence: true
  validates :received_currency, presence: true
  validates :fees, presence: true
  validates :fees_currency, presence: true
  validates :transaction_type, presence: true

  belongs_to :account, foreign_key: :sender_id
  belongs_to :account, foreign_key: :receiver_id
end
