class MobileMoneyTransfert < ApplicationRecord
  validates :phone_number, presence: true
  validates :status, presence: true
  validates :provider_reference_id, presence: true
  validates :transaction_type, presence: true
  validates :amount, presence: true
  validates :currency, presence: true
  belongs_to :account, foreign_key: :account_id

  before_save :capitalize_currency

  private

  def capitalize_currency
    self.currency = self.currency.upcase
  end
end
