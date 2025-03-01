class ExchangeRate < ApplicationRecord
  validates :base_currency, presence: true
  validates :target_currency, presence: true
  validates :rate, presence: true

  before_save :capitalize_currencies

  private

  def capitalize_currencies
    self.base_currency = self.base_currency.upcase
    self.target_currency = self.target_currency.upcase
  end
end
