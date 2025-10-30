class User < ApplicationRecord
  validates :firstname, :lastname, :email, presence: true
  validates :email, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :middlename, presence: false, default: ""
end
