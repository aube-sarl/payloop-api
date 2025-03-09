class MobileMoneyTransaction < ApplicationRecord
  validates :amount, :currency, :fees, :provider_reference_id, :transaction_type, :mobile_money_provider, :phone_number, presence: true
  validates :amount, :fees, numericality: { greater_than: 0 }
  validates :fees, numericality: { greater_than_or_equal_to: 0 }

  belongs_to :account, foreign_key: :account_id

  before_create :initialize_status

  private

  def initialize_status
    self.status = "pending"
  end
end
