class User < ApplicationRecord
  before_save :set_defaults
  validates :firstname, :lastname, :email, presence: true
  validates :email, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

  private

  def set_defaults
    self.middlename ||= ""
  end
end
