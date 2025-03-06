class ExchangeRate < ApplicationRecord
  belongs_to :base_currency, class_name: "Currency", foreign_key: "base_currency_id"
  belongs_to :target_currency, class_name: "Currency", foreign_key: "target_currency_id"

  validates :exchange_rate, presence: true, numericality: { greater_than: 0 }
end
