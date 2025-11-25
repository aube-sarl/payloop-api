class Account < ApplicationRecord
  belongs_to :user
  belongs_to :currency, primary_key: "code", foreign_key: "currency_code"

  validates :account_number, presence: true, uniqueness: true
  validates :balance, numericality: { greater_than_or_equal_to: 0 }
end
