class Currency < ApplicationRecord
  validates :code, presence: true, uniqueness: true
  validates :name, presence: true
  validates :symbol, presence: true
  validates :exchange_rate, presence: true
end
