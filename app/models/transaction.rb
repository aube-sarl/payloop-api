class Transaction < ApplicationRecord
  belongs_to :sender_account, class_name: "Account", foreign_key: "sender_account_id"
  belongs_to :receiver_account, class_name: "Account", foreign_key: "receiver_account_id"
  validates :amount_sent, :amount_received, presence: true, numericality: { greater_than: 0 }
  validates :amount_received, numericality: { greater_than: 0 }
  validates :transaction_fees, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
  validates :status, inclusion: { in: %w[pending completed failed] }, allow_nil: false
  validates :exchange_rate, presence: true
  validates :sender_initial_balance, :receiver_initial_balance, presence: true
  validates :exchange_rate, presence: true
end
