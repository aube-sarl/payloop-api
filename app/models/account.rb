class Account < ApplicationRecord
  validates :currency, presence: true
  validates :linked_phone_number_network, presence: true
  validates :linked_phone_number, presence: true

  belongs_to :user, foreign_key: :user_id

  before_save :verify_if_currency_exists, :initialize_balance

  private

  def initialize_balance
    self.balance = 0
  end

  def verify_if_currency_exists
    self.currency = self.currency.upcase
    unless Currency.exists?(code: self.currency)
      errors.add(:currency, "does not exist")
      throw(:abort)
    end
  end
end
