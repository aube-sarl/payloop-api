class Account < ApplicationRecord
  validates :currency, :presence: true
  validates :linked_phone_number_provider, presence: true
  validates :linked_phone_number, presence: true

  belongs_to :user, foreign_key: :user_id
  has_many :transactions, foreign_key: :sender_id
  has_many :transactions, foreign_key: :receiver_id

  before_save: :capitalize_curreny
  before_create: :set_balance_to_zero

  private

  def capitalize_curreny
    self.currency = self.currency.upcase
  end

  def set_balance_to_zero
    self.balance = 0
  end
end
