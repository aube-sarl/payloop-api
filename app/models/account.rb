class Account < ApplicationRecord
  validates :currency, :presence: true
  validates :linked_phone_number_provider, presence: true
  validates :linked_phone_number, presence: true

  belongs_to :user, foreign_key: :user_id
  has_many :transactions, foreign_key: :sender_id
  has_many :transactions, foreign_key: :receiver_id

  private

  def capitalize_curreny
    self.currency = self.currency.upcase
  end
end
