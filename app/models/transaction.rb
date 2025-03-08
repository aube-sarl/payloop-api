class Transaction < ApplicationRecord
  validates :amount_sent, :currency_sent, :amount_received, :currency_received, :fees, :currency_fees, :transaction_type, presence: true
  validates :amount_sent, :amount_received, :fees, numericality: { greater_than: 0 }

  belongs_to :sender, class_name: "Account", foreign_key: "sender_id"
  belongs_to :receiver, class_name: "Account", foreign_key: "receiver_id"
end
