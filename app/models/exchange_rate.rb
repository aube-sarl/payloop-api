class ExchangeRate < ApplicationRecord
  validates :base_currency, presence: true
  validates :target_currency, presence: true
  validates :rate, presence: true
end
