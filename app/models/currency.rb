class Currency < ApplicationRecord
  validates :code, presence: true, uniqueness: true
  validates :name, presence: true
  validates :country, presence: true

  has_many :exchange_rates_as_base, class_name: "ExchangeRate", foreign_key: "base_currency_id", dependent: :destroy
  has_many :exchange_rates_as_target, class_name: "ExchangeRate", foreign_key: "target_currency_id", dependent: :destroy

  has_many :target_currencies, through: :exchange_rates_as_base, source: :target_currency
  has_many :base_currencies, through: :exchange_rates_as_target, source: :base_currency
end
