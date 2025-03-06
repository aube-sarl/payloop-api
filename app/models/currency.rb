class Currency < ApplicationRecord
  validates :code, presence: true
  validates :name, presence: true
  validates :country, presence: true

  before_save :validate_currency_code

  private

  def validate_currency_code
    self.code = self.code.upcase
  end
end
